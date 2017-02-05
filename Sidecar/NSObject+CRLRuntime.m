// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "NSObject+CRLRuntime.h"
#import <objc/runtime.h>

NS_INLINE objc_AssociationPolicy CRLAssociationPolicyToObjCAssociationPolicy(CRLAssociationPolicy crlPolicy) {
    switch(crlPolicy) {
        case CRLAssociationPolicyAssign: return OBJC_ASSOCIATION_ASSIGN;
        case CRLAssociationPolicyCopy: return OBJC_ASSOCIATION_COPY_NONATOMIC;
        case CRLAssociationPolicyStrong:
        default:
            return OBJC_ASSOCIATION_RETAIN_NONATOMIC;
    }
}

@implementation NSObject (CRLRuntime)

-(void)crl_associateObject:(id)object withKey:(const void *)key policy:(CRLAssociationPolicy)policy
{
    objc_setAssociatedObject(self, key, object, CRLAssociationPolicyToObjCAssociationPolicy(policy));
}

-(id)crl_objectAssociatedWithKey:(const void *)key
{
    return objc_getAssociatedObject(self, key);
}

-(void)crl_removeObjectAssociatedWithKey:(const void *)key
{
    [self crl_associateObject:nil withKey:key policy:CRLAssociationPolicyAssign];
}

@end
