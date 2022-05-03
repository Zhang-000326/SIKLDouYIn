//
//  SILKSplashSlideSideView.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/12.
//

#import "SILKSplashSlideSideView.h"

#import "SILKCommerceDefine.h"


@interface SILKSplashSlideSideView ()

@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, strong) UIView *imageView;

@end


@implementation SILKSplashSlideSideView

#pragma mark - Public Method

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tipsLabel];
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)setTipsText:(NSString *)text {
    if (SILK_isEmptyString(text)) {
        self.tipsLabel.text = text;
    } else {
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowBlurRadius = 3.f;
        shadow.shadowOffset = CGSizeMake(0,0);
        shadow.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        UIFont *font = [UIFont systemFontOfSize:13.f];
        if (@available(iOS 8.2, *)) {
            font = [UIFont systemFontOfSize:13.f weight:UIFontWeightMedium];
        }
        UIColor *color = [UIColor whiteColor];
        NSDictionary *attributes = @{NSFontAttributeName:font, NSForegroundColorAttributeName:color, NSShadowAttributeName:shadow};
        // 获取单个汉字的宽度，用于竖排文本
        CGSize wordSize = [@"一" boundingRectWithSize:CGSizeMake(0,0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;

        self.tipsLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.tipsLabel.numberOfLines = 0;
        self.tipsLabel.frame = CGRectMake(0, 0, wordSize.width, 0);
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
        self.tipsLabel.attributedText = string;
    }
    [self.tipsLabel sizeToFit];
    
    CGFloat height = self.tipsLabel.SILK_height + 6.0f + self.imageView.SILK_height;
    self.tipsLabel.SILK_top = (self.SILK_height - height) / 2;
    self.tipsLabel.SILK_right = self.SILK_width;
    self.imageView.SILK_top = self.tipsLabel.SILK_bottom + 6.0f;
    self.imageView.SILK_right = self.SILK_width;
    self.tipsLabel.layer.opacity = 0;
}

- (void)loadSlideSideAnimation {
    // 文本框的位移延时 5s
    CABasicAnimation *opacityIncreaseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityIncreaseAnimation.fromValue = @0;
    opacityIncreaseAnimation.toValue = @1;
    opacityIncreaseAnimation.duration = 0.4;
    opacityIncreaseAnimation.beginTime = CACurrentMediaTime() + 0.5;
    opacityIncreaseAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0.2 :1.0];
    opacityIncreaseAnimation.removedOnCompletion = NO;
    opacityIncreaseAnimation.fillMode = kCAFillModeForwards;
    [self.tipsLabel.layer addAnimation:opacityIncreaseAnimation forKey:nil];

    CABasicAnimation *positionLeftAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    positionLeftAnimation.fromValue = @(self.tipsLabel.layer.position.x);
    positionLeftAnimation.toValue = @(self.tipsLabel.layer.position.x - 15);
    positionLeftAnimation.duration = 0.9;
    positionLeftAnimation.beginTime = CACurrentMediaTime() + 0.5;
    positionLeftAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0.2 :1.0];
    positionLeftAnimation.removedOnCompletion = NO;
    positionLeftAnimation.fillMode = kCAFillModeForwards;
    [self.tipsLabel.layer addAnimation:positionLeftAnimation forKey:nil];
    
    self.imageView.SILK_right = self.SILK_width - 11.75;
    UIBezierPath *triangle = [UIBezierPath bezierPath];
    [triangle moveToPoint:CGPointMake(self.imageView.SILK_right, self.imageView.SILK_top)];
    [triangle addLineToPoint:CGPointMake(self.imageView.SILK_right - 4.5, self.imageView.SILK_top + 4.5)];
    [triangle addLineToPoint:CGPointMake(self.imageView.SILK_right, self.imageView.SILK_bottom)];
    triangle.lineWidth = 3.f;
    triangle.lineCapStyle = kCGLineCapRound;
    triangle.lineJoinStyle = kCGLineJoinRound;
    
    for (NSUInteger index = 0; index < 3; index++) {
        CGFloat beginTime = 0.3 * index + 0.9;
        
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        shapeLayer.path = triangle.CGPath;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.opacity = 0.f;
        shapeLayer.fillColor = nil;
        shapeLayer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
        shapeLayer.shadowOffset = CGSizeMake(0,0);
        shapeLayer.shadowRadius = 3.f;
        [self.layer addSublayer:shapeLayer];
        
        CAKeyframeAnimation *opaqueAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opaqueAnimation.values = @[@0, @1, @0];
        opaqueAnimation.keyTimes = @[@0, @(0.76/1.32), @1];
        opaqueAnimation.duration = 1.32;

        CABasicAnimation *positionXAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        positionXAnimation.fromValue =  @(shapeLayer.position.x);
        positionXAnimation.toValue =  @(shapeLayer.position.x - 15);
        positionXAnimation.duration = 1.32;
        
        CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
        groupAnimation.beginTime = CACurrentMediaTime() + beginTime;
        groupAnimation.animations = @[opaqueAnimation, positionXAnimation];
        groupAnimation.duration = 1.32;
        groupAnimation.removedOnCompletion = NO;
        groupAnimation.fillMode = kCAFillModeForwards;
        groupAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0.2 :1.0];
        groupAnimation.repeatCount = NSUIntegerMax;
        [shapeLayer addAnimation:groupAnimation forKey:nil];
    }
}

#pragma mark - Getter && Setter

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel new];
        _tipsLabel.textColor = [UIColor whiteColor];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.backgroundColor = [UIColor clearColor];
        _tipsLabel.font = [UIFont systemFontOfSize:13.f];
        _tipsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    
    return _tipsLabel;
}

- (UIView *)imageView {
    if (!_imageView) {
        _imageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20.f, 9.f)];
        _imageView.backgroundColor = [UIColor clearColor];
    }
    
    return _imageView;
}


@end
