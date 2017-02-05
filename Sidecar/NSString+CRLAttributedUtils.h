// Sidecar
// Copyright (c) 2015, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CRLAttributedUtils)

/**
 Returns an NSAttributedString version of the receiver, with no attributes.
 */
-(NSAttributedString *)crl_attributedCopy NS_SWIFT_NAME(attributedCopy());

/**
 Returns an NSAttributedString version of the receiver, with the given attributes.
 */
-(NSAttributedString *)crl_attributedCopyWithAttributes:(NSDictionary<NSString *, id> *)attributes NS_SWIFT_NAME(attributedCopy(attributes:));


/**
 Returns an NSMutableAttributedString version of the receiver, with no attributes.
 */
-(NSMutableAttributedString *)crl_mutableAttributedCopy NS_SWIFT_NAME(mutableAttributedCopy());

/**
 Returns an NSMutableAttributedString version of the receiver, with the given attributes.
 */
-(NSMutableAttributedString *)crl_mutableAttributedCopyWithAttributes:(NSDictionary<NSString *, id> *)attributes NS_SWIFT_NAME(mutableAttributedCopy(attributes:));

@end

NS_ASSUME_NONNULL_END
