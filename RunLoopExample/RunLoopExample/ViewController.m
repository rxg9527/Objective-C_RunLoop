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

@end
