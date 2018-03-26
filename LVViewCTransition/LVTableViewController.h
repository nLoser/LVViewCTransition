//
//  LVTableViewController.h
//  LVViewCTransition
//
//  Created by LV on 2018/3/24.
//  Copyright © 2018年 LV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LVTableViewController : UITableViewController<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView * tableHeader;
@property (nonatomic, strong) UIButton * closeBtn;
@end
