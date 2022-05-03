//
//  SILKFeedSharePopView.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SILKFeedSharePopView : UIView

@property (nonatomic, strong) UIView           *container;

@property (nonatomic, strong) UIButton         *cancel;

- (void)show;

- (void)dismiss;

@end


@interface ShareItem : UIView

@property (nonatomic, strong) UIImageView      *icon;

@property (nonatomic, strong) UILabel          *label;

- (void)startAnimation:(NSTimeInterval)delayTime;

@end


NS_ASSUME_NONNULL_END
