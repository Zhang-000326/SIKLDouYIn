//
//  SILKFeedLoveView.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/20.
//

#import "SILKFeedLoveView.h"

static const NSInteger kSILKFeedLoveViewBeforeClickTag  = 0x01;
static const NSInteger kSILKFeedLoveViewAfterClickTag   = 0x02;

@implementation SILKFeedLoveView

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, 50, 45)];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self) {
        _loveBeforeClick = [[UIImageView alloc]initWithFrame:frame];
        _loveBeforeClick.contentMode = UIViewContentModeCenter;
        _loveBeforeClick.image = [UIImage imageNamed:@"feed_love_before_click"];
        _loveBeforeClick.userInteractionEnabled = YES;
        _loveBeforeClick.tag = kSILKFeedLoveViewBeforeClickTag;
        [_loveBeforeClick addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
        [self addSubview:_loveBeforeClick];
        
        _loveAfterClick = [[UIImageView alloc]initWithFrame:frame];
        _loveAfterClick.contentMode = UIViewContentModeCenter;
        _loveAfterClick.image = [UIImage imageNamed:@"feed_love_after_click"];
        _loveAfterClick.userInteractionEnabled = YES;
        _loveAfterClick.tag = kSILKFeedLoveViewAfterClickTag;
        [_loveAfterClick setHidden:YES];
        [_loveAfterClick addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
        [self addSubview:_loveAfterClick];
    }
    return self;
}

- (void)handleGesture:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case kSILKFeedLoveViewBeforeClickTag: {
            [self startLikeAnim:YES];
            break;
        }
        case kSILKFeedLoveViewAfterClickTag: {
            [self startLikeAnim:NO];
            break;
        }
    }
}

-(void)startLikeAnim:(BOOL)isLike {
    
    _loveBeforeClick.userInteractionEnabled = NO;
    _loveAfterClick.userInteractionEnabled = NO;
    if(isLike) {
        CGFloat length = 30;
        CGFloat duration = 0.5;
        for(int i=0;i<6;i++) {
            CAShapeLayer *layer = [[CAShapeLayer alloc]init];
            layer.position = _loveBeforeClick.center;
            layer.fillColor = [UIColor colorWithRed:241/255.f green:47/255.f blue:84/255.f alpha:1].CGColor;
            
            UIBezierPath *startPath = [UIBezierPath bezierPath];
            [startPath moveToPoint:CGPointMake(-2, -length)];
            [startPath addLineToPoint:CGPointMake(2, -length)];
            [startPath addLineToPoint:CGPointMake(0, 0)];
            
            UIBezierPath *endPath = [UIBezierPath bezierPath];
            [endPath moveToPoint:CGPointMake(-2, -length)];
            [endPath addLineToPoint:CGPointMake(2, -length)];
            [endPath addLineToPoint:CGPointMake(0, -length)];

            layer.path = startPath.CGPath;
            layer.transform = CATransform3DMakeRotation(M_PI / 3.0f * i, 0.0, 0.0, 1.0);
            [self.layer addSublayer:layer];
            
            CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
            group.removedOnCompletion = NO;
            group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            group.fillMode = kCAFillModeForwards;
            group.duration = duration;
            
            CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnim.fromValue = @(0.0);
            scaleAnim.toValue = @(1.0);
            scaleAnim.duration = duration * 0.2f;
            
            CABasicAnimation *pathAnim = [CABasicAnimation animationWithKeyPath:@"path"];
            pathAnim.fromValue = (__bridge id)layer.path;
            pathAnim.toValue = (__bridge id)endPath.CGPath;
            pathAnim.beginTime = duration * 0.2f;
            pathAnim.duration = duration * 0.8f;
            
            [group setAnimations:@[scaleAnim, pathAnim]];
            [layer addAnimation:group forKey:nil];
        }
        [_loveAfterClick setHidden:NO];
        _loveAfterClick.alpha = 0.0f;
        _loveAfterClick.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(-M_PI/3*2), 0.5f, 0.5f);
        [UIView animateWithDuration:0.4f
                              delay:0.2f
             usingSpringWithDamping:0.6f
              initialSpringVelocity:0.8f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.loveBeforeClick.alpha = 0.0f;
                             self.loveAfterClick.alpha = 1.0f;
                             self.loveAfterClick.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(0), 1.0f, 1.0f);
                         }
                         completion:^(BOOL finished) {
                             self.loveBeforeClick.alpha = 1.0f;
                             self.loveBeforeClick.userInteractionEnabled = YES;
                             self.loveAfterClick.userInteractionEnabled = YES;
                         }];
    }else {
        _loveAfterClick.alpha = 1.0f;
        _loveAfterClick.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(0), 1.0f, 1.0f);
        [UIView animateWithDuration:0.35f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.loveAfterClick.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(-M_PI_4), 0.1f, 0.1f);
                         }
                         completion:^(BOOL finished) {
                             [self.loveAfterClick setHidden:YES];
                             self.loveBeforeClick.userInteractionEnabled = YES;
                             self.loveAfterClick.userInteractionEnabled = YES;
                         }];
    }
}

- (void)resetView {
    [_loveBeforeClick setHidden:NO];
    [_loveAfterClick setHidden:YES];
    [self.layer removeAllAnimations];
}
@end
