//
//  SILKSplashSkipView.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/23.
//

#import "SILKSplashSkipView.h"

#import "SILKCommerceDefine.h"

@interface SILKSplashSkipView ()

@property (nonatomic, strong) UILabel *skipLabel;

@end

@implementation SILKSplashSkipView

- (void)layoutSubviews {
    self.skipLabel.center = CGPointMake(self.SILK_width / 2.f, self.SILK_height / 2.f);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.skipLabel];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        self.layer.cornerRadius = self.SILK_height / 2.f;
    }
    
    return self;
}

- (UILabel *)skipLabel {
    if (!_skipLabel) {
        _skipLabel = [[UILabel alloc] init];
        _skipLabel.textAlignment = NSTextAlignmentCenter;
        _skipLabel.backgroundColor = [UIColor clearColor];
        _skipLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowBlurRadius = 3.f;
        shadow.shadowOffset = CGSizeMake(0,0.5);
        shadow.shadowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
        NSString *text = @"跳过广告";
        UIFont *font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        UIColor *color = [UIColor whiteColor];
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes: @{NSFontAttributeName:font, NSForegroundColorAttributeName:color, NSShadowAttributeName:shadow}];
        _skipLabel.attributedText = string;
        
        [_skipLabel sizeToFit];
    }
    
    return _skipLabel;
}

@end
