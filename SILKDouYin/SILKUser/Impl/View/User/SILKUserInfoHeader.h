//
//  SILKUserInfoHeader.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/16.
//

#import <UIKit/UIKit.h>

@class SILKUserModel;
@class SILKUserSlideTabBar;

NS_ASSUME_NONNULL_BEGIN

@interface SILKUserInfoHeader : UICollectionReusableView

@property (nonatomic, assign) BOOL                         isFollowed;

@property (nonatomic, strong) UIImageView                  *avatar;
@property (nonatomic, strong) UIImageView                  *topBackground;
@property (nonatomic, strong) UIImageView                  *bottomBackground;

@property (nonatomic, strong) UILabel                      *nickName;
@property (nonatomic, strong) UILabel                      *douyinNum;
@property (nonatomic, strong) UILabel                      *brief;
@property (nonatomic, strong) UIImageView                  *genderIcon;
@property (nonatomic, strong) UITextView                   *city;
@property (nonatomic, strong) UILabel                      *likeText;
@property (nonatomic, strong) UILabel                      *likeNum;
@property (nonatomic, strong) UILabel                      *followText;
@property (nonatomic, strong) UILabel                      *followNum;
@property (nonatomic, strong) UILabel                      *followedText;
@property (nonatomic, strong) UILabel                      *followedNum;

@property (nonatomic, strong) SILKUserSlideTabBar                  *slideTabBar;

- (void)initData:(SILKUserModel *)user;
- (void)overScrollAction:(CGFloat) offsetY;
- (void)scrollToTopAction:(CGFloat) offsetY;

@end

NS_ASSUME_NONNULL_END
