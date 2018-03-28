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

static CGFloat sSlideDistance = 65.f;
static CGFloat sbeginY = 0;
static CGFloat sScale = 1;

- (void)popPan:(UIPanGestureRecognizer *)pan {
    CGPoint velocity = [pan velocityInView:_toVC.view];
    if (velocity.y <= 0 && !_isTransition) return;
    
    CGFloat originY = velocity.y;
    CGPoint location = [pan locationInView:pan.view.superview];
    CGPoint translation = [pan translationInView:pan.view.superview];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        _isTransition = YES;
        sbeginY = location.y;
        sScale = (([UIScreen mainScreen].bounds.size.width - sSlideDistance) / [UIScreen mainScreen].bounds.size.width);
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        CGFloat progress = 1 - 0.2 * (MIN(65, MAX(location.y - sbeginY, 0))/65.0);
        if (originY > 0) {
            _canPop = translation.y>=65?YES:NO;
        }else {
            _canPop = NO;
        }
        CGFloat radius = 12 * progress;
        _toVC.view.layer.cornerRadius = radius;
        _toVC.view.transform = CGAffineTransformMakeScale(progress, progress);
        [self updateInteractiveTransition:progress];
    }else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        ((UITableViewController *)_toVC).tableView.scrollEnabled = YES;
        _isTransition = NO;
        if (pan.state == UIGestureRecognizerStateCancelled) {
            [self cancelInteractiveTransition];
            [UIView animateWithDuration:0.2 animations:^{
                _toVC.view.transform = CGAffineTransformMakeScale(1, 1);
            }];
        }else {
            if (_canPop) {
                [self finishInteractiveTransition];
                [_toVC.navigationController popViewControllerAnimated:YES];
            }else {
                [self cancelInteractiveTransition];
                [UIView animateWithDuration:0.2 animations:^{
                    _toVC.view.transform = CGAffineTransformMakeScale(1, 1);
                }];
            }
        }
        _canPop = NO;
    }
}

@end
