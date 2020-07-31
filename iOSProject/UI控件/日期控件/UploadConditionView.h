//
//  YHDatePickerView.h
//  iOSProject
//
//  Created by mana on 2020/7/30.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ConditionBlock)(int state);
@interface UploadConditionView : UIView
@property (nonatomic,copy) ConditionBlock block;
/** show出这个弹窗 */
- (void)show;
@end

NS_ASSUME_NONNULL_END
