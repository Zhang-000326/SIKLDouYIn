//
//  SILKFeedLoveView.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SILKFeedLoveView : UIView

@property (nonatomic, strong) UIImageView      *loveBeforeClick;

@property (nonatomic, strong) UIImageView      *loveAfterClick;

- (void)resetView;

@end

NS_ASSUME_NONNULL_END
