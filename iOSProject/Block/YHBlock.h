//
//  YHBlock.h
//  iOSProject
//
//  Created by 刘亚和 on 2020/5/31.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHBlock : NSObject
- (void)testGlobalBlock_MRC;
- (void)testStackBlock_MRC;
- (void)testMallocBlock_MRC;

- (void)testGlobalBlock_ARC;
- (void)testStackBlock_ARC;
- (void)testMallocBlock_ARC;
- (void)testRetainCount_MRC;
@end

NS_ASSUME_NONNULL_END
