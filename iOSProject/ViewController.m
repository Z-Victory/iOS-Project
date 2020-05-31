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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[[YHBlock alloc] init] testRetainCount_MRC];
}


@end
