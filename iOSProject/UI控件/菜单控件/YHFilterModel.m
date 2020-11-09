//
//  YHFilterModel.m
//  DookayProject
//
//  Created by 刘亚和 on 2019/5/30.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import "YHFilterModel.h"

@implementation YHFilterModel
- (YHFilterModel *)initWithTitle:(NSString *)filterTitle tags:(NSArray *)tags mode:(YHFilterMode)filterMode{
    if (self = [super init]) {
        self.title = filterTitle;
        self.filterTags = tags;
        self.mode = filterMode;
    }
    return self;
}
@end
