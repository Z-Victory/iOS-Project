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
#import "TagSecondCell.h"
#import "TagThirdCell.h"
#import "TagModel.h"
#import "TagThirdHeaderView.h"
#import <Masonry.h>
#import "NewTagCell.h"

@interface TagsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LeeIrregularCollectionViewFlowLayoutDelegate>
@property (nonatomic,strong) UICollectionView * collect;
@property (nonatomic,strong) NSMutableArray * sectionArray;
@property (nonatomic,strong) NSMutableArray * dataArray1;
@property (nonatomic,strong) NSMutableArray * dataArray2;
@property (nonatomic,strong) NSMutableArray * dataArray3;
@property (nonatomic,assign) int addTagSection;//记录点击新增的分组
@end

@implementation TagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _addTagSection = 0;
    _dataArray1 = [NSMutableArray arrayWithObjects:@"美国队长",@"雷神",@"惊奇队长",@"银河护卫队",@"蚁人",@"黑豹",@"蜘蛛侠",@"奇异博士",@"钢铁侠",@"绿巨人", nil];
    [_dataArray1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TagModel * model = [TagModel new];
        model.title = (NSString *)obj;
        [_dataArray1 replaceObjectAtIndex:idx withObject:model];
    }];
    
    
    _dataArray2 = [NSMutableArray arrayWithObjects:@"超人",@"神奇女侠",@"闪电侠",@"蝙蝠侠", nil];
    [_dataArray2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TagModel * model = [TagModel new];
        model.title = (NSString *)obj;
        [_dataArray2 replaceObjectAtIndex:idx withObject:model];
    }];
    
    _dataArray3 = [NSMutableArray arrayWithObjects:@"金刚狼",@"黑凤凰",@"死侍",@"暴风女", nil];
    [_dataArray3 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TagModel * model = [TagModel new];
        model.title = (NSString *)obj;
        [_dataArray3 replaceObjectAtIndex:idx withObject:model];
    }];
    
    _sectionArray = [NSMutableArray arrayWithObjects:_dataArray1,_dataArray2,_dataArray3, nil];
    
    LeeIrregularCollectionViewFlowLayout *flowLayout =  [[LeeIrregularCollectionViewFlowLayout alloc] init];
    flowLayout.leeFlowLayoutdelegate = self;
    
    _collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    _collect.backgroundColor = UIColor.whiteColor;
    
    [_collect registerNib:[UINib nibWithNibName:@"LYHCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LYHCollectionViewCell"];
    
    [_collect registerNib:[UINib nibWithNibName:@"TagSecondCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"TagSecondCell"];
    
    [_collect registerNib:[UINib nibWithNibName:@"TagThirdCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"TagThirdCell"];
    [_collect registerNib:[UINib nibWithNibName:@"NewTagCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"NewTagCell"];
    
    
    
    [_collect registerNib:[UINib nibWithNibName:@"LYHCollectionHeaderView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LYHCollectionHeaderView"];
    [_collect registerNib:[UINib nibWithNibName:@"TagSecondHeaderView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TagSecondHeaderView"];
    [_collect registerNib:[UINib nibWithNibName:@"TagThirdHeaderView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TagThirdHeaderView"];
    
    
    _collect.delegate = self;
    _collect.dataSource = self;
    [self.view addSubview:_collect];
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,LeeIrregularCollectionViewFlowLayoutDelegate
- (CGSize)LeeIrregularCollectionViewFlowLayout:(UICollectionViewLayout *)layout itemSizeForIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.dataArray1.count && indexPath.section == 0) {
        return CGSizeMake(88, 34);
    }else if (indexPath.row == self.dataArray2.count && indexPath.section == 1) {
        return CGSizeMake(70, 28);
    }else{
        NSArray * array = self.sectionArray[indexPath.section];
        TagModel * c = array[indexPath.row];
        CGFloat width = [c.title boundingW:30 font:[UIFont systemFontOfSize:14 weight:5]].width;
        if (indexPath.section == 2) {
            return CGSizeMake(width+32, 44);
        }else if (indexPath.section == 1){
            return CGSizeMake(width+32, 28);
        }
        return CGSizeMake(width+32, 34);
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sectionArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray * array = self.sectionArray[section];
    if (section == 0 || section == 1) {
        return array.count + 1;
    }
    return array.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == self.dataArray1.count) {
            NewTagCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewTagCell" forIndexPath:indexPath];
            return cell;
        }
        LYHCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LYHCollectionViewCell" forIndexPath:indexPath];
        NSArray * array = self.sectionArray[indexPath.section];
        cell.model = array[indexPath.row];
        return cell;
    }else if(indexPath.section == 1){
        if (indexPath.row == self.dataArray2.count) {
            NewTagCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewTagCell" forIndexPath:indexPath];
            return cell;
        }
        TagSecondCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagSecondCell" forIndexPath:indexPath];
        NSArray * array = self.sectionArray[indexPath.section];
        cell.model = array[indexPath.row];
        return cell;
    }else if(indexPath.section == 2){
        TagThirdCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagThirdCell" forIndexPath:indexPath];
        cell.deleteBlock = ^{
            TagModel * model = self.dataArray3[indexPath.row];
            model.isSelect = NO;
            [self.dataArray3 removeObjectAtIndex:indexPath.row];
            [self.collect reloadData];
        };
        NSArray * array = self.sectionArray[indexPath.section];
        cell.model = array[indexPath.row];
        return cell;
    }else{
        return nil;
    }
}
- (CGSize)LeeIrregularCollectionViewFlowLayout:(UICollectionViewLayout *)layout headerViewSizeForIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(self.view.frame.size.width, 44);
    return size;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView * headerView;
        if (indexPath.section == 0) {
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LYHCollectionHeaderView" forIndexPath:indexPath];
        }else if (indexPath.section == 1){
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TagSecondHeaderView" forIndexPath:indexPath];
        }else{
            TagThirdHeaderView * thirdHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TagThirdHeaderView" forIndexPath:indexPath];
            if (thirdHeaderView.subviews.count > 0) {
                for (UIView * view in thirdHeaderView.subviews) {
                    [view removeFromSuperview];
                }
            }
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            [thirdHeaderView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(thirdHeaderView);
                make.left.mas_equalTo(15);
            }];
            NSString * string = [NSString stringWithFormat:@"已选择%li个分类标签",self.dataArray3.count];
            NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes: @{NSFontAttributeName: [UIFont systemFontOfSize:12],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];

            NSRange range = NSMakeRange(3, [@(self.dataArray3.count) stringValue].length);
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium] range:range];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.000000] range:range];

            label.attributedText = attributedString;
            label.textAlignment = NSTextAlignmentLeft;
            headerView = thirdHeaderView;
            
        }
        
        return headerView;
    }else {
        return nil;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld,%ld",(long)indexPath.section,(long)indexPath.row);
    
    if (indexPath.section == 0) {
        if (indexPath.row == self.dataArray1.count) {
            _addTagSection = 0;
            [self addNewTag];
            return;
        }
        NSArray * array = self.sectionArray[indexPath.section];
        TagModel * model = array[indexPath.row];
        model.isSelect = YES;
        if (![_dataArray3 containsObject:model]) {
            [_dataArray3 addObject:model];
            [collectionView reloadData];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == self.dataArray2.count) {
            _addTagSection = 1;
            [self addNewTag];
            return;
        }
        NSArray * array = self.sectionArray[indexPath.section];
        TagModel * model = array[indexPath.row];
        model.isSelect = YES;
        if (![_dataArray3 containsObject:model]) {
            [_dataArray3 addObject:model];
            [collectionView reloadData];
        }
    }
}
- (void)alertTextFieldDidChange:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *login = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = login.text.length > 0;
    }
}
- (void)addNewTag{

    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"新标签" message:@"添加新的标签" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Reset Action");
    }];
    [alert addAction:cancleAction];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
        TagModel * newTag = [TagModel new];
        UITextField * textField = alert.textFields.firstObject;
        newTag.title = textField.text;
        if (weakSelf.addTagSection == 0) {
            [self.dataArray1 addObject:newTag];
        }else{
            [self.dataArray2 addObject:newTag];
        }
        
        [self.collect reloadData];
    }];
    okAction.enabled = NO;
    [alert addAction:okAction];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
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
