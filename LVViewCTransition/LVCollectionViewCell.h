//
//  LVCollectionViewCell.h
//  LVViewCTransition
//
//  Created by LV on 2018/3/24.
//  Copyright © 2018年 LV. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCell @"LVCellReuseIdentifier"

@interface LVCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *WrapperView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITextView *subTitle;
@property (weak, nonatomic) IBOutlet UITextView *content;
@end
