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
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 12.0;
    self.layer.masksToBounds = YES;
    self.WrapperView.backgroundColor = [UIColor whiteColor];
}

@end
