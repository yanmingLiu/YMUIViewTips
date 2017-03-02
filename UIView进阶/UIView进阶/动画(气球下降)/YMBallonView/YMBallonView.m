//
//  YMBallonView.m
//  UIView进阶
//
//  Created by yons on 16/12/2.
//  Copyright © 2016年 yons. All rights reserved.
//

#import "YMBallonView.h"

@interface YMBallonView ()

/**
 *  记录当前气球绘制的位置
 */
@property (nonatomic,assign) CGPoint position;

@property (nonatomic,strong)CADisplayLink  *link;//定时器



@end

@implementation YMBallonView

//drawRect会在View显示到屏幕的时候调用一次

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 实现气球下降
    
    // 每次刷新更改位置的y值（每次增加10）
#warning 结构体不能直接赋值
    CGPoint newPosition = self.position;
    newPosition.y += 10;
    
    //判断y到达底部，从新开始下降
    if (newPosition.y > rect.size.height) {
        newPosition.y = 0;
    }
    
    //重新赋值position
    self.position = newPosition;
    
    // 绘制图片
    UIImage *image = [UIImage imageNamed:@"sandyBalloon"];
    
    [image drawAtPoint:self.position];
    NSLog(@"=====");
}


#warning 调用  init 方法 和initWithFrame方法，最终都会调用initWithFrame
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSLog(@"%s",__func__);
        [self addAnimaion];
    }
    
    return self;
}

//-(instancetype)init{
//    if (self = [super init]) {
//        NSLog(@"%s",__func__);
//        [self addAnimaion];
//   }
//
//    return self;
//}

#warning 因为现在这个view的创建方法，不是在storyboard或者xib上，所以不会调用

-(void)awakeFromNib{
    [self addAnimaion];
    
    
}


-(void)addAnimaion{
    //initWithFrame 和 init 调用两次，代表在主运行循环里添加两个定时器
    
    // 写一个定时器，重绘当前的View
    // 调用了setNeedsDisplay方法，内部会调用 drawRect方法进行重绘
    //[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
    //[self setNeedsDisplay];
    
    // CADisplayLink 定时器 一秒执行60次
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
    
    // 要执行定时器，添加到主运行循环
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    self.link = link;
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //继承了一个UIResponder对象，就有这个方法
    NSLog(@"%s",__func__);
    //停止 定时器
    //self.link.paused = YES;
    
    [self.link invalidate];
    self.link = nil;
    // 移除主运行循环，不需要手写，因为invalidate方法，内部会把主定时，从主运行循环移除
    
    //[self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}


@end
