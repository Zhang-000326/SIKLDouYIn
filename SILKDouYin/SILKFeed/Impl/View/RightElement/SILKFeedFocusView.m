//
//  SILKFeedFocusView.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/20.
//

#import "SILKFeedFocusView.h"

@interface SILKFeedFocusView ()<CAAnimationDelegate>

@end

@implementation SILKFeedFocusView

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, 24, 24)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.layer.cornerRadius = frame.size.width/2;
        self.layer.backgroundColor = [UIColor colorWithRed:241/255.f green:47/255.f blue:84/255.f alpha:1].CGColor;
        self.image = [UIImage imageNamed:@"feed_focus"];
        self.contentMode = UIViewContentModeCenter;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(beginAnimation)]];
    }
    return self;
}

-(void)beginAnimation {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.delegate = self;
    animationGroup.duration = 1.25f;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAKeyframeAnimation *scaleAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    [scaleAnim setValues:@[
                           [NSNumber numberWithFloat:1.0f],
                           [NSNumber numberWithFloat:1.2f],
                           [NSNumber numberWithFloat:1.2f],
                           [NSNumber numberWithFloat:1.2f],
                           [NSNumber numberWithFloat:1.2f],
                           [NSNumber numberWithFloat:1.2f],
                           [NSNumber numberWithFloat:1.2f],
                           [NSNumber numberWithFloat:0.0f]]];
    
    CAKeyframeAnimation *rotationAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    [rotationAnim setValues:@[
                              [NSNumber numberWithFloat:-1.5f*M_PI],
                              [NSNumber numberWithFloat:0.0f],
                              [NSNumber numberWithFloat:0.0f],
                              [NSNumber numberWithFloat:0.0f]]];
    
    CAKeyframeAnimation * opacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    [opacityAnim setValues:@[
                             [NSNumber numberWithFloat:0.8f],
                             [NSNumber numberWithFloat:1.0f],
                             [NSNumber numberWithFloat:1.0f]]];
    
    [animationGroup setAnimations:@[scaleAnim,
                                    rotationAnim,
                                    opacityAnim]];
    [self.layer addAnimation:animationGroup forKey:nil];
}


- (void)animationDidStart:(CAAnimation *)anim {
    self.userInteractionEnabled = NO;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.layer.backgroundColor = [UIColor colorWithRed:241/255.f green:47/255.f blue:84/255.f alpha:1].CGColor;
    self.image = [UIImage imageNamed:@"feed_focus_done"];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.userInteractionEnabled = YES;
    self.contentMode = UIViewContentModeCenter;
    [self setHidden:YES];
}


- (void)resetView {
    self.layer.backgroundColor = [UIColor colorWithRed:241/255.f green:47/255.f blue:84/255.f alpha:1].CGColor;
    self.image = [UIImage imageNamed:@"feed_focus"];
    [self.layer removeAllAnimations];
    [self setHidden:NO];
}
@end
