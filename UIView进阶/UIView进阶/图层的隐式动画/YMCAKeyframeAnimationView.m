//
//  YMCAKeyframeAnimationView.m
//  UIView进阶
//
//  Created by yons on 16/12/2.
//  Copyright © 2016年 yons. All rights reserved.
//

#import "YMCAKeyframeAnimationView.h"

@implementation YMCAKeyframeAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
        //添加一个圆
        CGFloat screenW = frame.size.width;
        
        UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenW)];
        circleView.backgroundColor = [UIColor yellowColor];
        //设置圆角
        circleView.layer.cornerRadius = screenW * 0.5;
        
        [self addSubview:circleView];
        
        
        
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"papa"]];

        [self addSubview:self.imageView];
        
        //把图片移到顶部
        [self bringSubviewToFront:self.imageView];
        
    };
    
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //学习帧动画
    //创建一个帧动画
    CAKeyframeAnimation *animaiton = [CAKeyframeAnimation animation];
    animaiton.keyPath = @"position";
    
    //设置动画执行的路径 指定四个点
    
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(250, 50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(250, 250)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(50, 250)];
    
    //数组第一个是 “开始状态” 最后一个是 "结束状态"
    animaiton.values = @[value1,value2,value3,value4,value1];
    
    //设置时间
    animaiton.duration = 5;
    
    //设置动画节奏
    //kCAMediaTimingFunctionEaseIn 先慢后快
    //kCAMediaTimingFunctionEaseOut 先快后慢
    //kCAMediaTimingFunctionLinear 线性匀速
    //kCAMediaTimingFunctionEaseInEaseOut 中间快两边慢
    animaiton.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //#warning 内部的path的优级大小values优先级
    //设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGPathAddEllipseInRect(path, NULL, CGRectMake(0, 0, screenW, screenW));
    
    animaiton.path = path;
    //c语言的数据类型 如果create/copy/retain创建要释放
    CFRelease(path);
    
    //添加动画
    [self.imageView.layer addAnimation:animaiton forKey:nil];
    
}



@end
