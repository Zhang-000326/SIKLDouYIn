//
//  SILKSplashButtonViewContainer.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/9.
//

#import "SILKSplashButtonViewContainer.h"

#import "SILKSplashButtonView.h"

#import "SILKCommerceDefine.h"

@interface SILKSplashButtonView ()


@end


@implementation SILKSplashButtonViewContainer

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.buttonView.SILK_centerX = self.SILK_centerX;
    self.buttonView.SILK_bottom = self.SILK_height - 82;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.buttonView];
        [self.buttonView setNeedsLayout];
        [self.buttonView layoutIfNeeded];
        
        self.buttonView.SILK_centerX = self.SILK_centerX;
        self.buttonView.SILK_bottom = self.SILK_height - 82;
        
        [self loadButtonViewTriangleAnimation];
        [self loadButtonViewBreathAnimation];
    }
    
    return self;
}

- (void)loadButtonViewTriangleAnimation {
    
    NSInteger triangleWidth =  16;
    UIImage *triangleImage = [UIImage imageNamed:@"commerce_splash_button"];
    for (NSUInteger index = 0; index < 3; index++) {
        CGFloat beginTime = 0.2 * index;
        CGFloat moveLength = index > 0 ? (25 - index * 3 + 1) : 25;
        UIImageView *triangleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, triangleWidth, triangleWidth)];
        triangleView.alpha = 0;
        [triangleView setImage:triangleImage];
        triangleView.contentMode = UIViewContentModeScaleAspectFit;
        triangleView.SILK_left = self.buttonView.SILK_left + self.buttonView.tipsLabel.SILK_right + 4.0f; // 图文间距 4.f
        triangleView.SILK_centerY = self.buttonView.SILK_centerY;
        [self addSubview:triangleView];
        
        CABasicAnimation *translateXAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        translateXAnimation.fromValue = @(triangleView.layer.position.x);
        translateXAnimation.toValue = @(triangleView.layer.position.x + moveLength);
        translateXAnimation.duration = 1.3;
        translateXAnimation.removedOnCompletion = NO;
        translateXAnimation.fillMode = kCAFillModeForwards;
        translateXAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.2 :0 :0.3 :1.0];
        
        CAKeyframeAnimation *opaqueAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opaqueAnimation.values = @[@0, @1, @0];
        opaqueAnimation.keyTimes = @[@0, @(0.5/1.3), @1];
        opaqueAnimation.duration = 1.3;
        opaqueAnimation.removedOnCompletion = NO;
        opaqueAnimation.fillMode = kCAFillModeForwards;
        opaqueAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.2 :0 :0.3 :1.0];
        
        CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
        groupAnimation.beginTime = CACurrentMediaTime() + beginTime;
        groupAnimation.animations = @[translateXAnimation,opaqueAnimation];
        groupAnimation.duration = 1.3;
        groupAnimation.repeatCount = NSUIntegerMax;
        [triangleView.layer addAnimation:groupAnimation forKey:nil];
    }
}

- (void)loadButtonViewBreathAnimation {
    // 如果 maskPath，即中间需要挖去的部分，和按钮等大的话，在圆角部分会有部分差距，不能完全贴合，所以需要缩小一些
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.buttonView.SILK_left + 1.f, self.buttonView.SILK_top + 1.f, self.buttonView.SILK_width - 2.f, self.buttonView.SILK_height - 2.f) cornerRadius:self.buttonView.SILK_height / 2 - 1];
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRoundedRect:self.buttonView.frame cornerRadius:self.buttonView.SILK_height / 2];
    [startPath appendPath:maskPath];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.buttonView.SILK_left - 25, self.buttonView.SILK_top - 25, self.buttonView.SILK_width + 50, self.buttonView.SILK_height + 50) cornerRadius:(self.buttonView.SILK_height + 50) / 2.f];
    [endPath appendPath:maskPath];
    
    for (NSUInteger index = 0; index < 8; index++) {
        CGFloat beginTime = 1.f * index;
        
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        shapeLayer.path = startPath.CGPath;
        shapeLayer.fillColor = [UIColor colorWithWhite:1 alpha:0.4].CGColor;
        shapeLayer.fillRule = kCAFillRuleEvenOdd;
        shapeLayer.opacity = 0.f;
        [self.layer insertSublayer:shapeLayer below:self.buttonView.layer];
        
        CABasicAnimation *opacityIncreaseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityIncreaseAnimation.fromValue = @0;
        opacityIncreaseAnimation.toValue = @1;
        opacityIncreaseAnimation.duration = 0.3;
        opacityIncreaseAnimation.beginTime = CACurrentMediaTime() + beginTime;
        opacityIncreaseAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0.2 :1.0];
        opacityIncreaseAnimation.removedOnCompletion = NO;
        opacityIncreaseAnimation.fillMode = kCAFillModeForwards;
        [shapeLayer addAnimation:opacityIncreaseAnimation forKey:nil];

        CABasicAnimation *opacityDecreaseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityDecreaseAnimation.fromValue = @1;
        opacityDecreaseAnimation.toValue = @0;
        opacityDecreaseAnimation.duration = 1.7;
        opacityDecreaseAnimation.beginTime = CACurrentMediaTime() + 0.3 + beginTime;
        opacityDecreaseAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0.2 :1.0];
        opacityDecreaseAnimation.removedOnCompletion = NO;
        opacityDecreaseAnimation.fillMode = kCAFillModeForwards;
        [shapeLayer addAnimation:opacityDecreaseAnimation forKey:nil];

        CABasicAnimation *boundAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        boundAnimation.fromValue =  (__bridge id)(startPath.CGPath);
        boundAnimation.toValue = (__bridge id)(endPath.CGPath);
        boundAnimation.duration = 1.8;
        boundAnimation.beginTime = CACurrentMediaTime() + beginTime;
        boundAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0 :0 :1.0 :1.0];
        boundAnimation.removedOnCompletion = NO;
        boundAnimation.fillMode = kCAFillModeForwards;
        [shapeLayer addAnimation:boundAnimation forKey:nil];
    }
}

#pragma mark - Getter && Setter

- (SILKSplashButtonView *)buttonView {
    if (!_buttonView) {
        _buttonView = [[SILKSplashButtonView alloc] init];
    }
    
    return _buttonView;
}

@end
