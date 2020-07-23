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
    
    int red = arc4random()%255;
    int green = arc4random()%255;
    int blue = arc4random()%255;
    self.backgroundColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

@end
