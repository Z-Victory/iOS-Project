//
//  LifeViewController.m
//  iOSProject
//
//  Created by mana on 2020/6/30.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "LifeViewController.h"

@interface LifeViewController ()

@end

@implementation LifeViewController
/*
 1. initWithCoder：         通过 nib 文件初始化时触发。
 2. awakeFromNib：          nib 文件被加载的时候，会发生一个 awakeFromNib 的消息到 nib 文件中的每个对象。
 3. loadView：              开始加载视图控制器自带的 view。
 4. viewDidLoad：           视图控制器的 view 被加载完成。
 5. viewWillAppear：        视图控制器的 view 将要显示在 window 上。
 6. updateViewConstraints： 视图控制器的 view 开始更新 AutoLayout 约束。
 7. viewWillLayoutSubviews：视图控制器的 view 将要更新内容视图的位置。
 8. viewDidLayoutSubviews： 视图控制器的 view 已经更新视图的位置。
 9. viewDidAppear：         视图控制器的 view 已经展示到 window 上。
 10. viewWillDisappear：    视图控制器的 view 将要从 window 上消失。
 11. viewDidDisappear：     视图控制器的 view 已经从 window 上消失。
 */
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    NSLog(@"通过 nib 文件初始化时触");
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"nib 文件被加载的时候，会发生一个 awakeFromNib 的消息到 nib 文件中的每个对象。");
}

//1.先判断当前控制器是不是从storyBoard当中加载的,如果是从storyBoard加载的控制器.那么它就会从storyBoard当中加载的控制器的View,设置当前控制器的view.
//2.当前控制器是不是从xib当中加载的,如果是从xib当中加载的话,把xib当中指定的View,设置为当前控制器的View.
//3.如果也不是从xib加载的,若没有xib文件，[super loadView]默认会创建一个空白的UIView。
- (void)loadView{
    [super loadView];
    NSLog(@"开始加载视图控制器自带的 view");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
}
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"");
}
- (void)updateViewConstraints{
    [super updateViewConstraints];
    NSLog(@"视图控制器的 view 开始更新 AutoLayout 约束。");
}
- (void)viewWillLayoutSubviews{
    NSLog(@"视图控制器的 view 将要更新内容视图的位置");
}
- (void)viewDidLayoutSubviews{
    NSLog(@"视图控制器的 view 已经更新视图的位置");
}
- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"");
}
- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"");
}
- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"");
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
