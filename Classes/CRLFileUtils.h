#import <Foundation/Foundation.h>

/**
 Returns the URL for the user's Documents directory.
 */
NS_INLINE NSURL *CRLDocumentsDirectory()
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

/**
 Returns the URL for the user's Caches directory.
 */
NS_INLINE NSURL *CRLCachesDirectory()
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}