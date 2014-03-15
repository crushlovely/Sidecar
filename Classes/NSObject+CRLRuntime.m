#import "NSObject+CRLRuntime.h"

@implementation NSObject (CRLRuntime)

-(void)crl_associateObject:(id)object withKey:(void *)key policy:(CRLAssociationPolicy)policy
{
    objc_setAssociatedObject(self, key, object, (objc_AssociationPolicy)policy);
}

-(id)crl_objectAssociatedWithKey:(void *)key
{
    return objc_getAssociatedObject(self, key);
}

-(void)crl_removeObjectAssociatedWithKey:(void *)key
{
    [self crl_associateObject:nil withKey:key policy:CRLAssociatedObjectPolicyAssign];
}

-(void)crl_removeAllAssociatedObjects
{
    objc_removeAssociatedObjects(self);
}

@end
