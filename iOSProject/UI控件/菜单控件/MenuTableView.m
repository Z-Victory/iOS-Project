//
//  MenuTableView.m
//  iOSProject
//
//  Created by mana on 2020/8/12.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "MenuTableView.h"

@implementation MenuTableView
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
    if ([self.delegate respondsToSelector:@selector(numberOfMenu:)]) {
        NSInteger rowCount = [self.delegate numberOfMenu:self];
        return rowCount;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topVideoCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"topVideoCell"];
    }
    cell.backgroundColor = UIColor.clearColor;
    if ([self.delegate respondsToSelector:@selector(titleForMenu:row:)]) {
        NSString * title = [self.delegate titleForMenu:self row:indexPath.row];
        cell.textLabel.text = title;
    }else{
        cell.textLabel.text = @"";
    }
    return cell;
}
@end
