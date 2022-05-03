//
//  SILKUserInfoHeader.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/16.
//

#import "SILKUserInfoHeader.h"

#import "SILKUserModel.h"
#import "SILKUserDefine.h"

#import "SILKUserSlideTabBar.h"

@interface SILKUserInfoHeader ()

@property (nonatomic, strong) UIView                  *containerView;
@property (nonatomic, copy) NSArray<NSString *>       *constellations;

@end

@implementation SILKUserInfoHeader

//- (void)layoutSubviews {
//
//    int avatarRadius = 48;
//    self.avatar.SILK_height = avatarRadius * 2;
//    self.avatar.SILK_width = avatarRadius * 2;
//    self.avatar.SILK_top = self.containerView.SILK_top + 40 + NAVBAR_HEIGHT;
//    self.avatar.SILK_left = self.containerView.SILK_left + 15;
//
//    self.nickName.SILK_top = self.avatar.SILK_bottom + 20;
//    self.nickName.SILK_left = self.avatar.SILK_left;
//    self.nickName.SILK_right = self.containerView.SILK_right - 15;
//
//
//    self.douyinNum.SILK_top = self.nickName.SILK_bottom + 3;
//    self.douyinNum.SILK_left = self.nickName.SILK_left;
//    self.douyinNum.SILK_right = self.nickName.SILK_left;
//
//
//    UIView *splitView = [[UIView alloc] init];
//    splitView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
//    [self.containerView addSubview:splitView];
//
//    splitView.SILK_top = self.douyinNum.SILK_bottom + 10;
//    splitView.SILK_left = self.nickName.SILK_left;
//    splitView.SILK_right = self.nickName.SILK_right;
//    splitView.SILK_height = 0.5;
//
//
//    self.brief.SILK_top = splitView.SILK_bottom + 10;
//    self.brief.SILK_left = self.nickName.SILK_left;
//    self.brief.SILK_right = self.nickName.SILK_right;
//
//
//    self.genderIcon.SILK_left = self.nickName.SILK_left;
//    self.genderIcon.SILK_top = self.brief.SILK_bottom + 8;
//    self.genderIcon.SILK_height = 18;
//    self.genderIcon.SILK_width = 22;
//
//    self.city.SILK_left = self.genderIcon.SILK_right + 5;
//    self.city.SILK_top = self.genderIcon.SILK_top;
//    self.city.SILK_height = self.genderIcon.SILK_height;
//
//    self.likeNum.SILK_top = self.genderIcon.SILK_bottom + 15;
//    self.likeNum.SILK_left = self.avatar.SILK_left;
//
//
//    self.followNum.SILK_top = self.likeNum.SILK_top;
//    self.followNum.SILK_left = self.likeNum.SILK_right + 30;
//
//    self.followedNum.SILK_top = self.likeNum.SILK_top;
//    self.followedNum.SILK_left = self.followNum.SILK_right + 30;
//
//
//
//    self.slideTabBar.SILK_height = 40;
//    self.slideTabBar.SILK_left = self.containerView.SILK_left;
//    self.slideTabBar.SILK_right = self.containerView.SILK_right;
//    self.slideTabBar.SILK_bottom = self.containerView.SILK_bottom;
//
//}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        self.isFollowed = NO;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    [self initAvatarBackground];
    
    self.containerView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.containerView];
    
    [self initAvatar];
    [self initActionsView];
    [self initInfoView];
}

- (void) initAvatarBackground {
    _topBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50 + NAVBAR_HEIGHT)];
    [_topBackground setImage:[UIImage imageWithData:[@"user_background" SILK_dataFromLocalFileWithType:@"jpeg"]]];
    _topBackground.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_topBackground];
    
    _bottomBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35 + NAVBAR_HEIGHT, SCREEN_WIDTH, self.bounds.size.height - (35 + NAVBAR_HEIGHT))];
    _bottomBackground.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_bottomBackground];
    
    UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    visualEffectView.frame = _bottomBackground.bounds;
    visualEffectView.alpha = 1;
    [_bottomBackground addSubview:visualEffectView];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [self createBezierPath].CGPath;
    _bottomBackground.layer.mask = maskLayer;
}

-(UIBezierPath *)createBezierPath {
    int avatarRadius = 54;
    int topOffset = 16;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, topOffset)];
    [bezierPath addLineToPoint:CGPointMake(25, topOffset)];
    [bezierPath addArcWithCenter:CGPointMake(25 + avatarRadius * cos(M_PI/4), avatarRadius * sin(M_PI/4) + topOffset) radius:avatarRadius startAngle:(M_PI * 5)/4 endAngle:(M_PI * 7)/4 clockwise:YES];
    [bezierPath addLineToPoint:CGPointMake(25 + avatarRadius * cos(M_PI/4), topOffset)];
    [bezierPath addLineToPoint:CGPointMake(SCREEN_WIDTH, topOffset)];
    [bezierPath addLineToPoint:CGPointMake(SCREEN_WIDTH, self.bounds.size.height - (50 + NAVBAR_HEIGHT) + topOffset - 1)];
    [bezierPath addLineToPoint:CGPointMake(0, self.bounds.size.height - (50 + NAVBAR_HEIGHT) + topOffset - 1)];
    [bezierPath closePath];
    return bezierPath;
}

- (void) initAvatar {
    int avatarRadius = 48;
    self.avatar = [[UIImageView alloc] init];
    self.avatar.image = [UIImage imageWithData:[@"Klee_image" SILK_dataFromLocalFileWithType:@"jpg"]];
    self.avatar.layer.cornerRadius = avatarRadius;
    self.avatar.layer.masksToBounds = YES;
    [self.containerView addSubview:self.avatar];
        
    self.avatar.SILK_height = avatarRadius * 2;
    self.avatar.SILK_width = avatarRadius * 2;
    self.avatar.SILK_top = self.SILK_top + 40 + NAVBAR_HEIGHT;
    self.avatar.SILK_left = self.SILK_left + 15;
}

- (void) initActionsView {
    
}

- (void)initInfoView {
    self.nickName = [[UILabel alloc] init];
    self.nickName.text = @"张骞-UESTC";
    self.nickName.textColor = [UIColor colorWithWhite:1 alpha:1];
    self.nickName.font = [UIFont boldSystemFontOfSize:26.0];
    [self.nickName sizeToFit];
    [self.containerView addSubview:self.nickName];
    
    self.nickName.SILK_top = self.avatar.SILK_bottom + 20;
    self.nickName.SILK_left = self.avatar.SILK_left;
    self.nickName.SILK_width = self.containerView.SILK_right - 15 - self.nickName.SILK_left;
    
    
    self.douyinNum = [[UILabel alloc] init];
    self.douyinNum.text = @"ID：2018091609007";
    self.douyinNum.textColor = [UIColor colorWithWhite:1 alpha:1];
    self.douyinNum.font = [UIFont systemFontOfSize:12.0];
    [self.douyinNum sizeToFit];
    [self.containerView addSubview:self.douyinNum];
    
    self.douyinNum.SILK_top = self.nickName.SILK_bottom + 3;
    self.douyinNum.SILK_left = self.nickName.SILK_left;
    self.douyinNum.SILK_width = self.nickName.SILK_width;
    
    
    UIView *splitView = [[UIView alloc] init];
    splitView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    [self.containerView addSubview:splitView];
    
    splitView.SILK_top = self.douyinNum.SILK_bottom + 10;
    splitView.SILK_left = self.nickName.SILK_left;
    splitView.SILK_width = self.nickName.SILK_width;
    splitView.SILK_height = 0.5;
    
    
    self.brief = [[UILabel alloc] init];
    self.brief.text = @"项目初版，for graduation project";
    self.brief.textColor = [UIColor colorWithWhite:1 alpha:0.6];
    self.brief.font = [UIFont systemFontOfSize:12.0];
    self.brief.numberOfLines = 0;
    [self.brief sizeToFit];
    [self.containerView addSubview:self.brief];
    
    self.brief.SILK_top = splitView.SILK_bottom + 10;
    self.brief.SILK_left = self.nickName.SILK_left;
    self.brief.SILK_width = self.nickName.SILK_width;
    
    
    self.genderIcon = [[UIImageView alloc] init];
    self.genderIcon.image = [UIImage imageNamed:@"user_profile_boy"];
    self.genderIcon.layer.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2].CGColor;
    self.genderIcon.layer.cornerRadius = 9;
    self.genderIcon.contentMode = UIViewContentModeCenter;
    [self.containerView addSubview:self.genderIcon];
    
    self.genderIcon.SILK_left = self.nickName.SILK_left;
    self.genderIcon.SILK_top = self.brief.SILK_bottom + 8;
    self.genderIcon.SILK_height = 18;
    self.genderIcon.SILK_width = 22;
    
    
    self.city = [[UITextView alloc] init];
    self.city.text = @"成都";
    self.city.textColor = [UIColor colorWithWhite:1 alpha:1];
    self.city.font = [UIFont systemFontOfSize:10.0];
    self.city.scrollEnabled = NO;
    self.city.editable = NO;
    self.city.textContainerInset = UIEdgeInsetsMake(3, 8, 3, 8);
    self.city.textContainer.lineFragmentPadding = 0;
    
    self.city.layer.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2].CGColor;
    self.city.layer.cornerRadius = 9;
    [self.city sizeToFit];
    [self.containerView addSubview:self.city];

    self.city.SILK_left = self.genderIcon.SILK_right + 5;
    self.city.SILK_top = self.genderIcon.SILK_top;
    self.city.SILK_height = self.genderIcon.SILK_height;
    
    
    self.likeText = [[UILabel alloc] init];
    self.likeText.text = @"获赞";
    self.likeText.textColor = [UIColor colorWithWhite:1 alpha:0.6];
    self.likeText.font = [UIFont boldSystemFontOfSize:16.0];
    [self.likeText sizeToFit];
    [self.containerView addSubview:self.likeText];
    
    self.likeText.SILK_centerY = self.avatar.SILK_centerY;
    self.likeText.SILK_left = self.avatar.SILK_right + 50;
    
    self.likeNum = [[UILabel alloc] init];
    self.likeNum.text = @"666";
    self.likeNum.textColor = [UIColor colorWithWhite:1 alpha:1];
    self.likeNum.font = [UIFont boldSystemFontOfSize:18.0];
    [self.likeNum sizeToFit];
    [self.containerView addSubview:self.likeNum];

    self.likeNum.SILK_top = self.likeText.SILK_bottom + 5;
    self.likeNum.SILK_centerX = self.likeText.SILK_centerX;
    
    UIView *splitViewAfterLike = [[UIView alloc] init];
    splitViewAfterLike.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
    [self.containerView addSubview:splitViewAfterLike];
    
    NSInteger likeHeight = self.likeNum.SILK_bottom - self.likeText.SILK_top - 20;
    splitViewAfterLike.SILK_top = self.likeText.SILK_top + 10;
    splitViewAfterLike.SILK_left = self.likeText.SILK_right + 25;
    splitViewAfterLike.SILK_width = 1;
    splitViewAfterLike.SILK_height = likeHeight;
    

    self.followText = [[UILabel alloc] init];
    self.followText.text = @"关注";
    self.followText.textColor = [UIColor colorWithWhite:1 alpha:0.6];
    self.followText.font = [UIFont boldSystemFontOfSize:16.0];
    [self.followText sizeToFit];
    [self.containerView addSubview:self.followText];
    
    self.followText.SILK_centerY = self.avatar.SILK_centerY;
    self.followText.SILK_left = splitViewAfterLike.SILK_right + 25;
    
    self.followNum = [[UILabel alloc] init];
    self.followNum.text = @"777";
    self.followNum.textColor = [UIColor colorWithWhite:1 alpha:1];
    self.followNum.font = [UIFont boldSystemFontOfSize:18.0];
    [self.followNum sizeToFit];
    [self.containerView addSubview:self.followNum];
    
    UIView *splitViewAfterFollow = [[UIView alloc] init];
    splitViewAfterFollow.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
    [self.containerView addSubview:splitViewAfterFollow];
    
    splitViewAfterFollow.SILK_top = splitViewAfterLike.SILK_top;
    splitViewAfterFollow.SILK_left = self.followText.SILK_right + 25;
    splitViewAfterFollow.SILK_width = 1;
    splitViewAfterFollow.SILK_height = splitViewAfterLike.SILK_height;
    
    
    self.followedText = [[UILabel alloc] init];
    self.followedText.text = @"粉丝";
    self.followedText.textColor = [UIColor colorWithWhite:1 alpha:0.6];
    self.followedText.font = [UIFont boldSystemFontOfSize:16.0];
    [self.followedText sizeToFit];
    [self.containerView addSubview:self.followedText];
    
    self.followedText.SILK_centerY = self.avatar.SILK_centerY;
    self.followedText.SILK_left = splitViewAfterFollow.SILK_right + 25;

    self.followNum.SILK_top = self.likeNum.SILK_top;
    self.followNum.SILK_centerX = self.followText.SILK_centerX;
    
    self.followedNum = [[UILabel alloc] init];
    self.followedNum.text = @"66w";
    self.followedNum.textColor = [UIColor colorWithWhite:1 alpha:1];
    self.followedNum.font = [UIFont boldSystemFontOfSize:18.0];
    [self.followedNum sizeToFit];
    [self.containerView addSubview:self.followedNum];
    
    self.followedNum.SILK_top = self.likeNum.SILK_top;
    self.followedNum.SILK_centerX = self.followedText.SILK_centerX;
    
    self.slideTabBar = [SILKUserSlideTabBar new];
    [self addSubview:self.slideTabBar];

    self.slideTabBar.SILK_height = 40;
    self.slideTabBar.SILK_left = self.containerView.SILK_left;
    self.slideTabBar.SILK_width = self.containerView.SILK_width;
    self.slideTabBar.SILK_bottom = self.containerView.SILK_bottom;
    NSArray *titleArray = @[@"作品", @"点赞"];
    [self.slideTabBar setLabels:titleArray tabIndex:0];
}

- (void)initData:(SILKUserModel *)user {
    
}

#pragma update position when over scroll

- (void)overScrollAction:(CGFloat) offsetY {
    CGFloat scaleRatio = fabs(offsetY)/370.0f;
    CGFloat overScaleHeight = (370.0f * scaleRatio)/2;
    _topBackground.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(scaleRatio + 1.0f, scaleRatio + 1.0f), CGAffineTransformMakeTranslation(0, -overScaleHeight));
}

- (void)scrollToTopAction:(CGFloat) offsetY {
    CGFloat alphaRatio = offsetY/(370.0f - 44 - [UIApplication sharedApplication].statusBarFrame.size.height);
    self.containerView.alpha = 1.0f - alphaRatio;
}



@end
