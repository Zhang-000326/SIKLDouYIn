//
//  UIColor+SILKAdditions.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (SILKAdditions)

/**
 *
 * @return UIColor  from the RGBA string
 */
+ (UIColor *)SILK_colorWithHexString:(NSString *)hexString;

+ (UIColor *)SILK_colorWithHexString:(NSString *)hexString alpha:(float)alpha;

+ (UIColor *)SILK_colorWithHex:(uint32_t)rgb alpha:(float)alpha;

@end

NS_ASSUME_NONNULL_END
