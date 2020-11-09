//
//  LYHCollectionViewCell.m
//  iOSProject
//
//  Created by mana on 2020/7/23.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "TagSecondCell.h"

@implementation TagSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setModel:(TagModel *)model{
    _model = model;
    _label.text = model.title;
    if (model.isSelect) {
        _label.layer.cornerRadius = 4.0f;
        _label.layer.masksToBounds = YES;
        _label.textColor = [UIColor colorWithRed:54/255.0 green:100/255.0 blue:237/255.0 alpha:1.0];
        _label.layer.borderColor = [UIColor colorWithRed:54/255.0 green:100/255.0 blue:237/255.0 alpha:1.0].CGColor;
        _label.layer.borderWidth = 1.0f;
    }else{
        _label.layer.cornerRadius = 4.0f;
        _label.layer.masksToBounds = YES;
        _label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _label.layer.borderColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0].CGColor;
        _label.layer.borderWidth = 1.0f;
    }
}

@end
