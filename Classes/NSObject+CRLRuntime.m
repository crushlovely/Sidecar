#import "NSObject+CRLRuntime.h"

@implementation NSObject (CRLRuntime)

-(void)crl_setAssociatedObject:(id)object forKey:(void *)key policy:(CRLAssociationPolicy)policy
{
    objc_setAssociatedObject(self, key, object, (objc_AssociationPolicy)policy);
}

-(id)crl_associatedObjectForKey:(void *)key
{
    return objc_getAssociatedObject(self, key);
}

-(void)crl_removeAssociatedObjectForKey:(void *)key
{
    [self crl_setAssociatedObject:nil forKey:key policy:CRLAssociatedObjectPolicyAssign];
}

-(void)crl_removeAllAssociatedObjects
{
    objc_removeAssociatedObjects(self);
}

@end
