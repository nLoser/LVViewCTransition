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

static CGFloat beginY = 0;
- (void)popPan:(UIPanGestureRecognizer *)pan {
    CGPoint location = [pan locationInView:pan.view.superview];
    CGPoint translation = [pan translationInView:pan.view.superview];
    
    CGPoint velocity = [pan velocityInView:_toVC.view];
    if (velocity.y <= 0 && !_isTransition) return;
    CGFloat originY = velocity.y;
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        _isTransition = YES;
        beginY = location.y;
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        
        if (originY > 0) {
            CGFloat progress = MIN(1.0, MAX(0.0, translation.y/65));
            CGFloat scaleX = ([UIScreen mainScreen].bounds.size.width - MIN(65, translation.y)) / [UIScreen mainScreen].bounds.size.width;
            scaleX = MIN(1, scaleX);
            _toVC.view.transform = CGAffineTransformMakeScale(scaleX, scaleX);
            _toVC.view.layer.cornerRadius = 12 * progress;
            _canPop = translation.y>=65?YES:NO;
            [self updateInteractiveTransition:progress];
        }else {
            CGFloat parallax = MIN(MAX(translation.y - beginY, 0), 65);
            CGFloat progress = 1- (parallax / 65.0);
            if (progress == 1) {
                beginY = location.y;
            }
            _toVC.view.transform = CGAffineTransformMakeScale(progress, progress);
            _toVC.view.layer.cornerRadius = 12 * progress;
            _canPop = NO;
            [self updateInteractiveTransition:progress];
        }
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
