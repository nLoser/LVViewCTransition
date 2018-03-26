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

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (_isPush) {
        ViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        LVTableViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
       
        CGRect finalFrameToVC = [transitionContext finalFrameForViewController:toVC];
        toVC.view.frame = fromVC.isPushFromFrame;
        
        [[transitionContext containerView] addSubview:toVC.view];
        [toVC.tableHeader addSubview:fromVC.isPushReuseView];
#if 1
        [toVC.tableHeader addConstraints:@[[NSLayoutConstraint constraintWithItem:fromVC.isPushReuseView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:toVC.tableHeader
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1
                                                                         constant:0],
                                           [NSLayoutConstraint constraintWithItem:fromVC.isPushReuseView
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:toVC.tableHeader
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1
                                                                         constant:0],
                                           [NSLayoutConstraint constraintWithItem:fromVC.isPushReuseView
                                                                        attribute:NSLayoutAttributeLeft
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:toVC.tableHeader
                                                                        attribute:NSLayoutAttributeLeft
                                                                       multiplier:1
                                                                         constant:0],
                                           [NSLayoutConstraint constraintWithItem:fromVC.isPushReuseView
                                                                        attribute:NSLayoutAttributeRight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:toVC.tableHeader
                                                                        attribute:NSLayoutAttributeRight
                                                                       multiplier:1
                                                                         constant:0]
                                           ]];
#endif
        [UIView animateWithDuration:0.8
                              delay:0
             usingSpringWithDamping:0.54
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             toVC.view.frame = finalFrameToVC;
                             fromVC.view.alpha = 0.5;
                             toVC.closeBtn.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                             fromVC.view.alpha = 1;
                         }];
    }else {
        LVTableViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        ViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView * bgAlphaView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        bgAlphaView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
        
        [[transitionContext containerView] insertSubview:toVC.view belowSubview:[transitionContext containerView].subviews.firstObject];
        [[transitionContext containerView] insertSubview:bgAlphaView aboveSubview:toVC.view];

        bgAlphaView.alpha = 1;
        toVC.view.alpha = 0;
        
        fromVC.view.layer.cornerRadius = 1;
        
        CGRect isPushContainerOriginFrame = toVC.isPushContainerView.frame;
        CGRect isPushContainerSeekFrame = CGRectMake(isPushContainerOriginFrame.origin.x,
                                                     isPushContainerOriginFrame.origin.y+10,
                                                     isPushContainerOriginFrame.size.width,
                                                     isPushContainerOriginFrame.size.height);
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             toVC.isPushContainerView.frame = isPushContainerSeekFrame;
                             
                             CGFloat scaleX = toVC.isPushFromFrame.size.width / [UIScreen mainScreen].bounds.size.width;
                             fromVC.view.transform = CGAffineTransformMakeScale(scaleX, 1);
                             CGRect frame = fromVC.view.frame;
                             frame.origin = CGPointMake(toVC.isPushFromFrame.origin.x,
                                                        toVC.isPushFromFrame.origin.y + 10);
                             frame.size.height = toVC.isPushFromFrame.size.height;
                             fromVC.view.frame = frame;
                             
                             CGFloat scaleY = toVC.isPushFromFrame.size.height / ([UIScreen mainScreen].bounds.size.width * 1.2);
                             fromVC.tableHeader.transform = CGAffineTransformMakeScale(1, scaleY);
                             CGRect frame2 = fromVC.tableHeader.frame;
                             frame2.origin.y = 0;
                             fromVC.tableHeader.frame = frame2;
                             
                             fromVC.closeBtn.alpha = 0;
                             
                             fromVC.view.layer.cornerRadius = 12;
                             toVC.view.alpha = 1;
                             bgAlphaView.alpha = 0;
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                             
                             [toVC.isPushContainerView addSubview:toVC.isPushReuseView];
#if 1
                             [toVC.isPushContainerView addConstraints:@[[NSLayoutConstraint constraintWithItem:toVC.isPushReuseView
                                                                                             attribute:NSLayoutAttributeTop
                                                                                             relatedBy:NSLayoutRelationEqual
                                                                                                toItem:toVC.isPushContainerView
                                                                                             attribute:NSLayoutAttributeTop
                                                                                            multiplier:1
                                                                                              constant:0],
                                                                [NSLayoutConstraint constraintWithItem:toVC.isPushReuseView
                                                                                             attribute:NSLayoutAttributeBottom
                                                                                             relatedBy:NSLayoutRelationEqual
                                                                                                toItem:toVC.isPushContainerView
                                                                                             attribute:NSLayoutAttributeBottom
                                                                                            multiplier:1
                                                                                              constant:0],
                                                                [NSLayoutConstraint constraintWithItem:toVC.isPushReuseView
                                                                                             attribute:NSLayoutAttributeLeft
                                                                                             relatedBy:NSLayoutRelationEqual
                                                                                                toItem:toVC.isPushContainerView
                                                                                             attribute:NSLayoutAttributeLeft
                                                                                            multiplier:1
                                                                                              constant:0],
                                                                [NSLayoutConstraint constraintWithItem:toVC.isPushReuseView
                                                                                             attribute:NSLayoutAttributeRight
                                                                                             relatedBy:NSLayoutRelationEqual
                                                                                                toItem:toVC.isPushContainerView
                                                                                             attribute:NSLayoutAttributeRight
                                                                                            multiplier:1
                                                                                              constant:0]
                                                                ]];
#endif
                             [UIView animateWithDuration:0.7
                                                   delay:0.0
                                  usingSpringWithDamping:0.4
                                   initialSpringVelocity:0.1
                                                 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                                              animations:^{
                                                  toVC.isPushContainerView.frame = isPushContainerOriginFrame;
                                              }
                                              completion:nil];
                         }];
        
        
    }
}

@end
