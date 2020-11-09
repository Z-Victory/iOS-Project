//
//  MenuViewController.m
//  iOSProject
//
//  Created by mana on 2020/8/12.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
@property (nonatomic,strong) NSMutableArray * menuTitleArray;
@property (nonatomic,strong) NSMutableArray * titleArray1;
@property (nonatomic,strong) NSMutableArray * titleArray2;
@property (nonatomic,strong) NSMutableArray * titleArray3;
@property (nonatomic,strong) NSMutableArray * titleArray4;
@property (nonatomic,strong) NSMutableArray * titleArray5;
@property (nonatomic,strong) NSMutableArray * titleArray6;
@property (nonatomic,strong) NSMutableArray * collectName;
@property (nonatomic,strong) NSMutableArray * collectArray;
@property (nonatomic,strong) NSMutableArray * collectArray1;
@property (nonatomic,strong) NSMutableArray * collectArray2;
@property (nonatomic,strong) NSMutableArray * collectArray3;
@property (nonatomic,strong) NSMutableArray * collectArray4;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _menuTitleArray = [NSMutableArray arrayWithObjects:@"全部专业",@"全部行业",@"默认排序",@"更多筛选", nil];

    _titleArray1 = [NSMutableArray arrayWithObjects:@"全部分类",@"装置",@"影像",@"交互",@"投影",@"视听&演出",@"游戏",@"虚拟与现实",@"人工智能",@"雕塑",@"建筑",@"灯光",@"生物艺术",nil];
    _titleArray2 = [NSMutableArray arrayWithObjects:@"全部",@"交互装置",@"灯光装置",@"动态装置",@"空间装置",@"声音装置",@"机械装置",@"音画交互装置",nil];
    
    _titleArray3 = [NSMutableArray arrayWithObjects:@"全部行业",@"饮食",@"科技",@"时尚",@"医疗健康",@"运动",@"家居家电",@"地产",@"游戏",@"教育",@"建筑",@"灯光",@"环保",nil];
    _titleArray4 = [NSMutableArray arrayWithObjects:@"全部",@"音乐演出/演唱会",@"戏剧/舞台剧",@"晚会/综艺节目",nil];
    
    _titleArray5 = [NSMutableArray arrayWithObjects:@"默认排序",@"最新创作",@"按浏览量",@"按点赞数",nil];
    
    
    
    _collectName = [NSMutableArray arrayWithObjects:@"应用场景",@"热门标签",@"上传时间",nil];
    _collectArray1 = [NSMutableArray arrayWithObjects:@"全部",@"公共交通",@"酒店民宿",@"展厅展览", nil];
    _collectArray2 = [NSMutableArray arrayWithObjects:@"生成艺术",@"体感",@"创意变成",@"数以艺术", nil];
    _collectArray4 = [NSMutableArray arrayWithObjects:@"全部",@"体育馆",@"美术馆",@"博物馆", nil];
    _collectArray3 = [NSMutableArray arrayWithObjects:@"全部",@"近1天",@"近7天",@"近30天",@"近一年", nil];
    _collectArray = [NSMutableArray arrayWithObjects:_collectArray1,_collectArray2,_collectArray3, nil];
    
    
    filterView = [[MenuView alloc]initWithFrame:CGRectMake(0, 88, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88)];
    filterView.delegate = self;
    [self.view addSubview:filterView];
}
- (NSInteger)numberOfMenu:(MenuView *)menuview{
    return _menuTitleArray.count;
}
- (NSString *)titleForMenu:(MenuView *)menuview index:(NSInteger)index{
    return _menuTitleArray[index];
}
- (MenuUIStyle)menu:(MenuView *)menu uiStyleForRowIndexPath:(NSIndexPath *)dropIndexPath columns:(NSInteger)columns{
    if (columns != 3) {
        return MenuStyleTableView;
    }else{
        return MenuStyleHorizontal;
    }
}
- (NSInteger)numberOfTabelViews:(MenuView *)menuview index:(NSInteger)index{
    if (index == 0 || index == 1) {
        return 2;
    }else{
        return 1;
    }
}
- (NSInteger)numberOfTableViewRows:(MenuView *)menuview index:(NSInteger)index column:(NSInteger)column{
    if (index == 0) {
        if (column == 0) {
            return _titleArray1.count;
        }else{
            return _titleArray2.count;
        }
    }else if (index == 1){
        if (column == 0) {
            return _titleArray3.count;
        }else{
            return _titleArray4.count;
        }
    }else{
        return _titleArray5.count;
    }
    return 0;
}
- (NSString *)titleForTableView:(MenuView *)menuview index:(NSInteger)index column:(NSInteger)column row:(NSInteger)row{
    
    if (index == 0) {
        if (column == 0) {
            return _titleArray1[row];
        }else{
            return _titleArray2[row];
        }
    }else if (index == 1){
        if (column == 0) {
            return _titleArray3[row];
        }else{
            return _titleArray4[row];
        }
    }else{
        return _titleArray5[row];
    }
    return nil;
}

/// 行数
- (NSInteger)numberOfRowCollect:(MenuView *)menuview{
    return self.collectName.count;
}

/// style
- (MenuCollectUIStyle)uiStyleOfEachCollect:(MenuView *)menuview line:(NSInteger)line{
    return MenuCollectUIStyleFirst;
}
- (NSString *)rowNameOfEachCollect:(MenuView *)menuview line:(NSInteger)line{
    return self.collectName[line];
}

///每行有几个
- (NSInteger)numberOfItemsEachRowInCollect:(MenuView *)menuview row:(NSInteger)row{
    NSArray * array = self.collectArray[row];
    return array.count;
}

/// title
/// @param menuview menuview
/// @param row 第几个
/// @param line 第几行
- (NSString *_Nullable)titleForRowCollect:(MenuView *)menuview line:(NSInteger)line row:(NSInteger)row{
    NSArray * array = self.collectArray[line];
    return array[row];
}
- (void)didSelectRow:(MenuView *)menuview line:(NSInteger)line row:(NSInteger)row{
    if (line == 0) {
        if (row == 3) {
            if (![self.collectArray containsObject:_collectArray4]) {
                [self.collectArray insertObject:_collectArray4 atIndex:1];
                [self.collectName insertObject:@"" atIndex:1];
                [menuview update:line];
            }
            
        }else{
            if ([self.collectArray containsObject:_collectArray4]) {
                [self.collectArray removeObject:_collectArray4];
                [self.collectName removeObject:@""];
                [menuview update:line];
            }
            
        }
    }
}
@end
