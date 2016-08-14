//
//  ViewController.m
//  03_source和Observer
//
//  Created by Vincent on 16/8/14.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)didClickBtn:(id)sender {
    /**
     *  断点可以看到『__CFRunLoopDoSources0』
     */
    NSLog(@"%s", __func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self createObserver];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(task) userInfo:nil repeats:YES];
}

-(void)task
{
    NSLog(@"%s",__func__);
}

- (void)createObserver
{
    //1.创建监听者
    /*
     第一个参数:怎么分配存储空间
     第二个参数:要监听的状态 kCFRunLoopAllActivities 所有的状态
     第三个参数:时候持续监听
     第四个参数:优先级 总是传0
     第五个参数:当状态改变时候的回调
     */
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        /*
         kCFRunLoopEntry = (1UL << 0),        即将进入runloop
         kCFRunLoopBeforeTimers = (1UL << 1), 即将处理timer事件
         kCFRunLoopBeforeSources = (1UL << 2),即将处理source事件
         kCFRunLoopBeforeWaiting = (1UL << 5),即将进入睡眠
         kCFRunLoopAfterWaiting = (1UL << 6), 被唤醒
         kCFRunLoopExit = (1UL << 7),         runloop退出
         kCFRunLoopAllActivities = 0x0FFFFFFFU
         */
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"即将进入runloop");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"即将处理timer事件");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"即将处理source事件");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"即将进入睡眠");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"被唤醒");
                break;
            case kCFRunLoopExit:
                NSLog(@"runloop退出");
                break;
                
            default:
                break;
        }
    });
    
    /*
     第一个参数:要监听哪个runloop
     第二个参数:观察者
     第三个参数:运行模式
     */
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    //NSDefaultRunLoopMode 对应 kCFRunLoopDefaultMode
    //NSRunLoopCommonModes 对应 kCFRunLoopCommonModes
}

@end
