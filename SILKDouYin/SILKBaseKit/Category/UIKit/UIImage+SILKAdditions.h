//
//  UIImage+SILKAdditions.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SILKAdditions)

/**
 * 根据颜色生成指定size的纯色图片
 *
 * @param color 图片颜色
 * @param size 图片大小
 */
+ (UIImage *)SILK_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 * 转换图片颜色
 *
 * @param image 原图片
 * @param color 图片颜色
 */
+ (UIImage *)SILK_changeImage:(UIImage *)image color:(UIColor *)color;

/**
 * 获取视频封面
 *
 * @param filePath  视频文件路径
 */
+ (UIImage *)getScreenShotImageFromVideoPath:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
