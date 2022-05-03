//
//  SILKBaseGestureRecognizer.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SILKBaseTapGestureRecognizer : UITapGestureRecognizer

@property (nonatomic, assign, readonly) CGPoint endPoint;  ///<点击时相对于事件绑定view的坐标
@property (nonatomic, strong, readonly) UIEvent *endEvent; ///<点击时的事件

@end

@interface SILKBasePanGestureRecognizer : UIPanGestureRecognizer

@property (nonatomic, assign, readonly) CGPoint beganPoint; ///<开始滑动时相对于事件绑定view的坐标
@property (nonatomic, assign, readonly) CGPoint endPoint;  ///<滑动结束时相对于事件绑定view的坐标
@property (nonatomic, strong, readonly) UIEvent *endEvent; ///<点击时的事件

@end

@interface SILKBaseLongPressGestureRecognizer : UILongPressGestureRecognizer

@property (nonatomic, assign, readonly) CGPoint beganPoint; ///< 开始长按时相对于事件绑定view的坐标
@property (nonatomic, assign, readonly) CGPoint endPoint;  ///< 长按结束时相对于事件绑定view的坐标
@property (nonatomic, strong, readonly) UIEvent *endEvent; ///< 点击时的事件

@end

NS_ASSUME_NONNULL_END
