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
        
        toVC.view.alpha = 0;
        [transitionContext containerView].backgroundColor = [UIColor whiteColor];
        [[transitionContext containerView] addSubview:toVC.view];
        
        fromVC.view.layer.cornerRadius = 1;
        fromVC.view.layer.masksToBounds = YES;
        
        CGRect isPushContainerOriginFrame = toVC.isPushContainerView.frame;
        CGRect isPushContainerSeekFrame = CGRectMake(isPushContainerOriginFrame.origin.x,
                                                     isPushContainerOriginFrame.origin.y+5,
                                                     isPushContainerOriginFrame.size.width,
                                                     isPushContainerOriginFrame.size.height);
        
        [UIView animateWithDuration:0.4
                              delay:0.0
             usingSpringWithDamping:0.0
              initialSpringVelocity:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             toVC.isPushContainerView.frame = isPushContainerSeekFrame;
                             fromVC.view.frame = isPushContainerSeekFrame;
                             fromVC.view.layer.cornerRadius = 8;
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                             [toVC.isPushContainerView addSubview:toVC.isPushReuseView];
                             toVC.view.alpha = 1;
                             
                             [UIView animateWithDuration:0.8
                                                   delay:0.0
                                  usingSpringWithDamping:0.5
                                   initialSpringVelocity:0.0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  toVC.isPushContainerView.frame = isPushContainerOriginFrame;
                                              }
                                              completion:nil];
                         }];
        
        
    }
}

@end
