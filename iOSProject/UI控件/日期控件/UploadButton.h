//
//  UploadButton.h
//  iOSProject
//
//  Created by mana on 2020/7/30.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UploadButton : UIButton
@property (nonatomic,strong) UIImageView * leftImage;
@property (nonatomic,strong) UILabel * centerTitle;
@property (nonatomic,assign) BOOL selectedState;
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
