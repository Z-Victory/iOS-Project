//
//  Girl.m
//  iOSProject
//
//  Created by mana on 2020/7/6.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "Girl.h"

@implementation Girl
- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"%@",NSStringFromClass([self class]));
        NSLog(@"%@",NSStringFromClass([super class]));
    }
    return self;
}
@end
