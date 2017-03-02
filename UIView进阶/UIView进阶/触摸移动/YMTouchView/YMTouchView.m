//
//  YMTouchView.m
//  UIView进阶
//
//  Created by yons on 16/12/2.
//  Copyright © 2016年 yons. All rights reserved.
//

#import "YMTouchView.h"

@implementation YMTouchView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    return;
//    NSLog(@"%s",__func__);
    // 获取当前触摸点的UITouch对象
    UITouch *touch = [touches anyObject];
    // 触摸点 所在的view
    NSLog(@"%@",touch.view);
    
    // tapCount 点击的次数
    NSLog(@"%ld",touch.tapCount);
    
    // 获取当前 触摸的位置
    
//#warning 传一个nil 获取的触摸点的位置是在windows上去
    CGPoint touchPosition = [touch locationInView:touch.view];
    NSLog(@"%@",NSStringFromCGPoint(touchPosition));
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"%s",__func__);
    // 获取当前触摸点的UITouch对象
    UITouch *touch = [touches anyObject];
    
    //获取 当前触摸的位置
    CGPoint current = [touch locationInView:touch.view];
    
    //获取 触摸前的位置
    CGPoint previous = [touch previousLocationInView:touch.view];
    
    NSLog(@"触摸前的点: %@ 当前触摸点:%@",NSStringFromCGPoint(previous),    NSStringFromCGPoint(current));
    
    // 改变位置
    CGPoint center = self.center;
    center.x += current.x - previous.x;
    center.y += current.y - previous.y;
    
    self.center = center;
    
}
@end
