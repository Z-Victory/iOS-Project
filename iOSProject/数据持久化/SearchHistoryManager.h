//
//  SearchHistoryManager.h
//  LearnDatabase
//
//  Created by mana on 2020/4/8.
//  Copyright © 2020 Loying. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchHistoryManager : NSObject
+ (instancetype)shareHistory;
- (void)insert:(NSString *)string;
- (NSArray *)getHistory;
- (void)cleanHistory;
@end

NS_ASSUME_NONNULL_END
