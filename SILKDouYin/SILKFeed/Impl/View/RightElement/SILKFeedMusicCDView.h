//
//  SILKFeedMusicCDView.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SILKFeedMusicCDView : UIView

@property (nonatomic, strong) UIImageView *musicCD;

- (void)startAnimation:(CGFloat)rate;

- (void)resetView;

@end

NS_ASSUME_NONNULL_END
