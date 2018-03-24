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
    self.layer.cornerRadius = 8.0;
    self.layer.masksToBounds = YES;
}

@end
