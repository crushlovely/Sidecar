#import "NSObject+CRLRuntime.h"
#import <objc/runtime.h>

NS_INLINE objc_AssociationPolicy CRLAssociationPolicyToObjcAssociationPolicy(CRLAssociationPolicy crlPolicy) {
    switch(crlPolicy) {
        case CRLAssociatedObjectPolicyAssign: return OBJC_ASSOCIATION_ASSIGN;
        case CRLAssociatedObjectPolicyCopy: return OBJC_ASSOCIATION_COPY_NONATOMIC;
        case CRLAssociatedObjectPolicyStrong:
        default:
            return OBJC_ASSOCIATION_RETAIN_NONATOMIC;
    }
}

@implementation NSObject (CRLRuntime)

-(void)crl_associateObject:(id)object withKey:(void *)key policy:(CRLAssociationPolicy)policy
{
    objc_setAssociatedObject(self, key, object, CRLAssociationPolicyToObjcAssociationPolicy(policy));
}

-(id)crl_objectAssociatedWithKey:(void *)key
{
    return objc_getAssociatedObject(self, key);
}

-(void)crl_removeObjectAssociatedWithKey:(void *)key
{
    [self crl_associateObject:nil withKey:key policy:CRLAssociatedObjectPolicyAssign];
}

@end
