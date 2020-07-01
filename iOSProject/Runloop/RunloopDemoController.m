//
//  RunloopDemoController.m
//  iOSProject
//
//  Created by mana on 2020/7/1.
//  Copyright © 2020 刘亚和. All rights reserved.
//

#import "RunloopDemoController.h"

@interface RunloopDemoController ()

@end

@implementation RunloopDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    /*
     定义
     1.循环去处理事件，不同的mode下的不同source(source0非系统事件；source1系统事件)，observer,timer隔绝开，runloop同一时间只能跑在一个mode下，处理这个mode下的Source，Timer和Observer
     mode的作用是在循环中用来指定事件的优先级
     2.runloop一共有5种mode，公开的只有两种，NSDefaultRunloopMode,NSRunloopCommenModes,NSRunloopCommenModes是一个集合，包含NSDefaultRunloopMode和NSEventTrackingRunloopMode
     3.Source:唤醒runloop的事件，比如用户点击了屏幕，就会创建一个input source
       Timer:
       Observer:可以监听runloop的状态变化，并作出一定的反应
     4.runloop和线程一一对应，保存在一个全局的字典里，但是只有当runloop中有item时才会存在，在线程结束后销毁
     对于主线程的runloop，默认在程序启动的时候就会自动的创建，自己创建的线程默认是没有开启RunLoop的，在子线程中使用timer时，确保子线程的runloop被创建，不然定时器不会回调
     */
//    [self createRunloop];
    [self Demo1];
}
#pragma mark - 创建一个常驻线程
- (void)createRunloop{
    @autoreleasepool {
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        
        [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        
        [runloop run];
    }
}
#pragma mark - 输出下边代码的执行顺序
- (void)Demo1{
    NSLog(@"1");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2");
        //方案二
//        [[NSRunLoop currentRunLoop] run];
        [self performSelector:@selector(loglog) withObject:nil afterDelay:10.0f];
        //方案三
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"4");
    });
    NSLog(@"5");
}
- (void)loglog{
    NSLog(@"3");
}
/*
 输出结果
 1.5.2.4
 loglog方法不会执行，因为loglog延时执行会在内部创建一个NSTimer函数，添加到当前线程的runloop中，没有开启runloop
 优化如下
 方案一 还是不会执行，因为开启时当前线程的runloop没有一个item，runloop会退出
 方案二 隔10s后才会执行loglog方法，而且会阻塞当前线程，直到loglog方法执行结束
 */
#pragma mark - 怎样保证子线程数据回来更新UI的时候不打断用户的滑动操作?
/*
 当我们在子请求数据的同时滑动浏览当前页面，如果数据请求成功要切回主线程更新UI，那么就会影响当前正在滑动的体验。
 我们就可以将更新UI事件放在主线程的NSDefaultRunLoopMode上执行即可，这样就会等用户不再滑动页面，主线程RunLoop由UITrackingRunLoopMode切换到NSDefaultRunLoopMode时再去更新UI
 */
- (void)demo2{
    [self performSelectorOnMainThread:@selector(loglog) withObject:nil waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
}
@end
