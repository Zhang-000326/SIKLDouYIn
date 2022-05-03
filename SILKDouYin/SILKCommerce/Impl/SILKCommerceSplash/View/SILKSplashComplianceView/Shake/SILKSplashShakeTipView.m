//
//  SILKSplashShakeTipView.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/20.
//

#import "SILKSplashShakeTipView.h"

#import "SILKCommerceDefine.h"

@interface SILKSplashShakeTipView ()

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation SILKSplashShakeTipView

#pragma mark - Lifecycle Method

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        self.layer.cornerRadius = self.SILK_height / 2;

        [self setupViews];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textLabel.SILK_centerX = self.SILK_width / 2;
    self.imageView.SILK_centerX = self.SILK_width / 2 + 1;
    
    self.textLabel.SILK_bottom = self.SILK_height - 21.f;
    self.imageView.SILK_bottom = self.textLabel.SILK_top + 3.f;
}

#pragma mark - Private Methods

- (void)setupViews {
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"shake_hand" withExtension:@"gif"]; //加载GIF图片
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef) fileUrl, NULL);           //将GIF图片转换成对应的图片源
    size_t frameCout = CGImageSourceGetCount(gifSource);                                         //获取其中图片源个数，即由多少帧图片组成
    NSMutableArray *frames = [[NSMutableArray alloc] init];                                      //定义数组存储拆分出来的图片
    for (size_t i = 0; i < frameCout; i++) {
      CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL); //从GIF图片中取出源图片
      UIImage *imageName = [UIImage imageWithCGImage:imageRef];                  //将图片源转换成UIimageView能使用的图片源
      [frames addObject:imageName];                                              //将图片加入数组中
      CGImageRelease(imageRef);
    }

    self.imageView.animationImages = frames;    //将图片数组加入UIImageView动画数组中
    self.imageView.animationDuration = 1.2;     //每次动画时长
    [  self.imageView startAnimating];          //开启动画，此处没有调用播放次数接口，UIImageView默认播放次数为无限次，故这里不做处理
    [self addSubview:self.imageView];
    
    NSString *tipsText = @"摇一摇";
    self.textLabel.text = tipsText;
    [self.textLabel sizeToFit];
    [self addSubview:self.textLabel];
}

#pragma mark - Getter & Setter

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
        _imageView.SILK_height = 80.f;
        _imageView.SILK_width = 80.f;
    }
    
    return _imageView;
}

@end
