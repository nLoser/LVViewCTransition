//
//  LVViewControllerTransition.h
//  LVViewCTransition
//
//  Created by LV on 2018/3/24.
//  Copyright © 2018年 LV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LVViewControllerTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL isPush;
@end
