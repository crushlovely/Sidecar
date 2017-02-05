// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CRLUtils)

/**
 Returns a new string formed by removing whitespace and newlines from both ends of the receiver.
 */
@property (nonatomic, readonly) NSString *crl_stringByTrimmingWhitespace NS_SWIFT_NAME(trimmingWhitespace);

/**
 Returns YES if the string is zero-length or consists entirely of some combination of
 whitespace and newline characters.
 */
@property (nonatomic, readonly) BOOL crl_isEmptyOrWhitespace NS_SWIFT_NAME(isEmptyOrWhitespace);

@end

NS_ASSUME_NONNULL_END
