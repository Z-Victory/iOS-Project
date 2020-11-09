//
//  TagThirdHeaderView.m
//  iOSProject
//
//  Created by mana on 2020/7/24.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "TagThirdHeaderView.h"

@implementation TagThirdHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setCount:(int)count{
    _count = count;
    NSString * string = [NSString stringWithFormat:@"已选择%i个分类标签",count];
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributeString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"SF Pro Text Medium" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.000000]} range:NSMakeRange(3, 1)];
    _titleLabel.attributedText = attributeString;
}
@end
