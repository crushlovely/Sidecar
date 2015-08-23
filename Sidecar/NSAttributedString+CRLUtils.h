// Sidecar
// Copyright (c) 2015, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 This is the line break (not paragraph break) character that TextKit understands. It has a nice constant
 in OSX, but not in the iOS SDK. It's U+2028; this string contains its UTF-8 representation.

 @see https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Strings/Articles/stringsParagraphBreaks.html
 */
extern NSString * const CRLSoftLineBreakCharacter;


@interface NSAttributedString (CRLUtils)

/**
 Returns an attributed string created by using a given format string as a template into which
 the remaining argument values are substituted. The string has no attributes.
 */
+(instancetype)crl_stringWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1, 2);

/**
 Returns an attributed string created by using a given format string as a template into which
 the remaining argument values are substituted. The provided attributes are applied to the
 entire string.
 */
+(instancetype)crl_stringWithFormat:(NSString *)format attributes:(NSDictionary<NSString *, id> *)attributes, ... NS_FORMAT_FUNCTION(1, 3);

/**
 Returns a new attributed string formed by applying the given block to each substring of the
 receiver. The substrings passed to the block are runs in the receiver with the same attributes,
 so the resulting string is formed of (possibly) changed substrings with the original attributes
 maintained.
 
 For example, passing a block that returns substring.lowercaseString will result in an attributed
 string that has identical attributes to the receiver, but has all lowercase characters.

 @param mutator A block that receives as an argument a substring of the receiver, and returns the
 desired substring to replace it in the return. The string the block returns may be of any length,
 but cannot be nil.
 */
-(NSAttributedString *)crl_stringByMutatingStringWithBlock:(NSString *(^)(NSString *substring))mutator;

/**
 Returns an uppercase version of the receiver, with all attributes intact.
 @param locale The locale to use for the case conversion, or nil for the current locale.
 */
-(NSAttributedString *)crl_uppercaseStringWithLocale:(nullable NSLocale *)locale;

/**
 Returns lowercase version of the receiver, with all attributes intact.
 @param locale The locale to use for the case conversion, or nil for the current locale.
 */
-(NSAttributedString *)crl_lowercaseStringWithLocale:(nullable NSLocale *)locale;

@end

NS_ASSUME_NONNULL_END
