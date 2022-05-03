//
//  SILKUserCollectionCell.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/17.
//

#import "SILKUserCollectionCell.h"

#import "SILKUserDefine.h"

#import "SILKCacheCenterProtocol.h"

@implementation SILKUserCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        self.clipsToBounds = YES;
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithRed:92/255.f green:93/255.f blue:102/255.f alpha:1];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imageView];
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor, (__bridge id)[UIColor colorWithWhite:0 alpha:0.2].CGColor, (__bridge id)[UIColor colorWithWhite:0 alpha:0.6].CGColor];
        gradientLayer.locations = @[@0.3, @0.6, @1.0];
        gradientLayer.startPoint = CGPointMake(0.0f, 0.0f);
        gradientLayer.endPoint = CGPointMake(0.0f, 1.0f);
        gradientLayer.frame = CGRectMake(0, self.frame.size.height - 100, self.frame.size.width, 100);
        [_imageView.layer addSublayer:gradientLayer];
        
        _favoriteNum = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
        [_favoriteNum setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_favoriteNum setTitle:@"0" forState:UIControlStateNormal];
        [_favoriteNum setTitleColor:[UIColor colorWithWhite:1 alpha:1] forState:UIControlStateNormal];
        _favoriteNum.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_favoriteNum setImage:[UIImage imageNamed:@"user_like_num"] forState:UIControlStateNormal];
        [self.contentView addSubview:_favoriteNum];
        
        self.imageView.frame = self.contentView.frame;
        self.favoriteNum.SILK_left = 10;
        self.favoriteNum.SILK_width = self.contentView.SILK_width - 20;
        self.favoriteNum.SILK_bottom = self.contentView.SILK_height - 10;
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:NO];
}

- (void)initDataWithVideoKey:(NSString *)videoKey {
    NSString *videoPath = [GET_INSTANCE_FROM_PROTOCOL(SILKCacheCenter) videoFilePathForKey:videoKey];
    UIImage *image = [UIImage getScreenShotImageFromVideoPath:videoPath];
    self.imageView.image = image;
    [self.favoriteNum setTitle:@"  2018" forState:UIControlStateNormal];
}


@end
