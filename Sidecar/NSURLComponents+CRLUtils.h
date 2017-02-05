// Sidecar
// Copyright (c) 2015, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLComponents (CRLUtils)

/**
 Returns the first NSURLQueryItem with the given name from the receiver's
 queryItems, or nil if no match is found.
 */
-(nullable NSURLQueryItem *)crl_firstQueryItemNamed:(NSString *)name NS_SWIFT_NAME(firstQueryItem(named:));

@end

NS_ASSUME_NONNULL_END
