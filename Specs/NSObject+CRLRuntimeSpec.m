// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "NSObject+CRLRuntime.h"

SpecBegin(NSObject_CRLRuntime)

describe(@"associated objects wrapper", ^{
    it(@"should associate objects with other objects", ^{
        NSObject *obj = [[NSObject alloc] init];
        NSObject *associated = [[NSObject alloc] init];

        [obj crl_associateObject:associated withKey:@"testKey" policy:CRLAssociatedObjectPolicyStrong];

        expect([obj crl_objectAssociatedWithKey:@"testKey"]).to.beIdenticalTo(associated);
    });

    it(@"should be able to remove associated objects", ^{
        NSObject *obj = [[NSObject alloc] init];
        NSObject *associated = [[NSObject alloc] init];
        [obj crl_associateObject:associated withKey:@"testKey" policy:CRLAssociatedObjectPolicyStrong];
        [obj crl_removeObjectAssociatedWithKey:@"testKey"];

        expect([obj crl_objectAssociatedWithKey:@"testKey"]).to.beNil();
    });

    it(@"should copy associated objects if requested", ^{
        NSObject *obj = [[NSObject alloc] init];
        NSMutableString *associated = [NSMutableString stringWithString:@"test"];
        [obj crl_associateObject:associated withKey:@"testKey" policy:CRLAssociatedObjectPolicyCopy];

        [associated appendString:@"y test test"];
        expect([obj crl_objectAssociatedWithKey:@"testKey"]).to.equal(@"test");
    });

    it(@"should create weak references if requested", ^{
        NSObject *obj = [[NSObject alloc] init];
        NSObject *associated = [[NSObject alloc] init];
        __weak NSObject *weakAssociated = associated;

        [obj crl_associateObject:associated withKey:@"testKey" policy:CRLAssociatedObjectPolicyAssign];
        associated = nil;

        // If the association was really weak, weakAssociated should now be nil, as associated was the
        // only living strong reference to it.
        expect(weakAssociated).to.beNil();
    });

    it(@"should create strong references if requested", ^{
        NSObject *obj = [[NSObject alloc] init];
        NSObject *associated = [[NSObject alloc] init];
        __weak NSObject *weakAssociated = associated;

        [obj crl_associateObject:associated withKey:@"testKey" policy:CRLAssociatedObjectPolicyStrong];
        associated = nil;

        // If the association was really strong, weakAssociated should still be non-nil.
        expect(weakAssociated).toNot.beNil();
    });
});

SpecEnd