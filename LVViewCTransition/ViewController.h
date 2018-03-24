//
//  ViewController.h
//  LVViewCTransition
//
//  Created by LV on 2018/3/24.
//  Copyright © 2018年 LV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVCollectionViewCell.h"

@interface ViewController : UIViewController
@property (nonatomic, weak) UIView * isPushContainerView;
@property (nonatomic, assign) CGRect isPushFromFrame;
@property (nonatomic, strong) UIView * isPushReuseView;
@end

