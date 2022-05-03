//
//  SILKSplashMotionManager.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SILKSplashMotionDelegate <NSObject>

@required

- (void)didReceiveShakeEvent;

@end

@interface SILKSplashMotionManager : NSObject

@property (nonatomic, weak) id<SILKSplashMotionDelegate> delegate;

@property (nonatomic, assign) CGFloat accelerometer;    ///<加速度阈值，单位为 g = 9.8 m/s^2

@property (nonatomic, assign) BOOL isDetecting;         ///<是否正在采样

+ (instancetype)sharedInstance;

- (void)startDetectMotion;

- (void)stopDetectMotion;

@end

NS_ASSUME_NONNULL_END
