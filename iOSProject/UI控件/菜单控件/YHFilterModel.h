//
//  YHFilterModel.h
//  DookayProject
//
//  Created by 刘亚和 on 2019/5/30.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, YHFilterMode) {
    Mode1,
    Mode2,
    Mode3,
};
//@interface YFFilterSubModel : NSObject
//@property (nonatomic, copy) NSString * title;
//@property (nonatomic, assign) NSString * title;
//@end
@interface YHFilterModel : NSObject
@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) NSArray * filterTags;
@property (nonatomic, copy) NSString * selectTitle;
@property (nonatomic, assign) YHFilterMode mode;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) BOOL isSelect;
- (YHFilterModel *)initWithTitle:(NSString *)filterTitle tags:(NSArray *)tags mode:(YHFilterMode)filterMode;
@end

NS_ASSUME_NONNULL_END
