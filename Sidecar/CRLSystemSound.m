// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <AudioToolbox/AudioToolbox.h>
#import "CRLSystemSound.h"

@interface CRLSystemSound ()

@property (nonatomic, retain) NSURL *fileURL;

@property (nonatomic, assign, readwrite) BOOL playing;
@property (nonatomic, copy) void (^userBlock)(CRLSystemSound *);

@property (nonatomic, assign) SystemSoundID soundID;

@end


@implementation CRLSystemSound

+(CRLSystemSound *)playFileAtPath:(NSString *)path completion:(void (^)(CRLSystemSound *))completion
{
    CRLSystemSound *sound = [[self alloc] initWithFileAtPath:path];
    [sound playWithCompletion:completion];
    return sound;
}

+(CRLSystemSound *)playFileAtPath:(NSString *)path
{
    return [self playFileAtPath:path completion:nil];
}

+(CRLSystemSound *)playResource:(NSString *)name extension:(NSString *)extension completion:(void (^)(CRLSystemSound *))completion
{
    CRLSystemSound *sound = [[self alloc] initWithResource:name extension:extension];
    [sound playWithCompletion:completion];
    return sound;
}

+(CRLSystemSound *)playResource:(NSString *)name extension:(NSString *)extension
{
    return [self playResource:name extension:extension completion:nil];
}

// Completion blocks and stopping vibrations doesn't make much sense,
// so there's no use in even wrapping this up in an object.
+(void)vibrateOrBeep:(BOOL)beepOnUnsupportedDevices
{
    if(beepOnUnsupportedDevices) {
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

        if(!_soundID)
            return nil;
    }

    return self;
}

-(OSStatus)createSystemSound
{
    _soundID = 0;
    OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)self.fileURL, &_soundID);

    if(err == kAudioServicesNoError) {
#if TARGET_IPHONE_SIMULATOR
        // The simulator obeys the IsUISound property on SystemSoundIDs, which means
        // that if "Play user interface sound effects" in System Preferences is off, it
        // not only doesn't play the sound, it also never calls the completion block.
        // So for the simulator, we set that property to zero, which causes it to ignore
        // the setting.
        UInt32 propertyValue = 0;
        AudioServicesSetProperty(kAudioServicesPropertyIsUISound, sizeof(SystemSoundID), &_soundID, sizeof(UInt32), &propertyValue);
#endif
    }
    else
        NSLog(@"[CRLSystemSound] Error creating system sound for %@. Status code: %d", self.fileURL, (int)err);

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

    // Recreate the SystemSoundID if it's gone (which means we must have been -stop'd)
    if(!_soundID) {
        OSStatus err = [self createSystemSound];
        if(err != kAudioServicesNoError) {
            // This probably shouldn't happen, but we shouldn't abort the completion
            // callback if it does.
            [self playbackDidComplete];
            return;
        }
    }

    AudioServicesPlaySystemSoundWithCompletion(_soundID, ^{
        [self playbackDidComplete];
    });
}

-(void)play
{
    [self playWithCompletion:nil];
}

-(void)playbackDidComplete
{
    self.playing = NO;

    if(self.userBlock) {
        void (^localUserBlock)(CRLSystemSound *) = self.userBlock;
        self.userBlock = nil;

        dispatch_async(dispatch_get_main_queue(), ^{
            localUserBlock(self);
        });
    }
}

-(void)disposeOfSystemSound
{
    AudioServicesDisposeSystemSoundID(_soundID);
    _soundID = 0;
}

-(void)stop
{
    // Seems to be no explicit way to kill a system sound... disposing of it works though!
    if(self.playing) {
        self.userBlock = nil;  // Prevent the callback

        [self disposeOfSystemSound];
        self.playing = NO;
    }
}

-(void)dealloc
{
    self.userBlock = nil;
    [self disposeOfSystemSound];
}

@end
