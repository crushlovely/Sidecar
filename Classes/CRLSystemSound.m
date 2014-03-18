//
//  SBSystemSound.m
//  CRLLib
//
//  Created by Tim Clem on 3/15/12.
//  Copyright (c) 2012 Socialbomb. All rights reserved.
//

#if defined(__has_feature) && __has_feature(objc_arc)
    #error CRLSystemSound.m must be compiled without ARC; add -fno-objc-arc to the compiler arguments for this file in the "Build Phases" section of your project settings
#endif

#import <AudioToolbox/AudioToolbox.h>
#import "CRLSystemSound.h"

@interface CRLSystemSound () {
    SystemSoundID soundID;
}

@property (nonatomic, retain) NSURL *fileURL;

@property (nonatomic, assign, readwrite) BOOL playing;
@property (nonatomic, copy) void (^userBlock)(CRLSystemSound *);

-(CRLSystemSound *)initWithFileURL:(NSURL *)URL;

-(OSStatus)createSystemSound;
-(void)disposeOfSystemSound;

-(void)playbackDidComplete;

@end


// Our completion callback, added before playing a sound
static void SBSystemSoundCompletionCallback(SystemSoundID soundID, void *clientData)
{
    // Fetch the object that finished and let it know what's up
    CRLSystemSound *sound = (CRLSystemSound *)clientData;
    [sound playbackDidComplete];
}


@implementation CRLSystemSound

+(CRLSystemSound *)playFileAtPath:(NSString *)path completion:(void (^)(CRLSystemSound *))completion
{
    CRLSystemSound *sound = [[[self alloc] initWithFileAtPath:path] autorelease];
    [sound playWithCompletion:completion];
    return sound;
}

+(CRLSystemSound *)playFileAtPath:(NSString *)path
{
    return [self playFileAtPath:path completion:nil];
}

+(CRLSystemSound *)playResource:(NSString *)name extension:(NSString *)extension completion:(void (^)(CRLSystemSound *))completion
{
    CRLSystemSound *sound = [[[self alloc] initWithResource:name extension:extension] autorelease];
    [sound playWithCompletion:completion];
    return sound;
}

+(CRLSystemSound *)playResource:(NSString *)name extension:(NSString *)extension
{
    return [self playResource:name extension:extension completion:nil];
}

// Completion blocks and stopping vibrations doesn't make much sense,
// so there's no use in even wrapping this up in an object.
+(void)vibrateOrBeep:(BOOL)flag
{
    if(flag) {
        #if TARGET_IPHONE_SIMULATOR
        // The simulator doesn't do anything when told to vibrate,
        // but it will let us use kSystemSoundID_UserPreferredAlert
        // from OSX land. Its definition is hidden behind a
        // conditonal, but its value is in AudioServices.h
        AudioServicesPlayAlertSound(0x00001000);
        #else
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
        #endif
    }
    else
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

-(CRLSystemSound *)initWithFileURL:(NSURL *)URL
{
    self = [super init];
    if(self) {
        self.fileURL = URL;
        
        [self createSystemSound];
        
        // TODO: iron out if this is logical behavior, or totally unexpected...
        if(!soundID)
            return nil;
    }
    
    return self;
}

-(OSStatus)createSystemSound
{
    soundID = 0;
    OSStatus err = AudioServicesCreateSystemSoundID((CFURLRef)self.fileURL, &soundID);
    
    if(err == kAudioServicesNoError) {
        #if TARGET_IPHONE_SIMULATOR
        // The simulator obeys the IsUISound property on SystemSoundIDs, which means
        // that if "Play user interface sound effects" in System Preferences is off, it
        // not only doesn't play the sound, it also never calls the completion block.
        // So for the simulator, we set that property to zero, which causes it to ignore
        // the setting.
        UInt32 propertyValue = 0;
        AudioServicesSetProperty(kAudioServicesPropertyIsUISound, sizeof(SystemSoundID), &soundID, sizeof(UInt32), &propertyValue);
        #endif
    }
    else
        DDLogError(@"Error creating system sound for %@. Status code: %d", self.fileURL, (int)err);
    
    return err;
}

-(CRLSystemSound *)initWithFileAtPath:(NSString *)path
{
    return [self initWithFileURL:[NSURL fileURLWithPath:path]];
}

-(CRLSystemSound *)initWithResource:(NSString *)name extension:(NSString *)extension
{
    return [self initWithFileURL:[[NSBundle mainBundle] URLForResource:name withExtension:extension]];
}

-(void)playWithCompletion:(void (^)(CRLSystemSound *))completion
{
    if(self.playing)
        return;
    
    self.playing = YES;
    
    self.userBlock = completion;
    
    OSStatus err;
    
    // Recreate the SystemSoundID if it's gone (which means we must have been -stop'd)
    if(!soundID) {
        err = [self createSystemSound];
        if(err != kAudioServicesNoError) {
            // This probably shouldn't happen, but we shouldn't abort the completion
            // callback if it does.
            if(completion) completion(self);
            return;
        }
    }
    
    // Add our completion listener.
    // The -retain ensures that we're not dealloc'd during playback.
    // There is a balancing -release in playbackDidComplete and also in -stop,
    // which may abort playback without triggering the callback.
    err = AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, SBSystemSoundCompletionCallback, (void *)[self retain]);
    if(err == kAudioServicesNoError) {
        // All good? Play it.
        AudioServicesPlaySystemSound(soundID);
    }
    else {
        // Abandon ship if our handler didn't get added for some reason.
        [self release];  // Balance the -retain, since the completion callback won't be called
        
        DDLogError(@"Error adding completion handler to system sound. Status code: %d", (int)err);
        if(completion) completion(self);
    }
    
    // TODO: ensure that we ALWAYS call back, even if this sound gets interrupted.
}

-(void)play
{
    [self playWithCompletion:nil];
}

// This is called by SBSystemSoundCompletionCallback, the completion handler we add before playback
-(void)playbackDidComplete
{
    self.playing = NO;
    
    // Remove the handler. Another will be added if the sound is played again.
    // It's important to do this before calling the user's completion block,
    // in case that tries to play the sound again, which would add another handler
    // which this would promptly remove.
    AudioServicesRemoveSystemSoundCompletion(soundID);
    
    if(self.userBlock)
        self.userBlock(self);
    
    [self release];  // Balance the -retain from adding the completion handler
}

-(void)disposeOfSystemSound
{
    AudioServicesRemoveSystemSoundCompletion(soundID);
    AudioServicesDisposeSystemSoundID(soundID);
    soundID = 0;
}

-(void)stop
{
    // Seems to be no explicit way to kill a system sound... disposing of it works though!
    if(self.playing) {
        [self disposeOfSystemSound];
        [self release];  // Balance the -retain we triggered when adding the completion handler, since it won't be called now
        self.playing = NO;
    }
}

-(void)dealloc
{
    [self disposeOfSystemSound];
    self.userBlock = nil;
    
    [super dealloc];
}

@end
