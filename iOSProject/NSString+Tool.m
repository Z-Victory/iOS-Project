//
//  NSString+Tool.m
//  iOSProject
//
//  Created by mana on 2020/7/23.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "NSString+Tool.h"

@implementation NSString (Tool)

/**
 根据高度度求宽度
 @param text 计算的内容
 @param height 计算的高度
 @param font 字体大小
 @return 返回宽度
 */
+(CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font
{
    //加上判断，防止传nil等不符合的值，导致程序奔溃
    if (text == nil || [text isEqualToString:@""]){
        text = @"无";
    }
    if (font <= 0){
        font = 13;
    }
    if (height < 0){
        height = 0;
    }
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
//计算文字宽度
- (CGSize)boundingW:(CGFloat)maxH font:(UIFont *)font {
    return [self boundingSize:CGSizeMake(CGFLOAT_MAX, maxH) font:font];
}
- (CGSize)boundingSize:(CGSize)size font:(UIFont *)font {
    return [self boundingRectWithSize:size
                              options:NSStringDrawingTruncatesLastVisibleLine |
                                           NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingUsesFontLeading
                           attributes:@{NSFontAttributeName:font}
                              context:nil].size;
}
@end
