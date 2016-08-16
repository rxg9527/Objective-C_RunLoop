//
//  ViewController.m
//  04_RunLoop线程保活
//
//  Created by Vincent on 16/8/14.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSThread *thread;

@end

@implementation ViewController

- (IBAction)DidClickCreateBtn:(id)sender {
    //1.创建线程
    self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(task1) object:nil];
    [self.thread start];
}

- (IBAction)DidClickContinueBtn:(id)sender {
    /**
     *  self.thread 已经是死亡状态，task2不能执行
     */
    [self performSelector:@selector(task2) onThread:self.thread withObject:nil waitUntilDone:YES];
}

-(void)task1 {
    NSLog(@"task1---%@",[NSThread currentThread]);
    
    //解决方法:开runloop
    //1.获得子线程对应的runloop
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    //2.默认是没有开启
    [runloop run];
    
    NSLog(@"---end----");
}

-(void)task2 {
    NSLog(@"task2---%@",[NSThread currentThread]);
}

@end
