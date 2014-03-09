#import <Foundation/Foundation.h>

// This is a simple wrapper around AudioServicesCreateSystemSoundID and
// AudioServicesPlaySystemSound. You should read the docs surrounding
// limitations on those, but the gist is that you should only use this
// interface for short sound effects (<30 seconds) in caf, wav, or aif
// format.
//
// Instances retain themselves so that they can continue playing until
// they complete. That is, you can treat the methods of this class
// as fire-and-forget; you don't have to hold on to the instances
// after calling a play method unless you may need to stop
// them before they finish or poll their playing state.
//
// Attempting to play an instance that is already playing has no effect,
// but you may call a play method on a previously completed SBSystemSound
// to play it again.
//
// Note that if the user's device is muted, the sound will not play.
// In this case, the completion block will be called instantly rather
// than waiting the duration of the sound.
//
// Also of note for developers is that this class has specific hooks
// to work in the simulator regardless of your sound settings in
// System Preferences. Also +playVibrationOrBeep:YES will play
// the default OSX alert sound in the simulator.

@interface CRLSystemSound : NSObject

// Triggers the device's vibration function, or optionally plays
// a system alert beep on devices that do not support vibration.
+(void)vibrateOrBeep:(BOOL)beepOnUnsupportedDevices;

// These class-level methods and the associated -init methods will return
// nil if the given path or resource could not be loaded.

+(CRLSystemSound *)playFileAtPath:(NSString *)path completion:(void (^)(CRLSystemSound *sound))completion;
+(CRLSystemSound *)playFileAtPath:(NSString *)path;

// The resource initializers retrieve the path for the given resource
// from [NSBundle mainBundle].
+(CRLSystemSound *)playResource:(NSString *)name extension:(NSString *)extension completion:(void (^)(CRLSystemSound *sound))completion;
+(CRLSystemSound *)playResource:(NSString *)name extension:(NSString *)extension;

-(CRLSystemSound *)initWithFileAtPath:(NSString *)path;
-(CRLSystemSound *)initWithResource:(NSString *)name extension:(NSString *)extension;

// Calling these on an instance that's already playing will have no effect.
-(void)playWithCompletion:(void (^)(CRLSystemSound *sound))completion;
-(void)play;  // Same as above with nil completion block

// YES if the sound is currently playing
@property (nonatomic, assign, readonly, getter=isPlaying) BOOL playing;

// Stops playback of the sound, or does nothing if it is not playing.
// The completion block will not be called.
-(void)stop;

@end
