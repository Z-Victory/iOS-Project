//
//  YHFilterButton.h
//  DookayProject
//
//  Created by 刘亚和 on 2019/5/30.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHFilterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHFilterButton : UIButton

@property (nonatomic, strong) YHFilterModel * model;
@property (nonatomic, copy) NSString * filterTitle;
@property (nonatomic, strong) UILabel * filterlabel;
@property (nonatomic, strong) UIImageView * filterImage;
- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
