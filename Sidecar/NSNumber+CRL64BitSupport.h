// Sidecar
// Copyright (c) 2015, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <Foundation/Foundation.h>

@interface NSNumber (CRL64BitSupport)

/**
 The number's CGFloat value, taking into account the true type of
 CGFloat on the current architecture.
 
 @note To convert a CGFloat to an NSNumber, use the literal NSNumber
 syntax -- it does the correct thing on all architectures.
 */
@property (nonatomic, readonly) CGFloat crl_CGFloatValue NS_SWIFT_NAME(cgFloatValue);

@end
