//
//  SILKSplashView+Gesture.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/10.
//

#import "SILKSplashView.h"

@class SILKBasePanGestureRecognizer;

NS_ASSUME_NONNULL_BEGIN

@interface SILKSplashView (Gesture)

- (void)onPagePanGesture:(SILKBasePanGestureRecognizer *)gesture;

@end

NS_ASSUME_NONNULL_END
