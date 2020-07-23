//
//  NSString+Tool.h
//  iOSProject
//
//  Created by mana on 2020/7/23.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Tool)
/**
根据高度度求宽度
@param text 计算的内容
@param height 计算的高度
@param font 字体大小
@return 返回宽度
*/
+(CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font;
@end

NS_ASSUME_NONNULL_END
