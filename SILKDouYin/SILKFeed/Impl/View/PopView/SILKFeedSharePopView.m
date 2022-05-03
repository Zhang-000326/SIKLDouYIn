//
//  SILKFeedSharePopView.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/26.
//

#import "SILKFeedSharePopView.h"

// define
#import "SILKFeedDefine.h"

@implementation SILKFeedSharePopView

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *topIconsName = @[
                                 @"profile_share_wxTimeline",
                                 @"profile_share_wechat",
                                 @"profile_share_qqZone",
                                 @"profile_share_qq",
                                 @"profile_share_weibo",
                                 @"home_share_more"
                                 ];
        NSArray *topTexts = @[
                             @"朋友圈",
                             @"微信好友",
                             @"QQ空间",
                             @"QQ好友",
                             @"微博",
                             @"更多分享"
                             ];
        NSArray *bottomIconsName = @[
                                    @"home_share_report",
                                    @"home_share_download",
                                    @"home_share_copylink",
                                    @"home_share_dislike"
                                    ];
        NSArray *bottomTexts = @[
                                @"举报",
                                @"保存至相册",
                                @"复制链接",
                                @"不感兴趣"
                                ];
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)]];
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 310)];
        _container.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [self addSubview:_container];
        
        
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:_container.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10.0f, 10.0f)];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        _container.layer.mask = shape;
        
        UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        visualEffectView.frame = self.bounds;
        visualEffectView.alpha = 1.0f;
        [_container addSubview:visualEffectView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.text = @"分享到";
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14.0];
        [_container addSubview:label];
        
        
        CGFloat itemWidth = 68;
        
        UIScrollView *topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, SCREEN_WIDTH, 90)];
        topScrollView.contentSize = CGSizeMake(itemWidth * topIconsName.count, 80);
        topScrollView.showsHorizontalScrollIndicator = NO;
        topScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 30);
        [_container addSubview:topScrollView];
        
        for (NSInteger i = 0; i < topIconsName.count; i++) {
            ShareItem *item = [[ShareItem alloc] initWithFrame:CGRectMake(20 + itemWidth*i, 0, 48, 90)];
            item.icon.image = [UIImage imageNamed:topIconsName[i]];
            item.label.text = topTexts[i];
            item.tag = i;
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onShareItemTap:)]];
            [item startAnimation:i*0.03f];
            [topScrollView addSubview:item];
        }
        
        UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, 0.5f)];
        splitLine.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        [_container addSubview:splitLine];
        
        UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 135, SCREEN_WIDTH, 90)];
        bottomScrollView.contentSize = CGSizeMake(itemWidth * bottomIconsName.count, 80);
        bottomScrollView.showsHorizontalScrollIndicator = NO;
        bottomScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 30);
        [_container addSubview:bottomScrollView];
        
        for (NSInteger i = 0; i < bottomIconsName.count; i++) {
            ShareItem *item = [[ShareItem alloc] initWithFrame:CGRectMake(20 + itemWidth*i, 0, 48, 90)];
            item.icon.image = [UIImage imageNamed:bottomIconsName[i]];
            item.label.text = bottomTexts[i];
            item.tag = i;
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onActionItemTap:)]];
            [item startAnimation:i*0.03f];
            [bottomScrollView addSubview:item];
        }
        
        
        _cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 230, SCREEN_WIDTH, 80)];
        [_cancel setTitleEdgeInsets:UIEdgeInsetsMake(-30, 0, 0, 0)];
        
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel setTitleColor:[UIColor colorWithWhite:1 alpha:1] forState:UIControlStateNormal];
        _cancel.titleLabel.font = [UIFont systemFontOfSize:16.0];

        _cancel.backgroundColor = [UIColor colorWithRed:40/255.f green:40/255.f blue:40/255.f alpha:1];
        [_container addSubview:_cancel];
        
        UIBezierPath* rounded2 = [UIBezierPath bezierPathWithRoundedRect:_cancel.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10.0f, 10.0f)];
        CAShapeLayer* shape2 = [[CAShapeLayer alloc] init];
        [shape2 setPath:rounded2.CGPath];
        _cancel.layer.mask = shape2;
        [_cancel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)]];
    }
    return self;
}

- (void)onShareItemTap:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case 0:
            break;
        default:
            break;
    }
    [self dismiss];
}
- (void)onActionItemTap:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case 0:
            break;
        default:
            break;
    }
    [self dismiss];
}

- (void)handleGuesture:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:_container];
    if(![_container.layer containsPoint:point]) {
        [self dismiss];
        return;
    }
    point = [sender locationInView:_cancel];
    if([_cancel.layer containsPoint:point]) {
        [self dismiss];
    }
}

- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y - frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.container.frame;
                         frame.origin.y = frame.origin.y + frame.size.height;
                         self.container.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

@end

@implementation ShareItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"iconHomeAllshareCopylink"];
        _icon.contentMode = UIViewContentModeScaleToFill;
        _icon.userInteractionEnabled = YES;
        [self addSubview:_icon];
        
        _label = [[UILabel alloc] init];
        _label.text = @"TEXT";
        _label.textColor = [UIColor colorWithWhite:1 alpha:0.6];
        _label.font = [UIFont systemFontOfSize:14.0];
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
    }
    return self;
}
- (void)startAnimation:(NSTimeInterval)delayTime {
    CGRect originalFrame = self.frame;
    self.frame = CGRectMake(CGRectGetMinX(originalFrame), 35, originalFrame.size.width, originalFrame.size.height);
    [UIView animateWithDuration:0.9f
                          delay:delayTime
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = originalFrame;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.icon.frame = CGRectMake(0, 0, 48, 48);
    self.icon.SILK_centerX = 24;
    self.icon.SILK_top = self.SILK_top + 10;
    
    [self.label sizeToFit];
    self.label.SILK_centerX = 24;
    self.label.SILK_top = self.icon.SILK_bottom + 10;
}

@end
