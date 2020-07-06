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

@interface ViewController ()
{
    UIButton * button;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    button.backgroundColor = UIColor.redColor;
    [button addTarget:self action:@selector(goControllerLife:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
//    Girl * girl = [[Girl alloc] init];
//    [[Person alloc] init];
    NSArray * a = @[@"1",@"2"];
    __block int max;
    [a enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        int b = [obj intValue];
        if (b> max) {
            max = b;
        }
    }];
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

@end
