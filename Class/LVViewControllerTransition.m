//
//  LVViewControllerTransition.m
//  LVViewCTransition
//
//  Created by LV on 2018/3/24.
//  Copyright © 2018年 LV. All rights reserved.
//

#import "LVViewControllerTransition.h"
#import <UIKit/UIScreen.h>

#import "ViewController.h"
#import "LVTableViewController.h"

@interface LVViewControllerTransition () {
    
}
@end

@implementation LVViewControllerTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}


// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (_isPush) {
        ViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        LVTableViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
       
        CGRect finalFrameToVC = [transitionContext finalFrameForViewController:toVC];
        toVC.view.frame = fromVC.isPushFromFrame;
        
        [[transitionContext containerView] addSubview:toVC.view];
        [toVC.tableHeader addSubview:fromVC.isPushReuseView];
        [fromVC.isPushReuseView needsUpdateConstraints];
        
        [UIView animateWithDuration:0.8
                              delay:0.0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0.1
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             fromVC.view.alpha = 0.5;
                             toVC.view.frame = finalFrameToVC;
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                             fromVC.view.alpha = 1;
                         }];
    }else {
        LVTableViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        ViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        CGRect finalFrameToVC = [transitionContext finalFrameForViewController:toVC];
        
        toVC.view.alpha = 0;
        [[transitionContext containerView] addSubview:toVC.view];
        
        fromVC.view.layer.cornerRadius = 1;
        fromVC.view.layer.masksToBounds = YES;
        
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0.1
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             fromVC.view.layer.cornerRadius = 8;
                             fromVC.view.frame = toVC.isPushFromFrame;
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                             toVC.view.alpha = 1;
                             [toVC.isPushContainerView addSubview:toVC.isPushReuseView];
                         }];
        
        
    }
}

@end
