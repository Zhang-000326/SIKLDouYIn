//
//  UIColor+SILKAdditions.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/27.
//

#import "UIColor+SILKAdditions.h"
#import "SILKMacros.h"

@implementation UIColor (SILKAdditions)

+ (UIColor *)SILK_colorWithHexString:(NSString *)hexString {
    if (SILK_isEmptyString(hexString)) {
        return [UIColor clearColor];
    }
    if ([hexString hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    if (hexString.length == 3) {
        // 处理F12 为 FF1122
        NSString *index0 = [hexString substringWithRange:NSMakeRange(0, 1)];
        NSString *index1 = [hexString substringWithRange:NSMakeRange(1, 1)];
        NSString *index2 = [hexString substringWithRange:NSMakeRange(2, 1)];
        hexString = [NSString stringWithFormat:@"%@%@%@%@%@%@", index0, index0, index1, index1, index2, index2];
    }
    unsigned int alpha = 0xFF;
    
    if (hexString.length < 6) {
        return [UIColor blackColor];
    }
    
    NSString *rgbString = [hexString substringToIndex:6];
    NSString *alphaString = [hexString substringFromIndex:6];
    // 存在Alpha
    if (alphaString.length > 0) {
        NSScanner *scanner = [NSScanner scannerWithString:alphaString];
        if (![scanner scanHexInt:&alpha]) {
            alpha = 0xFF;
        }
    }
    
    unsigned int rgb = 0;
    NSScanner *scanner = [NSScanner scannerWithString:rgbString];
    if (![scanner scanHexInt:&rgb]) {
        return nil;
    }
    return [self SILK_colorWithRGB:rgb alpha:alpha];
}

+ (UIColor *)SILK_colorWithRGB:(uint)rgb alpha:(uint)alpha {
    return [self colorWithRed:(CGFloat)((rgb & 0xFF0000) >> 16) / 255.0
                        green:(CGFloat)((rgb & 0x00FF00) >> 8) / 255.0f
                         blue:(CGFloat)(rgb & 0x0000FF) / 255.0
                        alpha:alpha / 255.0];
}

+ (UIColor *)SILK_colorWithHex:(uint32_t)rgb alpha:(float)alpha {
    return [self SILK_colorWithRGB:rgb alpha:alpha * 255.f];
}

+ (UIColor *)SILK_colorWithHexString:(NSString *)hexString alpha:(float)alpha
{
    if (SILK_isEmptyString(hexString)) {
        return [UIColor clearColor];
    }
    if ([hexString hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    if (hexString.length == 3) {
        // 处理F12 为 FF1122
        NSString *index0 = [hexString substringWithRange:NSMakeRange(0, 1)];
        NSString *index1 = [hexString substringWithRange:NSMakeRange(1, 1)];
        NSString *index2 = [hexString substringWithRange:NSMakeRange(2, 1)];
        hexString = [NSString stringWithFormat:@"%@%@%@%@%@%@", index0, index0, index1, index1, index2, index2];
    }
    
    if (hexString.length < 6) {
        return [UIColor blackColor];
    }
    
    NSString *rgbString = [hexString substringToIndex:6];
    
    unsigned int rgb = 0;
    NSScanner *scanner = [NSScanner scannerWithString:rgbString];
    if (![scanner scanHexInt:&rgb]) {
        return nil;
    }
    if (alpha < 0) {
        return  nil;
    }
    uint uAlpha = alpha * 255.0;
    return [UIColor SILK_colorWithRGB:rgb alpha:uAlpha];
}

@end
