//
//  MenuView.m
//  iOSProject
//
//  Created by mana on 2020/8/12.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "MenuView.h"
#import "UIView+Coordinate.h"

static float YHFilterWidth;
@interface MenuView()<MenuTableViewDelegate,MenuTableCollectDelegate>
@property (nonatomic,strong) NSMutableArray * menuArray;
@end
@implementation MenuView
- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    [self setupUI];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 44)]) {
        index = 0;
    }
    return self;
}
- (void)setupUI{
//    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.backgroundColor = [UIColor greenColor];
    _menuArray = [NSMutableArray array];
    NSInteger menuCount = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfMenu:)]) {
        menuCount = [self.delegate numberOfMenu:self];
    }
    YHFilterWidth = [UIScreen mainScreen].bounds.size.width/menuCount;
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    _topView.backgroundColor = UIColor.whiteColor;
    for (int i = 0; i<menuCount; i++) {
        NSString * menuTitle;
        if ([self.delegate respondsToSelector:@selector(titleForMenu:index:)]) {
            menuTitle = [self.delegate titleForMenu:self index:i];
        }
        
        YHFilterButton * button = [[YHFilterButton alloc]initWithFrame:CGRectMake(YHFilterWidth * i, 0, YHFilterWidth, _topView.height) title:menuTitle];
        button.tag = i;
        [_topView addSubview:button];
        [self.buttonArray addObject:button];
        [button addTarget:self action:@selector(selectIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        MenuContentView * menuContentView = [[MenuContentView alloc] initWithFrame:CGRectMake(0, _topView.bottom, self.width, [UIScreen mainScreen].bounds.size.height - self.y - self.topView.height)];
        [self addSubview:menuContentView];
        menuContentView.hidden = YES;
        [self.menuArray addObject:menuContentView];
        
        MenuUIStyle style;
        if ([self.delegate respondsToSelector:@selector(menu:uiStyleForRowIndexPath:columns:)]) {
            style = [self.delegate menu:self uiStyleForRowIndexPath:[NSIndexPath indexPathWithIndex:0] columns:i];
            if (style == MenuStyleTableView) {
                NSInteger tableViewCount = 0;
                if ([self.delegate respondsToSelector:@selector(numberOfTabelViews:index:)]) {
                    tableViewCount = [self.delegate numberOfTabelViews:self index:i];
                }
                
                [self addTableViews:menuContentView index:i columns:tableViewCount];
            }else{
                [self addCollection:menuContentView];
            }
        }
        
    }
    [self addSubview:_topView];
}
- (void)addTableViews:(MenuContentView *)contentView index:(NSInteger)index columns:(NSInteger)columns{
    for (int i = 0; i<columns; i++) {
        CGFloat width = contentView.width/columns;
        MenuTableView * tableView1 = [[MenuTableView alloc] initWithFrame:CGRectMake(width*i, 0, width, contentView.height)];
        tableView1.tag = i;
        tableView1.menuTag = index;
        tableView1.delegate = self;
        tableView1.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        [contentView addSubview:tableView1];
        if (i == 0) {
            contentView.tableView1 = tableView1;
        }else{
            contentView.tableView2 = tableView1;
        }
        
    }
}
- (void)addCollection:(MenuContentView *)contentView{
    MenuTableCollectView * collectView = [[MenuTableCollectView alloc] initWithFrame:CGRectMake(0, 0, contentView.width, 314)];
    collectView.delegate = self;
    collectView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    [contentView addSubview:collectView];
    contentView.collectionView = collectView;
}
- (void)selectIndex:(YHFilterButton *)sender{
    [self.superview bringSubviewToFront:self];
    index = (int)sender.tag;
    for (int i = 0;i<self.buttonArray.count;i++) {
        YHFilterButton * button = self.buttonArray[i];
        if ([button isEqual:sender]) {
            if (!button.selected) {
//                button.filterlabel.textColor = kBlueColor;
                button.filterImage.image = [UIImage imageNamed:@"close_top"];
                button.filterlabel.textColor = UIColor.blueColor;

                [button setSelected:YES];
                self.height = [UIScreen mainScreen].bounds.size.height;
                UIView * view = self.menuArray[index];
                view.hidden = NO;
            }else{
                button.filterlabel.textColor = UIColor.blackColor;
                button.filterImage.image = [UIImage imageNamed:@"close_below"];
                [button setSelected:NO];
                self.height = 44;
                UIView * view = self.menuArray[i];
                view.hidden = YES;
            }
        }else{
            button.filterlabel.textColor = UIColor.blackColor;
            button.filterImage.image = [UIImage imageNamed:@"close_below"];
            [button setSelected:NO];
            UIView * view = self.menuArray[i];
            view.hidden = YES;
        }
    }
}
#pragma mark - MenuTableViewDelegate
- (NSInteger)numberOfMenu:(MenuTableView *)menuTableView{
    if ([self.delegate respondsToSelector:@selector(numberOfTableViewRows:index:column:)]) {
        NSInteger rowCount = [self.delegate numberOfTableViewRows:self index:menuTableView.menuTag column:menuTableView.tag];
        return rowCount;
    }
    return 0;
}
- (NSString *)titleForMenu:(MenuTableView *)menuTableView row:(NSInteger)row{
    if ([self.delegate respondsToSelector:@selector(titleForTableView:index:column:row:)]) {
        NSString * title = [self.delegate titleForTableView:self index:menuTableView.menuTag column:menuTableView.tag row:row];
        return title;
    }
    return nil;
}
#pragma mark - MenuTableCollectDelegate
/// 行数
- (NSInteger)numberOfMenuCollect:(MenuTableCollectView *_Nullable)menuTableCollectView{
    NSInteger row = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfRowCollect:)]) {
        row = [self.delegate numberOfRowCollect:self];
    }
    return row;
}

/// style
- (MenuCollectUIStyle)uiStyleOfMenuCollect:(MenuTableCollectView *_Nullable)menuTableCollectView line:(NSInteger)line{
    MenuCollectUIStyle style = MenuCollectUIStyleFirst;
    if ([self.delegate respondsToSelector:@selector(uiStyleOfEachCollect:line:)]) {
        style = [self.delegate uiStyleOfEachCollect:self line:line];
    }
    return style;
}

///每行名称
- (NSString *)rowName:(MenuTableCollectView *)menuTableCollectView row:(NSInteger)row{
    NSString *rowTitle;
    if ([self.delegate respondsToSelector:@selector(rowNameOfEachCollect:line:)]) {
        rowTitle = [self.delegate rowNameOfEachCollect:self line:row];
    }
    return rowTitle;
}

///每行有几个
- (NSInteger)numberOfItemInEachRow:(MenuTableCollectView *_Nullable)menuTableCollectView row:(NSInteger)row{
    NSInteger rowCount = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfItemsEachRowInCollect:row:)]) {
        rowCount = [self.delegate numberOfItemsEachRowInCollect:self row:row];
    }
    return rowCount;
}

/// title
/// @param menuTableCollectView menuTableCollectView
/// @param row 第几个
- (NSString *_Nullable)titleForMenuCollect:(MenuTableCollectView *_Nullable)menuTableCollectView line:(NSInteger)line row:(NSInteger)row{
    NSString *text;
    if ([self.delegate respondsToSelector:@selector(titleForRowCollect:line:row:)]) {
        text = [self.delegate titleForRowCollect:self line:line row:row];
    }
    return text;
}
- (void)didSelectRow:(MenuTableCollectView *)menuTableCollectView line:(NSInteger)line row:(NSInteger)row{
    if ([self.delegate respondsToSelector:@selector(didSelectRow:line:row:)]) {
        [self.delegate didSelectRow:self line:line row:row];
    }
    
}
#pragma mark - Self
- (void)update:(NSInteger)line{
    MenuContentView * view = (MenuContentView *)self.menuArray[3];
    MenuTableCollectView * collect = view.collectionView;
    [collect update:line];
//    [view.tableView reloadData];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.height = 44;
    [self.buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YHFilterButton * button = (YHFilterButton *)obj;
        [button setSelected:NO];
        button.filterImage.image = [UIImage imageNamed:@"close_below"];
        UIView * contentView = self.menuArray[idx];
        contentView.hidden = YES;
    }];
}

- (NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
- (void)dealloc{
    NSLog(@"%@", [NSString stringWithFormat:@"%@ 销毁",[self class]]);
}
@end
