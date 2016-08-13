//
//  ViewController.m
//  01_RunLoop相关类
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
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self timer1];
}

- (void)timer1
{
    //1.创建定时器
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(run) userInfo:nil repeats:YES];

    //2.添加定时器到runLoop中,指定runloop的运行模式为NSDefaultRunLoopMode
    // 这种情况下，滑动textView时，RunLoop运行模式变为UITrackingRunLoopMode，定时器不再运行
    /*
     第一个参数:定时器
     第二个参数:runloop的运行模式
     */
    
    /**
     *  解决方法1
     */
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode]; // 同时添加到UITrackingRunLoopMode下时可以解决问题
    
    /**
     *  解决方法2
      NSRunLoopCommonModes = NSDefaultRunLoopMode + UITrackingRunLoopMode
     占用,标签,凡是添加到NSRunLoopCommonModes中的事件爱你都会被同时添加到打上commmon标签的运行模式上
     */
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)run {
    NSLog(@"run---%@---%@", [NSThread currentThread], [NSRunLoop currentRunLoop].currentMode);
}

@end
