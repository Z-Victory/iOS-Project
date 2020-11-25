//
//  ADLaunchView.h
//  iOSProject
//
//  Created by mana on 2020/11/6.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADLaunchView : UIView<CAAnimationDelegate>

@property (nonatomic, strong) UIImage *adImage;

+ (void)showAdView:(UIImage *)adImage;

@end


NS_ASSUME_NONNULL_END
