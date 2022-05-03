//
//  SILKUserLoginView.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SILKUserLoginDelegate <NSObject>

@required

- (void)loginViewShowFinished;

@end

@interface SILKUserLoginView : UIView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<SILKUserLoginDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
