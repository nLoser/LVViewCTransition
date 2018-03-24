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
    _bgImg.layer.cornerRadius = 8.0;
    _bgImg.layer.masksToBounds = YES;
}

@end
