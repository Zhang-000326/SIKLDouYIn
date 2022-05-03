//
//  SILKSplashSlideUpButton.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/10.
//

#import "SILKSplashSlideUpButton.h"

#import "SILKCommerceDefine.h"



@implementation SILKSplashSlideUpButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tipsLabel.SILK_left = 46;
    self.tipsLabel.SILK_centerY = self.SILK_height / 2;
}

#pragma mark - Public Method

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.tipsLabel];
        
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
        NSString *text = @"上滑前往落地页";
        UIFont *font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        UIColor *color = [UIColor whiteColor];
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes: @{NSFontAttributeName:font, NSForegroundColorAttributeName:color, NSShadowAttributeName:shadow}];
        _tipsLabel.attributedText = string;
        
        [_tipsLabel sizeToFit];
        self.SILK_width = self.tipsLabel.SILK_width + 92;
    }
    
    return _tipsLabel;
}

@end
