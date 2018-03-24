//
//  ViewController.m
//  LVViewCTransition
//
//  Created by LV on 2018/3/24.
//  Copyright © 2018年 LV. All rights reserved.
//

#import "ViewController.h"
#import "LVCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    NSMutableArray * _dataArray;
    CGFloat _w;
    CGFloat _h;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _w = [UIScreen mainScreen].bounds.size.width - 40;
    _h = _w * 1.2;
    
    _dataArray = [NSMutableArray array];
    for (int i = 0; i < 100; i ++) {
        [_dataArray addObject:@(1)];
        [_dataArray addObject:@(2)];
    }
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"LVCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kCell];
}

#pragma mark - <UICollectionDelegate>

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LVCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_w, _h);
}

@end
