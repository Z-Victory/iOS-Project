//
//  NSObject+YHCategory.h
//  iOSProject
//
//  Created by mana on 2020/6/29.
//  Copyright © 2020 刘亚和. All rights reserved.
//
/*
 分类
 
 ///////////////////////////////////////////////////////////////////////////////
 分类只能添加方法，可以利用runtime添加属性
 扩展已有的类
 分类、管理某个类的方法
 
 ///////////////////////////////////////////////////////////////////////////////
 分类优先级执行
 ① 本类和分类的话，分类优先于本类的方法
 ② 如果有两个分类中都实现了相同的方法，执行顺序是 targets->Build Phases->Complie Source，顺序是从上到下。
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YHCategory)
- (void)eat;
@end

NS_ASSUME_NONNULL_END
