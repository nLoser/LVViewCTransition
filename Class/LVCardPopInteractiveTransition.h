//
//  LVCardPopInteractiveTransition.h
//  LVViewCTransition
//
//  Created by LV on 2018/3/25.
//  Copyright © 2018年 LV. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LVCardPopInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL isTransition;
- (void)writeToViewController:(UIViewController<UIGestureRecognizerDelegate> *)toVC;

@end
