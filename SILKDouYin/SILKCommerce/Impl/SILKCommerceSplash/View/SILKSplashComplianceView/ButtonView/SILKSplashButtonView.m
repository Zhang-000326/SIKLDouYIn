//
//  SILKSplashButtonView.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/9.
//

#import "SILKSplashButtonView.h"

#import "SILKCommerceDefine.h"

@interface SILKSplashButtonView ()

@property (nonatomic, strong) UIView *imageView;

@end

@implementation SILKSplashButtonView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.SILK_width = self.tipsLabel.SILK_width + 108;
    self.tipsLabel.SILK_left = self.SILK_left + 46;
    self.tipsLabel.SILK_centerY = self.SILK_height / 2;
}

#pragma mark - Public Method

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.tipsLabel];
        [self addSubview:self.imageView];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:99/255.f];
        self.SILK_height = 64;
        self.layer.cornerRadius = 32;
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2].CGColor;
    }
    
    return self;
}


#pragma mark - Getter && Setter

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel new];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.backgroundColor = [UIColor clearColor];
        _tipsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowBlurRadius = 3.f;
        shadow.shadowOffset = CGSizeMake(0,0.5);
        shadow.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        NSString *text = @"点击前往落地页";
        UIFont *font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        UIColor *color = [UIColor whiteColor];
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes: @{NSFontAttributeName:font, NSForegroundColorAttributeName:color, NSShadowAttributeName:shadow}];
        _tipsLabel.attributedText = string;
        
        [_tipsLabel sizeToFit];
    }
    
    return _tipsLabel;
}

- (UIView *)imageView {
    if (!_imageView) {
        // 放一个和箭头位移区域同等大小的图片框，方便布局
        _imageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 42.f, 16.f)];
        _imageView.backgroundColor = [UIColor clearColor];
    }
    
    return _imageView;
}

@end
