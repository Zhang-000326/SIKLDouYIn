//
//  SILKSplashSlideSideContainer.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/12.
//

#import "SILKSplashSlideSideContainer.h"

#import "SILKSplashSlideSideView.h"

#import "SILKCommerceDefine.h"

@interface SILKSplashSlideSideContainer ()

@end

@implementation SILKSplashSlideSideContainer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      
        [self setupSlideSideView];
    }
    
    return self;
}

- (void)setupSlideSideView {
    CGFloat scale = self.SILK_height / 812.f;
    CGFloat width = 200 * scale;
    self.slideSideView = [[SILKSplashSlideSideView alloc] initWithFrame:CGRectMake(self.SILK_width - width, 0, width, self.SILK_height)];
    NSString *text = @"侧滑前往落地页";
    [self.slideSideView setTipsText:text];
    [self addSubview:self.slideSideView];
    
    [self loadSlideSideAnimation];
    [self.slideSideView loadSlideSideAnimation];
}

- (void)loadSlideSideAnimation {
    CGFloat scale = self.SILK_height / 812.f;
    CGFloat width = 102 * scale;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(43.f * scale, 0)];
    [path addQuadCurveToPoint:CGPointMake(43.f * scale, self.SILK_height) controlPoint:CGPointMake(-width * 0.4f, self.SILK_height/2)];
    [path addLineToPoint:CGPointMake(width, self.SILK_height)];
    [path addLineToPoint:CGPointMake(width, 0)];
    [path closePath];
    
    for (NSUInteger index = 0; index < 2; index++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        shapeLayer.fillColor = [UIColor whiteColor].CGColor;
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(self.SILK_width, 0, width, self.SILK_height);
        UIColor *color1 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        UIColor *color2 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
        gradientLayer.colors = @[(id)color1.CGColor, (id)color2.CGColor];
        gradientLayer.locations = @[@0, @1];
        gradientLayer.startPoint = CGPointMake(0, 0.5);
        gradientLayer.endPoint = CGPointMake(1, 0.5);
        gradientLayer.mask = shapeLayer;
        [self.layer addSublayer:gradientLayer];

        CGFloat beginTime = 0.16 * index;

        CABasicAnimation *opacityIncreaseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityIncreaseAnimation.fromValue = @0;
        opacityIncreaseAnimation.toValue = @1;
        opacityIncreaseAnimation.duration = 1;
        opacityIncreaseAnimation.beginTime = CACurrentMediaTime() + beginTime;
        opacityIncreaseAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0 :0 :1.0 :1.0];
        opacityIncreaseAnimation.removedOnCompletion = NO;
        opacityIncreaseAnimation.fillMode = kCAFillModeForwards;
        [gradientLayer addAnimation:opacityIncreaseAnimation forKey:nil];

        CABasicAnimation *opacityDecreaseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityDecreaseAnimation.fromValue = @1;
        opacityDecreaseAnimation.toValue = @(0.2);
        opacityDecreaseAnimation.duration = 3;
        opacityDecreaseAnimation.beginTime = CACurrentMediaTime() + 1.f + beginTime;
        opacityDecreaseAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0 :0 :1.0 :1.0];
        opacityDecreaseAnimation.removedOnCompletion = NO;
        opacityDecreaseAnimation.fillMode = kCAFillModeForwards;
        [gradientLayer addAnimation:opacityDecreaseAnimation forKey:nil];

        CABasicAnimation *positionLeftAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        positionLeftAnimation.fromValue = @(self.SILK_width + width * 0.5);
        positionLeftAnimation.toValue = @(self.SILK_width - width * 0.5);
        positionLeftAnimation.duration = 2.0;
        positionLeftAnimation.beginTime = CACurrentMediaTime() + beginTime;
        positionLeftAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0.2 :1.0];
        positionLeftAnimation.removedOnCompletion = NO;
        positionLeftAnimation.fillMode = kCAFillModeForwards;
        [gradientLayer addAnimation:positionLeftAnimation forKey:nil];

        CABasicAnimation *positionRightAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        positionRightAnimation.fromValue = @(self.SILK_width - width * 0.5);
        positionRightAnimation.toValue = @(self.SILK_width - width * 0.5 + 15);
        positionRightAnimation.duration = 2.0;
        positionRightAnimation.beginTime = CACurrentMediaTime() + 2.16f;
        positionRightAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0.2 :1.0];
        positionRightAnimation.removedOnCompletion = NO;
        positionRightAnimation.fillMode = kCAFillModeForwards;
        [gradientLayer addAnimation:positionRightAnimation forKey:nil];
    }
}

@end
