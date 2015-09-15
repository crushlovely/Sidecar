// Sidecar
// Copyright (c) 2015, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CRLAttributedUtils)

/**
 Returns an NSAttributedString version of the receiver, with no attributes.
 */
-(NSAttributedString *)crl_attributedCopy;

/**
 Returns an NSAttributedString version of the receiver, with the given attributes.
 */
-(NSAttributedString *)crl_attributedCopyWithAttributes:(NSDictionary<NSString *, id> *)attributes;


/**
 Returns an NSMutableAttributedString version of the receiver, with no attributes.
 */
-(NSMutableAttributedString *)crl_mutableAttributedCopy;

/**
 Returns an NSMutableAttributedString version of the receiver, with the given attributes.
 */
-(NSMutableAttributedString *)crl_mutableAttributedCopyWithAttributes:(NSDictionary<NSString *, id> *)attributes;

@end

NS_ASSUME_NONNULL_END
