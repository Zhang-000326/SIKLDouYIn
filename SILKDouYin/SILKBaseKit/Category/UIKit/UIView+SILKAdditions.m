//
//  UIView+SILKAdditions.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/27.
//

#import "UIView+SILKAdditions.h"

@implementation UIView (SILKAdditions)

#pragma mark - Getter && Setter

- (CGFloat)SILK_left {
    return self.frame.origin.x;
}

- (void)setSILK_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)SILK_top {
    return self.frame.origin.y;
}

- (void)setSILK_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)SILK_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSILK_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)SILK_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setSILK_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)SILK_centerX {
    return self.center.x;
}

- (void)setSILK_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)SILK_centerY {
    return self.center.y;
}

- (void)setSILK_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)SILK_width {
    return self.frame.size.width;
}

- (void)setSILK_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)SILK_height {
    return self.frame.size.height;
}

- (void)setSILK_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)SILK_windowX {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    return [self convertRect:self.bounds toView:window].origin.x;
}

- (CGFloat)SILK_windowY {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    return [self convertRect:self.bounds toView:window].origin.y;
}

- (CGPoint)SILK_origin {
    return self.frame.origin;
}

- (void)setSILK_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)SILK_size {
    return self.frame.size;
}

- (void)setSILK_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
