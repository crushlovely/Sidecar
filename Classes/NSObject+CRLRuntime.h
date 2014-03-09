#import <Foundation/Foundation.h>
#import <objc/runtime.h>


typedef NS_ENUM(uintptr_t, CRLAssociationPolicy) {
    CRLAssociatedObjectPolicyAssign = OBJC_ASSOCIATION_ASSIGN,
    CRLAssociatedObjectPolicyRetain = OBJC_ASSOCIATION_RETAIN_NONATOMIC,
    CRLAssociatedObjectPolicyCopy = OBJC_ASSOCIATION_COPY_NONATOMIC
};


@interface NSObject (CRLRuntime)

// These are Objective-C wrappers for the runtime's C-level Associative References API.
// See http://developer.apple.com/library/ios/#documentation/cocoa/conceptual/objectivec/Chapters/ocAssociativeReferences.html
-(void)crl_setAssociatedObject:(id)object forKey:(void *)key policy:(CRLAssociationPolicy)policy;
-(id)crl_associatedObjectForKey:(void *)key;
-(void)crl_removeAssociatedObjectForKey:(void *)key;

// Removes all associated objects from the target object.
// Be careful in calling this as you can't know the other clients of the
// Associative References API; you may remove associations from some unrelated piece of code.
-(void)crl_removeAllAssociatedObjects;

@end
