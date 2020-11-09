//
//  Person.m
//  iOSProject
//
//  Created by mana on 2020/7/6.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "Person.h"

@interface Sarkk:NSObject
@end

@implementation Sarkk
- (void)speak{
    NSLog(@"%@",NSStringFromClass([super class]));
}
@end



//@interface Person:NSObject
//
//@end

@implementation Person
- (instancetype)init{
    self = [super init];
    if (self) {
        Class class = [self class];
        void *newC = &class;
        [(__bridge id)newC speak];
        NSLog(@"%@",NSStringFromClass([super class]));
    }
    return self;
}
@end
