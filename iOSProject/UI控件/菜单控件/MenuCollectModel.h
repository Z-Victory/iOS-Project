//
//  MenuCollectModel.h
//  iOSProject
//
//  Created by mana on 2020/8/14.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuCollectModel : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) NSArray * filterTags;
//@property (nonatomic, assign) MenuCollectUIStyle style;
@end

NS_ASSUME_NONNULL_END
