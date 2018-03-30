//
//  ViewController.m
//  LVViewCTransition
//
//  Created by LV on 2018/3/24.
//  Copyright © 2018年 LV. All rights reserved.
//

#import "ViewController.h"
#import "LVTableViewController.h"

#import "LVViewControllerTransition.h"
#import "LVCardPopInteractiveTransition.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate> {
    NSMutableArray * _dataArray;
    CGFloat _w;
    CGFloat _h;
    __weak LVCollectionViewCell * _highlightCell;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) LVViewControllerTransition * transition;
@property (nonatomic, strong) LVCardPopInteractiveTransition * popInteractiveTransition;
@end

@implementation ViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.navigationController setNavigationBarHidden:YES];
}

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
    
    _transition = [[LVViewControllerTransition alloc] init];
    _popInteractiveTransition = [[LVCardPopInteractiveTransition alloc] init];
    
    self.navigationController.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
}

#pragma mark - <UINavigationControllerDelegate>

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    _transition.isPush = (operation == UINavigationControllerOperationPush);
    return _transition;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return _popInteractiveTransition.isTransition?_popInteractiveTransition:nil;
}

#pragma mark - <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
     _highlightCell = (id)[collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _highlightCell.transform = CGAffineTransformMakeScale(0.95, 0.95);
    } completion:nil];
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_highlightCell) {
        [UIView animateWithDuration:0.2 animations:^{
            _highlightCell.transform = CGAffineTransformMakeScale(1, 1);
        }];
        _highlightCell = nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_highlightCell) {
        [UIView animateWithDuration:0.2 animations:^{
            _highlightCell.transform = CGAffineTransformMakeScale(1, 1);
        }];
        _highlightCell = nil;
    }
    LVTableViewController * vc = [LVTableViewController new];
    LVCollectionViewCell * cell = (id)[collectionView cellForItemAtIndexPath:indexPath];
    
    _isPushReuseView = cell.WrapperView;
    _isPushFromFrame = [_collectionView convertRect:cell.frame toView:self.view];
    _isPushContainerView = cell;
    [_popInteractiveTransition writeToViewController:vc];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - <UICollectionViwDataSource>

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
