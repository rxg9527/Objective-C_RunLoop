//
//  ViewController.m
//  RunLoopExample
//
//  Created by Vincent on 16/8/13.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 获取线程对应RunLoop
    [self obtainRunLoop];
    
    // 获取子线程对应RunLoop
    [self obtainChildThreadRunLoop];
}

- (void)obtainRunLoop {
    //1.获得主线程对应的runloop
    NSRunLoop *mainRunLoop = [NSRunLoop mainRunLoop];
    
    //2.获得当前线程对应的runLoop
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
    
    /**
     *  mainRunLoop:    0x7f8d8b709840
     *  currentRunLoop: 0x7f8d8b709840
     */
    NSLog(@"\nmainRunLoop:%p\ncurrentRunLoop:%p", mainRunLoop, currentRunLoop);
    
    // Core Foundation
    /**
     *  mainRunLoop:    0x7f8d8b4050d0
     *  currentRunLoop: 0x7f8d8b4050d0
     */
    NSLog(@"\nmainRunLoop:%p\ncurrentRunLoop:%p", CFRunLoopGetMain(), CFRunLoopGetCurrent());
    
    /**
     *  mainRunLoop:    0x7f8d8b4050d0
     */
    NSLog(@"\nmainRunLoop:%p",mainRunLoop.getCFRunLoop);
}


- (void)obtainChildThreadRunLoop {
    //Runloop和线程的关系
    //一一对应,主线程的runloop已经创建,但是子线程的需要手动创建
    [[[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil] start];
}

//在runloop中有多个运行模式,但是runloop只能选择一种模式运行
//mode里面至少要有一个timer或者是source
-(void)run
{
    NSLog(@"%s", __func__);

    //如何创建子线程对应的runLoop,currentRunLoop懒加载的
    NSLog(@"%@", [NSRunLoop currentRunLoop]);
    NSLog(@"run---%@", [NSThread currentThread]);
}

@end
