//
//  LYHCollectionViewCell.m
//  iOSProject
//
//  Created by mana on 2020/7/23.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "LYHCollectionViewCell.h"

@implementation LYHCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    int red = arc4random()%255;
//    int green = arc4random()%255;
//    int blue = arc4random()%255;
//    self.backgroundColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}
- (void)setModel:(TagModel *)model{
    _model = model;
    _label.text = model.title;
    if (model.isSelect) {
        _label.textColor = UIColor.whiteColor;
        _label.backgroundColor = [UIColor colorWithRed:54/255.0 green:100/255.0 blue:237/255.0 alpha:1.0];
    }else{
        _label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _label.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    }
}

@end
