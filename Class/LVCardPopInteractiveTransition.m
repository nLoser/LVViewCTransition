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
static CGFloat sBeginY = 0;
static CGFloat sScale = 1;
static BOOL sCanPop = NO;
static CFTimeInterval sTime = 0;

- (void)popPan:(UIPanGestureRecognizer *)pan {
    CGPoint velocity = [pan velocityInView:_toVC.view];
    if (velocity.y <= 0 && !_isTransition) return;
    CGPoint location = [pan locationInView:pan.view.superview];

    if (pan.state == UIGestureRecognizerStateBegan) {
        _isTransition = YES;
        sBeginY = location.y;
        sScale = (([UIScreen mainScreen].bounds.size.width - sSlideDistance) / [UIScreen mainScreen].bounds.size.width);
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        CGFloat originY = velocity.y;
        CGPoint translation = [pan translationInView:pan.view.superview];
        CGFloat progress = 1 - 0.2 * (MIN(sSlideDistance, MAX(location.y - sBeginY, 0))/sSlideDistance);
        
        if (originY > 0) {
            _canPop = translation.y>=sSlideDistance?YES:NO;
        }else {
            _canPop = NO;
        }
        CGFloat radius = 12 * (((1-progress)/(1-sScale)));
        _toVC.view.layer.cornerRadius = radius;
        _toVC.view.transform = CGAffineTransformMakeScale(progress, progress);
        [self updateInteractiveTransition:progress];
        if (_canPop) {
            if (!sCanPop) {
                sCanPop = YES;
                sTime = CACurrentMediaTime();
            }else {
                if (CACurrentMediaTime() - sTime >= 0.2) {
                    pan.enabled = NO;
                }
            }
        }else {
            sCanPop = NO;
        }
    }else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        ((UITableViewController *)_toVC).tableView.scrollEnabled = YES;
        _isTransition = NO;
        if (_canPop) {
            [self finishInteractiveTransition];
            [_toVC.navigationController popViewControllerAnimated:YES];
        }else {
            [self cancelInteractiveTransition];
            [UIView animateWithDuration:0.2 animations:^{
                _toVC.view.transform = CGAffineTransformMakeScale(1, 1);
            }];
        }
        _toVC.view.userInteractionEnabled = YES;
        _canPop = NO;
    }
}

@end
