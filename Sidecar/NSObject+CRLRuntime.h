// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <Foundation/Foundation.h>

/**
 Defines the memory semantics for an associated object.
 */
typedef NS_ENUM(NSInteger, CRLAssociationPolicy) {
    /**
     Synonymous with a (nonatomic, assign) property. Note that for objects, this is *not* a
     zeroing-weak reference; it is akin to __unsafe_unretained. Zeroing-weak reference
     semantics (that found in weak properties) are not available for associated objects.
     */
    CRLAssociationPolicyAssign,

    /**
     Synonymous with a (nonatomic, strong) property.
     */
    CRLAssociationPolicyStrong,

    /**
     Synonymous with a (nonatomic, copy) property.
     */
    CRLAssociationPolicyCopy,
};


@interface NSObject (CRLRuntime)

// These are Objective-C wrappers for the runtime's C-level Associative References API.
// See http://developer.apple.com/library/ios/#documentation/cocoa/conceptual/objectivec/Chapters/ocAssociativeReferences.html

/**
 Uses the runtime Associative References functionality to associate the given object with
 the receiver, using the semantics specified by policy.
 */
-(void)crl_associateObject:(nullable id)object withKey:(nonnull const void *)key policy:(CRLAssociationPolicy)policy NS_SWIFT_NAME(associate(object:forKey:policy:));

/**
 Retrieves an object previously associated with the receiver through the Associative
 References functionality. If no object is associated with the given key, returns nil.
 */
-(nullable id)crl_objectAssociatedWithKey:(nonnull const void *)key NS_SWIFT_NAME(associatedObject(forKey:));

/**
 Removes an object previously associated with the receiver through the Associative
 References functionality.
 */
-(void)crl_removeObjectAssociatedWithKey:(nonnull const void *)key NS_SWIFT_NAME(removeAssociatedObject(forKey:));

@end
