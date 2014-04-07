//
//  CRLSystemSoundSpec.m
//  Sidecar
//
//  Created by Tim Clem on 4/7/14.
//  Copyright (c) 2014 Crush & Lovely. All rights reserved.
//

#import "CRLSystemSound.h"
#import <AVFoundation/AVAudioSession.h>

SpecBegin(CRLSystemSound)

NSBundle *currentBundle = [NSBundle bundleForClass:self.class];
NSURL *soundURL = [currentBundle URLForResource:@"shield" withExtension:@"caf"];
NSString *soundPath = [NSString stringWithUTF8String:soundURL.fileSystemRepresentation];

beforeAll(^{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];

    NSError *error;
    if(![audioSession setActive:NO error:&error]) {
        NSLog(@"Error deactivating audio session: %@", error);
        return;
    }

    if(![audioSession setCategory:AVAudioSessionCategoryPlayback error:&error]) {
        NSLog(@"Error setting audio session category: %@", error);
        return;
    }

    if(![audioSession setActive:YES error:&error]) {
        NSLog(@"Error reactivating audio session: %@", error);
        return;
    }
});

describe(@"creation", ^{
    it(@"should return nil for bogus resources", ^{
        expect([[CRLSystemSound alloc] initWithFileURL:[NSURL fileURLWithPath:@"/blah.caf"]]).to.beNil();
        expect([[CRLSystemSound alloc] initWithFileAtPath:@"blah.caf"]).to.beNil();
        expect([[CRLSystemSound alloc] initWithResource:@"blah" extension:@"caf"]).to.beNil();

        expect([CRLSystemSound playFileAtPath:@"blah.caf"]).to.beNil();
        expect([CRLSystemSound playResource:@"blah" extension:@"caf"]).to.beNil();

        expect([[CRLSystemSound alloc] initWithFileURL:nil]).to.beNil();
    });

    it(@"should create an instance for valid resources", ^{
        // Can't test ...Resource:extension: methods here.. we're not in the main bundle
        expect([[CRLSystemSound alloc] initWithFileURL:soundURL]).toNot.beNil();
        expect([[CRLSystemSound alloc] initWithFileAtPath:soundPath]).toNot.beNil();

        expect([CRLSystemSound playFileAtPath:soundPath]).toNot.beNil();
    });

    it(@"should create instances that are not yet playing", ^{
        expect([[CRLSystemSound alloc] initWithFileURL:soundURL].playing).to.beFalsy();
    });
});

describe(@"playing", ^{
    it(@"should call the block on completion of the sound", ^AsyncBlock {
        CRLSystemSound *sound = [[CRLSystemSound alloc] initWithFileURL:soundURL];
        [sound playWithCompletion:^(CRLSystemSound *_sound) {
            expect(sound).to._beIdenticalTo((__bridge void *)(_sound));
            expect(sound.playing).to.beFalsy();
            done();
        }];

        expect(sound.playing).to.beTruthy();
    });

    it(@"should handle fire-and-forget calling", ^AsyncBlock {
        [CRLSystemSound playFileAtPath:soundPath completion:^(CRLSystemSound *sound) {
            expect(sound).toNot.beNil();
            expect(sound.playing).to.beFalsy();

            done();
        }];
    });

    it(@"should continue to work after being stopped", ^AsyncBlock {
        CRLSystemSound *sound = [[CRLSystemSound alloc] initWithFileURL:soundURL];
        [sound play];
        expect(sound.playing).to.beTruthy();

        [sound stop];
        expect(sound.playing).to.beFalsy();

        [sound playWithCompletion:^(CRLSystemSound *sound __unused) {
            done();
        }];
        expect(sound.playing).to.beTruthy();
    });

    it(@"should ignore requests to play while already playing", ^ {
        CRLSystemSound *sound = [[CRLSystemSound alloc] initWithFileURL:soundURL];
        [sound play];

        __block NSObject *sentinel = [[NSObject alloc] init];
        [sound playWithCompletion:^(CRLSystemSound *_sound __unused) {
            sentinel = nil;
        }];

        sleep(2);
        expect(sentinel).toNot.beNil();
    });
});

SpecEnd
