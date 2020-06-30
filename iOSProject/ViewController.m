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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[[YHBlock alloc] init] testRetainCount_MRC];
    NSString *a = @"hah";
    [a eat];
}

- (IBAction)goControllerLife:(id)sender {
    //直接初始化
//    LifeViewController * vc = [[LifeViewController alloc] init];
    
    //通过Storyboard初始化
//    UIStoryboard * b = [UIStoryboard storyboardWithName:@"LifeViewController" bundle:nil];
//    LifeViewController * vc = [b instantiateViewControllerWithIdentifier:@"LifeViewController"];
    
    //通过xib初始化
//    LifeViewController * vc = [[LifeViewController alloc] initWithNibName:@"TestX" bundle:[NSBundle mainBundle]];
//    [self presentViewController:vc animated:YES completion:nil];
}

@end
