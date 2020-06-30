//
//  YHLock.h
//  iOSProject
//
//  Created by 刘亚和 on 2020/5/30.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface YHLock : NSObject
- (void)synchronizedTest;
- (void)nslockTest;
- (void)testNSRecursiveLock;
- (void)testNSConditionLock;
- (void)testNSCondition;
- (void)test_dispatch_semaphore;
- (void)testPthread;
- (void)testRecursivePthread;
- (void)testOSSpinLock;
- (void)testOs_unfair_lock;
@end

NS_ASSUME_NONNULL_END
