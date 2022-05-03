//
//  UIView+SILKAdditions.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SILKAdditions)

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat SILK_left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat SILK_top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat SILK_right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat SILK_bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat SILK_width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat SILK_height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat SILK_centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat SILK_centerY;

/**
 * Return the x coordinate on the window.
 */
@property (nonatomic, readonly) CGFloat SILK_windowX;

/**
 * Return the y coordinate on the window.
 */
@property (nonatomic, readonly) CGFloat SILK_windowY;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint SILK_origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize SILK_size;

@end

NS_ASSUME_NONNULL_END
