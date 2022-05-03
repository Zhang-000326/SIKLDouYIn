//
//  SILKFeedMusicNameLabel.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/20.
//

#import "SILKFeedMusicNameLabel.h"

NSString * const kSILKFeedMusicNameLabelAnimation = @"kSILKFeedMusicNameLabelAnimation";
NSString * const kSILKFeedMusicNameLabelSeparateText = @"   ";

@interface SILKFeedMusicNameLabel()

@property(nonatomic, strong) CATextLayer *textLayer;
@property(nonatomic, strong) CAShapeLayer *maskLayer;
@property(nonatomic, assign) CGFloat textSeparateWidth;
@property(nonatomic, assign) CGFloat textWidth;
@property(nonatomic, assign) CGFloat textHeight;
@property(nonatomic, assign) CGRect textLayerFrame;
@property(nonatomic, assign) CGFloat translationX;

@end

@implementation SILKFeedMusicNameLabel

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _text = @"";
        _textColor = [UIColor colorWithWhite:1 alpha:1];
        _font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _textSeparateWidth = [kSILKFeedMusicNameLabelSeparateText sizeWithAttributes:@{NSFontAttributeName:_font}].width;
        [self initLayer];
    }
    return self;
}

- (void)initLayer {
    _textLayer = [[CATextLayer alloc] init];
    _textLayer.alignmentMode = kCAAlignmentNatural;
    _textLayer.truncationMode = kCATruncationNone;
    _textLayer.wrapped = NO;
    _textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:_textLayer];
    
    _maskLayer = [[CAShapeLayer alloc] init];
    self.layer.mask = _maskLayer;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _textLayer.frame = CGRectMake(0, self.bounds.size.height/2 - _textLayerFrame.size.height/2, _textLayerFrame.size.width, _textLayerFrame.size.height);
    _maskLayer.frame = self.bounds;
    _maskLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    [CATransaction commit];
}

- (void)drawTextLayer {
    _textLayer.foregroundColor = _textColor.CGColor;
    CFStringRef fontName = (__bridge CFStringRef)_font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    _textLayer.font = fontRef;
    _textLayer.fontSize = _font.pointSize;
    CGFontRelease(fontRef);
    _textLayer.string = [NSString stringWithFormat:@"%@%@%@%@%@",_text,kSILKFeedMusicNameLabelSeparateText,_text,kSILKFeedMusicNameLabelSeparateText,_text];
}

- (void)startAnimation {
    if([_textLayer animationForKey:kSILKFeedMusicNameLabelAnimation]) {
        [_textLayer removeAnimationForKey:kSILKFeedMusicNameLabelAnimation];
    }
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.translation.x";
    animation.fromValue = @(self.bounds.origin.x);
    animation.toValue = @(self.bounds.origin.x - _translationX);
    animation.duration = _textWidth * 0.035f;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_textLayer addAnimation:animation forKey:kSILKFeedMusicNameLabelAnimation];
}

#pragma update method
- (void)setText:(NSString *)text {
    _text = text;
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:_font}];
    _textWidth = size.width;
    _textHeight = size.height;
    _textLayerFrame = CGRectMake(0, 0, _textWidth*3 + _textSeparateWidth*2, _textHeight);
    _translationX = _textWidth + _textSeparateWidth;
    [self drawTextLayer];
    [self startAnimation];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    CGSize size = [_text sizeWithAttributes:@{NSFontAttributeName:_font}];
    _textWidth = size.width;
    _textHeight = size.height;
    _textLayerFrame = CGRectMake(0, 0, _textWidth*3 + _textSeparateWidth*2, _textHeight);
    _translationX = _textWidth + _textSeparateWidth;
    [self drawTextLayer];
    [self startAnimation];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _textLayer.foregroundColor = _textColor.CGColor;
}


@end
