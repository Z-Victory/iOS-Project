//
//  NewTagCell.m
//  iOSProject
//
//  Created by mana on 2020/7/23.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "NewTagCell.h"
//#import "UIButton+EnlargeEdge.h"
//#import <Masonry.h>
@implementation NewTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _bgView.layer.cornerRadius = 4.0f;
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.borderColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0].CGColor;
    _bgView.layer.borderWidth = 1.0f;
}
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(16, 16));
//        make.right.mas_equalTo(self.label.mas_right).with.offset(8);
//        make.top.mas_equalTo(self.label.mas_top).with.offset(-8);
//    }];
//}
@end
