//
//  LVCollectionViewCell.m
//  LVViewCTransition
//
//  Created by LV on 2018/3/24.
//  Copyright © 2018年 LV. All rights reserved.
//

#import "LVCollectionViewCell.h"

@implementation LVCollectionViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    self.layer.cornerRadius = 12.0;
    self.layer.masksToBounds = YES;
    self.WrapperView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
}

@end
