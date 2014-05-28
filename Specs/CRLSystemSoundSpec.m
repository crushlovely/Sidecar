// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "CRLSystemSound.h"
#import <AVFoundation/AVFoundation.h>

SpecBegin(CRLSystemSound)

NSBundle *currentBundle = [NSBundle bundleForClass:self.class];
NSURL *soundURL = [currentBundle URLForResource:@"shield" withExtension:@"caf"];
NSString *soundPath = [NSString stringWithUTF8String:soundURL.fileSystemRepresentation];

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

#ifndef CI  // For some reason these fail in Travis. Sandboxing stuff, maybe?
        expect([[CRLSystemSound alloc] initWithFileAtPath:soundPath]).toNot.beNil();

        expect([CRLSystemSound playFileAtPath:soundPath]).toNot.beNil();
#endif
    });

    it(@"should create instances that are not yet playing", ^{
        expect([[CRLSystemSound alloc] initWithFileURL:soundURL].playing).to.beFalsy();
    });
});

#ifndef CI  // Unfortunately these tests don't work in Travis land. Maybe one day soon...

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

#endif

SpecEnd
