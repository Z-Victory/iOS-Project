//
//  YHBlock.m
//  iOSProject
//
//  Created by 刘亚和 on 2020/5/31.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "YHBlock.h"

@implementation YHBlock
#pragma mark - MRC
//__NSGlobalBlock__
//没有访问外部auto变量，如果访问了外部static或者全局变量也是这种类型
- (void)testGlobalBlock_MRC{
    void (^testBlock)(void);
    testBlock = ^{
        NSLog(@"哈哈");
    };
    NSLog(@"%@",[testBlock class]);
}
//__NSStackBlock__
//访问了外部auto变量
- (void)testStackBlock_MRC{
    int a = 11;
    void (^testBlock)(void);
    testBlock = ^{
        NSLog(@"哈哈%i",a);
    };
    NSLog(@"%@",[testBlock class]);
}
//__NSMallocBlock__
//访问了外部auto变量
- (void)testMallocBlock_MRC{
    int a = 11;
    void (^testBlock)(void);
    testBlock = [^{
        NSLog(@"哈哈%i",a);
    } copy];
    NSLog(@"%@",[testBlock class]);
}
#pragma mark - ARC
//__NSGlobalBlock__
//没有引用外部变量，或者引用静态变量和全局变量
//和MRC情况一样
- (void)testGlobalBlock_ARC{
    void (^testBlock)(void);
    testBlock = ^{
        NSLog(@"哈哈");
    };
    NSLog(@"%@",[testBlock class]);
}
//__NSMallocBlock__
//访问了外部变量，但没有强引用指向这个block，而是直接打印出来
- (void)testStackBlock_ARC{
    int a = 11;
    NSLog(@"%@",[^{
        NSLog(@"哈哈%i",a);
    } class]);
}
//__NSMallocBlock__
//ARC环境下只要访问了外部auto变量而且有强引用指向该block(或者作为函数返回值)就会自动将__NSStackBlock类型copy到堆上
- (void)testMallocBlock_ARC{
    int a = 11;
    void (^testBlock)(void);
    testBlock = ^{
        NSLog(@"哈哈%i",a);
    };
    NSLog(@"%@",[testBlock class]);
}
- (void)testRetainCount_MRC{
    int a = 11;
    NSString * b = @"11";
    NSLog(@"%li",[b retainCount]);
    void (^testBlock)(void);
    testBlock = ^{
        NSLog(@"%li",[b retainCount]);
    };
//    NSLog(@"%@",[testBlock class]);
    testBlock();
}

@end
