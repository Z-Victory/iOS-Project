//
//  YHLock.m
//  iOSProject
//
//  Created by 刘亚和 on 2020/5/30.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "YHLock.h"
#import "pthread.h"
#import <libkern/OSAtomic.h>
#import <os/lock.h>

@interface YHLock()
@property (nonatomic, assign) NSInteger tickets;//票数
@property (nonatomic, strong) NSLock *lock;
@end

@implementation YHLock

/*
 各种锁的性能比较 从上往下时间逐渐增加
 OSSpinLock
 dispatch_semaphore
 pthread_mutex
 NSLock
 NSCondition
 pthread_mutex(recursive)
 NSRecursiveLock
 NSConditionLock
 @synchronized
 */
 #pragma mark - @synchronized
- (void)synchronizedTest{
    
    _tickets = 10;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        [self saleTicket];
    });
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        [self saleTicket];
    });
}
- (void)saleTicket{
    while (1) {
        [NSThread sleepForTimeInterval:1];
        @synchronized (self) {
            if (_tickets>0) {
                _tickets--;
                NSLog(@"剩余票数:%li,当前线程:%@",(long)_tickets,[NSThread currentThread]);
            }else{
                NSLog(@"票卖完了,当前线程:%@",[NSThread currentThread]);
                break;
            }
        }
    }
}
#pragma mark - NSLock
/**
 * 该类分成了几个子类：NSLock、NSConditionLock、NSRecursiveLock、NSCondition
 * NSLock 及其子类，时间消耗来说 NSLock < NSCondition < NSRecursiveLock < NSConditionLock
 */
- (void)nslockTest{
    
    _tickets = 10;
    //注意：NSLock 互斥锁 不能多次调用 lock方法,会造成死锁
    _lock = [[NSLock alloc] init];
    ////返回bool类型
    ////tryLock
    ////试图获取一个锁，但是如果锁不可用的时候，它不会阻塞线程，相反，它只是返回NO。
    ////当前线程锁失败，也可以继续其它任务，用 trylock 合适；当前线程只有锁成功后，才会做一些有意义的工作，那就 lock，没必要轮询 trylock。以下的锁都是这样
    ////lockBeforeDate
    ////方法试图获取一个锁，但是如果锁没有在规定的时间内被获得，它会让线程从阻塞状态变为非阻塞状态（或者返回NO）
//    [_lock tryLock];
//    [_lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        [self saleTicket_NSLock];
    });
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        [self saleTicket_NSLock];
    });
}
- (void)saleTicket_NSLock{
    while (1) {
        [NSThread sleepForTimeInterval:1];
        [_lock lock];
        if (_tickets>0) {
            _tickets--;
            NSLog(@"剩余票数:%li,当前线程:%@",(long)_tickets,[NSThread currentThread]);
        }else{
            NSLog(@"票卖完了,当前线程:%@",[NSThread currentThread]);
            break;
        }
        [_lock unlock];
    }
}
////是递归锁，顾名思义，可以被一个线程多次获得，而不会引起死锁。它记录了成功获得锁的次数，每一次成功的获得锁，必须有一个配套的释放锁和其对应，这样才不会引起死锁。NSRecursiveLock 会记录上锁和解锁的次数，当二者平衡的时候，才会释放锁，其它线程才可以上锁成功。
////如果用 NSLock 的话，cjlock 先锁上了，但未执行解锁的时候，就会进入递归的下一层，而再次请求上锁，阻塞了该线程，线程被阻塞了，自然后面的解锁代码不会执行，而形成了死锁。而 NSRecursiveLock 递归锁就是为了解决这个问题。
#pragma mark - NSRecursiveLock
- (void)testNSRecursiveLock{
    NSRecursiveLock *recursiveLock = [[NSRecursiveLock alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void(^saleTickets)(int);
        saleTickets = ^(int a){
            [recursiveLock lock];
            NSLog(@"%i加锁成功",a);
            if (a > 0) {
                NSLog(@"value:%i",a);
                saleTickets(a-1);
            }
            [recursiveLock unlock];
            NSLog(@"%i解锁成功",a);
            
        };
        saleTickets(3);
    });
}

////NSConditionLock 对象所定义的互斥锁可以在使得在某个条件下进行锁定和解锁，它和 NSLock 类似，都遵循 NSLocking 协议，方法都类似，只是多了一个 condition 属性，以及每个操作都多了一个关于 condition 属性的方法，例如tryLock、tryLockWhenCondition:，所以 NSConditionLock 可以称为条件锁。

////只有 condition 参数与初始化时候的 condition 相等，lock 才能正确进行加锁操作。
///unlockWithCondition: 并不是当 condition 符合条件时才解锁，而是解锁之后，修改 condition 的值。
#pragma mark - NSConditionLock
- (void)testNSConditionLock{
    NSConditionLock * yhlock = [[NSConditionLock alloc] initWithCondition:0];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [yhlock lock];
        NSLog(@"线程1加锁成功,%@",[NSThread currentThread]);
        sleep(1);
        [yhlock unlock];
        NSLog(@"线程1解锁成功");
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3);
        [yhlock lockWhenCondition:2];
        NSLog(@"线程2加锁成功,%@",[NSThread currentThread]);
        [yhlock unlock];
        NSLog(@"线程2解锁成功");
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        if ([yhlock tryLockWhenCondition:0]) {
            NSLog(@"线程3加锁成功,%@",[NSThread currentThread]);
            sleep(2);
            [yhlock unlockWithCondition:3];
            NSLog(@"线程3解锁成功");
        }else{
            NSLog(@"线程3尝试加锁失败");
        }
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([yhlock lockWhenCondition:3 beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]]) {
            NSLog(@"线程4加锁成功,%@",[NSThread currentThread]);
            [yhlock unlockWithCondition:2];
            NSLog(@"线程4解锁成功");
        }else{
            NSLog(@"线程4尝试加锁失败");
        }
    });
}
////NSCondition 是一种特殊类型的锁，通过它可以实现不同线程的调度。一个线程被某一个条件所阻塞，直到另一个线程满足该条件从而发送信号给该线程使得该线程可以正确的执行。比如说，你可以开启一个线程下载图片，一个线程处理图片。这样的话，需要处理图片的线程由于没有图片会阻塞，当下载线程下载完成之后，则满足了需要处理图片的线程的需求，这样可以给定一个信号，让处理图片的线程恢复运行。

////NSCondition 的对象实际上作为一个锁和一个线程检查器，锁上之后其它线程也能上锁，而之后可以根据条件决定是否继续运行线程，即线程是否要进入waiting 状态，如果进入 waiting状态，当其它线程中的该锁执行 signal或者broadcast方法时，线程被唤醒，继续运行之后的方法。
////NSCondition 可以手动控制线程的挂起与唤醒，可以利用这个特性设置依赖。
- (void)testNSCondition{
    NSCondition * condition = [[NSCondition alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [condition lock];
        NSLog(@"线程1加锁成功");
        [condition wait];
        NSLog(@"线程1唤醒成功");
        [condition unlock];
        NSLog(@"线程1解锁成功");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2加锁成功");
        [condition waitUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
        NSLog(@"线程2唤醒成功");
        [condition unlock];
        NSLog(@"线程2解锁成功");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [condition lock];
        NSLog(@"线程3加锁成功");
        [condition wait];
        NSLog(@"线程3唤醒成功");
        [condition unlock];
        NSLog(@"线程3解锁成功");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        [condition signal];
    });
}
/*
 dispatch_semaphore 和 NSCondition 类似，都是一种基于信号的同步方式，但 NSCondition 信号只能发送，不能保存（如果没有线程在等待，则发送的信号会失效）。而 dispatch_semaphore 能保存发送的信号。dispatch_semaphore 的核心是 dispatch_semaphore_t 类型的信号量。
 dispatch_semaphore_create(1)方法可以创建一个 dispatch_semaphore_t 类型的信号量，设定信号量的初始值为 1。注意，这里的传入的参数必须大于或等于 0，否则 dispatch_semaphore_create 会返回 NULL。
 *dispatch_semaphore_wait(semaphore, overTime); 方法会判断 semaphore 的信号值是否大于 0。大于 0 不会阻塞线程，消耗掉一个信号，执行后续任务。如果信号值为 0，该线程会和 NSCondition 一样直接进入 waiting 状态，等待其他线程发送信号唤醒线程去执行后续任务，或者当 overTime 时限到了，也会执行后续任务。
 dispatch_semaphore_signal(semaphore);发送信号，如果没有等待的线程接受信号，则使 signal 信号值加一（做到对信号的保存）。
 一个 dispatch_semaphore_wait(semaphore, overTime); 方法会去对应一个 dispatch_semaphore_signal(semaphore); 看起来像 NSLock 的 lock 和 unlock，其实可以这样理解，区别只在于有信号量这个参数，lock unlock 只能同一时间，一个线程访问被保护的临界区，而如果 dispatch_semaphore 的信号量初始值为 x ，则可以有 x 个线程同时访问被保护的临界区。
 */
#pragma mark - dispatch_semaphore
- (void)test_dispatch_semaphore{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t queue = dispatch_queue_create("semaphoreQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*6);
    dispatch_async(queue, ^{
        NSLog(@"线程1开始");
        sleep(2);
        dispatch_semaphore_wait(semaphore, time);//DISPATCH_TIME_FOREVER
        sleep(1);
        NSLog(@"线程1加锁成功");
        dispatch_semaphore_signal(semaphore);
        NSLog(@"线程1解锁成功");
    });
    dispatch_async(queue, ^{
        NSLog(@"线程2开始");
        sleep(1);
        dispatch_semaphore_wait(semaphore, time);//DISPATCH_TIME_FOREVER
        sleep(1);
        NSLog(@"线程2加锁成功");
        dispatch_semaphore_signal(semaphore);
        NSLog(@"线程2解锁成功");
    });
}
#pragma mark - pthread
//普通用法
/** 它的用法和 NSLock 的 lock unlock 用法一致，而它也有一个 pthread_mutex_trylock 方法，pthread_mutex_trylock 和 tryLock 的区别在于，tryLock 返回的是 YES 和 NO，pthread_mutex_trylock 加锁成功返回的是 0，失败返回的是错误提示码。
pthread_mutex(recursive) 作用和 NSRecursiveLock 递归锁类似。如果使用 pthread_mutex_init(&theLock, NULL); 初始化锁的话，上面的代码的第二部分会出现死锁现象，使用递归锁就可以避免这种现象。
 */
- (void)testPthread{
    __block pthread_mutex_t yhlock;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1开始");
        sleep(1);
        pthread_mutex_lock(&yhlock);
        NSLog(@"线程1加锁成功");
        pthread_mutex_unlock(&yhlock);
        NSLog(@"线程1解锁成功");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2开始");
        sleep(2);
        pthread_mutex_lock(&yhlock);
        NSLog(@"线程2加锁成功");
        pthread_mutex_unlock(&yhlock);
        NSLog(@"线程2解锁成功");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程3开始");
        sleep(2);
        pthread_mutex_trylock(&yhlock);
        NSLog(@"线程3加锁成功");
        pthread_mutex_unlock(&yhlock);
        NSLog(@"线程3解锁成功");
    });
}
//递归用法
- (void)testRecursivePthread{
    __block pthread_mutex_t yhlock;
    
    pthread_mutexattr_t attr;
    
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    pthread_mutex_init(&yhlock, &attr);
    pthread_mutexattr_destroy(&attr);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程开始");
        
        while (1) {
            static void (^Recursive)(int);//static
            Recursive = ^(int value){
                pthread_mutex_lock(&yhlock);
                NSLog(@"线程%i加锁成功，%@",value,[NSThread currentThread]);
                if (value > 0) {
                    sleep(1);
                    Recursive(value - 1);
                }
                pthread_mutex_unlock(&yhlock);
                NSLog(@"线程%i解锁成功，%@",value,[NSThread currentThread]);
            };
            Recursive(3);
            break;
        }
    });
}
/*
 OSSpinLock 是一种自旋锁，和互斥锁类似，都是为了保证线程安全的锁。但二者的区别是不一样的，对于互斥锁，当一个线程获得这个锁之后，其他想要获得此锁的线程将会被阻塞，直到该锁被释放。但自选锁不一样，当一个线程获得锁之后，其他线程将会一直循环在哪里查看是否该锁被释放。所以，此锁比较适用于锁的持有者保存时间较短的情况下。
 自旋锁加锁的时候，等待锁的线程处于忙等状态，并且占用着CPU的资源。
 互斥锁加锁的时候，等待锁的线程处于休眠状态，不会占用CPU的资源。
 
 //使用的时候Xcode会提示已过期，使用os_unfair_lock()替代
 'OSSpinLock' is deprecated: first deprecated in iOS 10.0 - Use os_unfair_lock() from <os/lock.h> instead
 */
#pragma mark - OSSpinLock
- (void)testOSSpinLock{
    __block OSSpinLock spinLock = OS_SPINLOCK_INIT;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OSSpinLockLock(&spinLock);
        NSLog(@"线程1加锁成功");
        sleep(1);
        OSSpinLockUnlock(&spinLock);
        NSLog(@"线程1解锁成功");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OSSpinLockLock(&spinLock);
//        OSSpinLockTry(&spinLock);
        NSLog(@"线程2加锁成功");
        sleep(1);
        OSSpinLockUnlock(&spinLock);
        NSLog(@"线程2解锁成功");
    });
}
#pragma mark - os_unfair_lock
- (void)testOs_unfair_lock{
    __block os_unfair_lock osUnfairLock = OS_UNFAIR_LOCK_INIT;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        // 加锁
        os_unfair_lock_lock(&osUnfairLock);
        NSLog(@"线程1加锁成功");
        sleep(1);
        // 尝试加锁
//        BOOL b = os_unfair_lock_trylock(osUnfairLock);
        // 解锁
        os_unfair_lock_unlock(&osUnfairLock);
        NSLog(@"线程1解锁成功");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 尝试加锁
        BOOL lockSuccess = os_unfair_lock_trylock(&osUnfairLock);
        if (lockSuccess) {
            NSLog(@"线程2加锁成功");
            sleep(1);
            // 解锁
            os_unfair_lock_unlock(&osUnfairLock);
            NSLog(@"线程2解锁成功");
        }
    });
}
@end
