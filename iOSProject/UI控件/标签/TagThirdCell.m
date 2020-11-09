//
//  LYHCollectionViewCell.m
//  iOSProject
//
//  Created by mana on 2020/7/23.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "TagThirdCell.h"
#import "UIButton+EnlargeEdge.h"
#import <Masonry.h>
@implementation TagThirdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _label.layer.cornerRadius = 4.0f;
    _label.layer.masksToBounds = YES;
    _deleteButton = [[UIButton alloc] init];
//    _deleteButton.backgroundColor = UIColor.redColor;
    [_deleteButton setImage:[UIImage imageNamed:@"icon_tag_del_btn"] forState:UIControlStateNormal];
    [_deleteButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//    [_deleteButton setTitle:@"X" forState:UIControlStateNormal];
    [_deleteButton setEnLargeEdge:10];
    [self addSubview:self.deleteButton];
    [_deleteButton addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setModel:(TagModel *)model{
    _model = model;
    _label.text = model.title;
//    if (model.isSelect) {
//        _label.layer.cornerRadius = 4.0f;
//        _label.layer.masksToBounds = YES;
//        _label.textColor = [UIColor colorWithRed:54/255.0 green:100/255.0 blue:237/255.0 alpha:1.0];
//        _label.layer.borderColor = [UIColor colorWithRed:54/255.0 green:100/255.0 blue:237/255.0 alpha:1.0].CGColor;
//        _label.layer.borderWidth = 1.0f;
//    }else{
//        _label.layer.cornerRadius = 4.0f;
//        _label.layer.masksToBounds = YES;
//        _label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//        _label.layer.borderColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0].CGColor;
//        _label.layer.borderWidth = 1.0f;
//    }
}
- (void)layoutSubviews{
//    [super layoutSubviews];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.right.mas_equalTo(self.label.mas_right).with.offset(8);
        make.top.mas_equalTo(self.label.mas_top).with.offset(-8);
    }];
}
- (void)delete{
    NSLog(@"来了");
    !_deleteBlock?:_deleteBlock();
}
@end
