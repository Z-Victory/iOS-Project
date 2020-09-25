//
//  MenuTableView.m
//  iOSProject
//
//  Created by mana on 2020/8/12.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "MenuTableCollectView.h"
#import "MenuTableCollectCell.h"

@implementation MenuTableCollectView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self addSubview:_tableView];
    }
    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.delegate respondsToSelector:@selector(numberOfMenuCollect:)]) {
        NSInteger lines = [self.delegate numberOfMenuCollect:self];
        return lines;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuTableCollectCell *cell = [MenuTableCollectCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.tag = indexPath.row;
    //获取风格
    MenuCollectUIStyle style;
    if ([self.delegate respondsToSelector:@selector(uiStyleOfMenuCollect:line:)]) {
        style = [self.delegate uiStyleOfMenuCollect:self line:cell.tag];
        if (style == MenuCollectUIStyleFirst) {
            cell.titleLabel.hidden = NO;
        }else{
            cell.titleLabel.hidden = YES;
        }
    }
    //获取行名称
    NSString * rowName;
    if ([self.delegate respondsToSelector:@selector(rowName:row:)]) {
        rowName = [self.delegate rowName:self row:cell.tag];
        if (!cell.titleLabel.hidden) {
            cell.titleLabel.text = rowName;
        }
    }
    
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    [cell.collectionView reloadData];
    return cell;
}
#pragma mark - MenuTableCollectCellDelegate
- (NSInteger)numberOfRowsCollectionViewCell:(MenuTableCollectCell *_Nullable)menuTableCollectCell{
    NSInteger row = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfItemInEachRow:row:)]) {
        row = [self.delegate numberOfItemInEachRow:self row:menuTableCollectCell.tag];
    }
    return row;
}

- (NSString *_Nullable)collectionViewCell:(MenuTableCollectCell *_Nullable)menuTableCollectCell titleForItemAtIndexPath:(NSInteger)row{
    
    //获取标题
    NSString *title;
    if ([self.delegate respondsToSelector:@selector(titleForMenuCollect:line:row:)]) {
        title = [self.delegate titleForMenuCollect:self line:menuTableCollectCell.tag row:row];
    }
    return title;
}
- (void)didSelectRow:(MenuTableCollectCell *)menuTableCollectCell row:(NSInteger)row{
    if ([self.delegate respondsToSelector:@selector(didSelectRow:line:row:)]) {
        [self.delegate didSelectRow:self line:menuTableCollectCell.tag row:row];
    }
}
#pragma mark - self
- (void)update:(NSInteger)line{
    NSIndexPath * indexPath = [NSIndexPath indexPathWithIndex:line];
//    MenuTableCollectCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    [cell reloadCell];
    [self.tableView reloadData];
//    [cell.collectionView reloadData];
}
@end
