// Sidecar
// Copyright (c) 2015, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (CRLUtils)

/**
 Appends the given string to the receiver, with no attributes.
 */
-(void)crl_appendString:(NSString *)string NS_SWIFT_NAME(append(_:));

/**
 Appends the given string to the receiver, with the given attributes.
 */
-(void)crl_appendString:(NSString *)string attributes:(NSDictionary<NSString *, id> *)attributes NS_SWIFT_NAME(append(_:attributes:));


/**
 Appends a string created by using a given format string as a template into which
 the remaining argument values are substituted. The appended string has no attributes.
 */
-(void)crl_appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1, 2) NS_SWIFT_UNAVAILABLE("Use string interpolation");

/**
 Appends a string created by using a given format string as a template into which
 the remaining argument values are substituted. The appended string has the given attributes.
 */
-(void)crl_appendFormat:(NSString *)format attributes:(NSDictionary<NSString *, id> *)attributes, ... NS_FORMAT_FUNCTION(1, 3) NS_SWIFT_UNAVAILABLE("Use string interpolation");


/**
 Appends the given string to the receiver. The string is given attributes identical
 to those of the current final character of the receiver.
 */
-(void)crl_appendStringMaintainingAttributesOfFinalCharacter:(NSString *)string NS_SWIFT_NAME(appendMaintainingAttributesOfFinalCharacter(_:));

/**
 Appends the given attributed string, first merging the attributes of the current final
 character of the receiver. If the given string has attributes in common with the final
 character, those of the final character take precedence.
 */
-(void)crl_appendAttributedStringMergingAttributesOfFinalCharacter:(NSAttributedString *)string NS_SWIFT_NAME(appendMergingAttributesOfFinalCharacter(_:));

/**
 Prepends the given string to the receiver. The string is given attributes identical
 to those of the current first character of the receiver.
 */
-(void)crl_prependStringMaintainingAttributesOfFirstCharacter:(NSString *)string NS_SWIFT_NAME(prependMaintainingAttributesOfFirstCharacter(_:));

/**
 Prepends the given attributed string, first merging the attributes of the current first
 character of the receiver. If the given string has attributes in common with the first
 character, those of the first character take precedence.
 */
-(void)crl_prependAttributedStringMergingAttributesOfFirstCharacter:(NSAttributedString *)string NS_SWIFT_NAME(prependMergingAttributesOfFirstCharacter(_:));


/**
 Modifies the receiver using the given block to replace each substring. The substrings passed to
 the block are runs in the receiver with the same attributes, so the result of this method is
 a string with the same attributes but possibly changed contents.

 For example, passing a block that returns substring.lowercaseString will result in lowercasing
 the receiver, while maintaining its attributes.

 @param mutator A block that receives as an argument a substring of the receiver, and returns the
 desired substring that should replace it. The string the block returns may be of any length,
 but cannot be nil.
 */
-(void)crl_mutateStringWithBlock:(NSString *(^)(NSString *substring))mutator NS_SWIFT_NAME(mutate(with:));

/**
 Uppercases the receiver in-place, leaving all attributes intact.
 @param locale The locale to use for the case conversion, or nil for the current locale.
 */
-(void)crl_uppercaseInPlaceWithLocale:(nullable NSLocale *)locale NS_SWIFT_NAME(uppercase(with:));

/**
 Lowercases the receiver in-place, leaving all attributes intact.
 @param locale The locale to use for the case conversion, or nil for the current locale.
 */
-(void)crl_lowercaseInPlaceWithLocale:(nullable NSLocale *)locale NS_SWIFT_NAME(lowercase(with:));

@end

NS_ASSUME_NONNULL_END
