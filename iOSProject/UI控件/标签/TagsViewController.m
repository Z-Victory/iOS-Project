//
//  TagsViewController.m
//  iOSProject
//
//  Created by mana on 2020/7/23.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "TagsViewController.h"
#import "LeeIrregularCollectionViewFlowLayout.h"
#import "NSString+Tool.h"
#import "LYHCollectionViewCell.h"

@interface TagsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LeeIrregularCollectionViewFlowLayoutDelegate>
@property (nonatomic,strong) UICollectionView * collect;
@property (nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation TagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray arrayWithObjects:@"人人网",@"热污染无",@"而我二翁sss",@"是的热123无",@"we",@"rwerwrweewrew", nil];
    
    LeeIrregularCollectionViewFlowLayout *flowLayout =  [[LeeIrregularCollectionViewFlowLayout alloc] init];
    flowLayout.leeFlowLayoutdelegate = self;
    
    _collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    _collect.backgroundColor = UIColor.whiteColor;
    [_collect registerNib:[UINib nibWithNibName:@"LYHCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LYHCollectionViewCell"];
    _collect.delegate = self;
    _collect.dataSource = self;
    [self.view addSubview:_collect];
}
- (CGSize)LeeIrregularCollectionViewFlowLayout:(UICollectionViewLayout *)layout itemSizeForIndexPath:(NSIndexPath *)indexPath{
    NSString * c = self.dataArray[indexPath.row];
    CGFloat width = [NSString getWidthWithText:c height:17 font:17];
    return CGSizeMake(width, 44);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LYHCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LYHCollectionViewCell" forIndexPath:indexPath];
    cell.label.text = self.dataArray[indexPath.row];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
