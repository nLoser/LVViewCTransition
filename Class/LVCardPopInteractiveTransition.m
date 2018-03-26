//
//  LVCardPopInteractiveTransition.m
//  LVViewCTransition
//
//  Created by LV on 2018/3/25.
//  Copyright © 2018年 LV. All rights reserved.
//

#import "LVCardPopInteractiveTransition.h"

@interface LVCardPopInteractiveTransition() {
    __weak UIViewController<UIGestureRecognizerDelegate> * _toVC;
    BOOL _canPop;
}
@end

@implementation LVCardPopInteractiveTransition

- (void)writeToViewController:(UIViewController<UIGestureRecognizerDelegate> *)toVC {
    _canPop = NO;
    _toVC = toVC;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(popPan:)];
    pan.delegate = _toVC;
    [_toVC.view addGestureRecognizer:pan];
}

- (void)popPan:(UIPanGestureRecognizer *)pan {
    CGPoint location = [pan locationInView:pan.view.superview];
    CGPoint translation = [pan translationInView:pan.view.superview];
    
    CGPoint velocity = [pan velocityInView:_toVC.view];
    if (velocity.y <= 0 && !_isTransition) {
        return;
    }
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        _isTransition = YES;
        
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        
        CGFloat progress = MIN(1.0, MAX(0.0, translation.y/10.0));
        NSLog(@"%f - %f",progress,translation.y);
        
        [self updateInteractiveTransition:progress];
    }else if (pan.state == UIGestureRecognizerStateEnded ||
              pan.state == UIGestureRecognizerStateCancelled) {
        _isTransition = NO;
        if (pan.state == UIGestureRecognizerStateCancelled) {
            [self cancelInteractiveTransition];
        }else {
            [self finishInteractiveTransition];
            [_toVC.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
