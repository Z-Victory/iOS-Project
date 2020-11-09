//
//  YHFilterButton.m
//  DookayProject
//
//  Created by 刘亚和 on 2019/5/30.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import "YHFilterButton.h"
#import <Masonry.h>

@interface YHFilterButton ()
@end

@implementation YHFilterButton

- (id)initWithFrame:(CGRect)frame filterModel:(YHFilterModel *)filterModel{
    if (self = [super initWithFrame:frame]) {
        _model = filterModel;
        [self setupUI];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        _filterTitle = title;
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    _filterlabel = [[UILabel alloc]init];
    _filterlabel.text = self.filterTitle;
    _filterlabel.textAlignment = NSTextAlignmentCenter;
    _filterlabel.textColor = UIColor.blackColor;
    _filterlabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_filterlabel];
    _filterImage = [[UIImageView alloc]init];
    _filterImage.image = [UIImage imageNamed:@"close_below"];
    [self addSubview:_filterImage];
    [_filterImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(9, 5));
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self).with.offset(-5);
    }];
    [_filterlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self).with.offset(0);
        make.right.mas_equalTo(_filterImage.mas_left).with.offset(2);
    }];
}
@end
