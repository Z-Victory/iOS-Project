//
//  ViewController.m
//  iOSProject
//
//  Created by 刘亚和 on 2020/5/30.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "ViewController.h"
#import "YHLock.h"
#import "YHBlock.h"
#import "NSObject+YHCategory.h"
#import "NSObject+YHCategoryTwo.h"
#import "LifeViewController.h"
#import "TextViewDemo.h"
#import "RunloopDemoController.h"
#import "AnimationDemo.h"
#import "Girl.h"
#import "NSObject+Sark.h"
#import "StackViewDemo.h"
#import "DateViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * button;
}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;//数据源
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.dataArray = [NSMutableArray arrayWithObjects:@"DataBaseViewController",@"StackViewDemo",@"TagsViewController",@"DateViewController",@"StackViewDemo", nil];
    [self.view addSubview:self.tableView];
//    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
//    [button setTitle:@"跳转" forState:UIControlStateNormal];
//    button.backgroundColor = UIColor.redColor;
//    [button addTarget:self action:@selector(goControllerLife:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
////    Girl * girl = [[Girl alloc] init];
////    [[Person alloc] init];
//    NSArray * a = @[@"1",@"2"];
//    __block int max;
//    [a enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        int b = [obj intValue];
//        if (b> max) {
//            max = b;
//        }
//    }];
//
//    int tempA = 10;
//    switch (tempA) {
//        case 10:case 9:
//            NSLog(@"ss");
//            break;
//
//        default:
//            break;
//    }
}

- (IBAction)goControllerLife:(id)sender {
    //直接初始化
//    TextViewDemo * vc = [[TextViewDemo alloc] init];
    
//    RunloopDemoController * vc = [RunloopDemoController new];
    
    AnimationDemo * vc = [AnimationDemo new];
    [self.navigationController pushViewController:vc animated:YES];
}
//测试Controller不同的初始化方式下生命周期的变化
//- (IBAction)goControllerLife:(id)sender {
    //直接初始化
//    LifeViewController * vc = [[LifeViewController alloc] init];
    
    //通过Storyboard初始化
//    UIStoryboard * b = [UIStoryboard storyboardWithName:@"LifeViewController" bundle:nil];
//    LifeViewController * vc = [b instantiateViewControllerWithIdentifier:@"LifeViewController"];
    
    //通过xib初始化
//    LifeViewController * vc = [[LifeViewController alloc] initWithNibName:@"TestX" bundle:[NSBundle mainBundle]];
//    [self presentViewController:vc animated:YES completion:nil];
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellName = self.dataArray[indexPath.row];
    Class vcClass = NSClassFromString(cellName);
    UIViewController * vc = [[vcClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
@end
