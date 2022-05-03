//
//  SILKBaseGestureRecognizer.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/24.
//

#import "SILKBaseGestureRecognizer.h"

@implementation SILKBaseTapGestureRecognizer

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    _endPoint = [touch locationInView:self.view];
    _endEvent = event;
    [super touchesEnded:touches withEvent:event];
}

@end

@implementation SILKBasePanGestureRecognizer

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    _beganPoint = [touch locationInView:self.view];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    _endPoint = [touch locationInView:self.view];
    _endEvent = event;
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    _endPoint = [touch locationInView:self.view];
    _endEvent = event;
    [super touchesEnded:touches withEvent:event];
}

@end

@implementation SILKBaseLongPressGestureRecognizer

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    _beganPoint = [touch locationInView:self.view];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    _endPoint = [touch locationInView:self.view];
    _endEvent = event;
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    _endPoint = [touch locationInView:self.view];
    _endEvent = event;
    [super touchesEnded:touches withEvent:event];
}

@end

