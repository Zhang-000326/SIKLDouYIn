//
//  SILKSplashMotionManager.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/20.
//

#import "SILKSplashMotionManager.h"
#import <CoreMotion/CoreMotion.h>

@interface SILKSplashMotionManager ()

@property (nonatomic, strong) CMMotionManager *manager;

@end

@implementation SILKSplashMotionManager

+ (instancetype)sharedInstance {
    static SILKSplashMotionManager *manager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[SILKSplashMotionManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _manager = [[CMMotionManager alloc] init];
        _manager.accelerometerUpdateInterval = 0.1;
        _accelerometer = 12 / 9.8;
    }
    return self;
}

#pragma mark - Public Method

- (void)startDetectMotion {
    self.isDetecting = YES;
    __weak typeof(self) weakSelf = self;
    [self.manager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *_Nullable accelerometerData, NSError *_Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        CMAcceleration acceleration = accelerometerData.acceleration;
        double accelerometer = sqrt(pow(acceleration.x, 2) + pow(acceleration.y, 2) + pow(acceleration.z, 2));
        NSLog(@"zq accelerometer %f", accelerometer);
        if (accelerometer >= strongSelf.accelerometer) {
            if ([strongSelf.delegate respondsToSelector:@selector(didReceiveShakeEvent)]) {
                [strongSelf.delegate didReceiveShakeEvent];
                [strongSelf stopDetectMotion];
            }
        }
    }];
}

- (void)stopDetectMotion {
    if (!self.isDetecting) {
        return;
    }
    
    [self.manager stopAccelerometerUpdates];
    self.isDetecting = NO;
}

#pragma mark - Private Method


@end
