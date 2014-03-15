#import <Foundation/Foundation.h>

NS_INLINE NSURL *CRLDocumentsDirectory()
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

NS_INLINE NSURL *CRLCachesDirectory()
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}