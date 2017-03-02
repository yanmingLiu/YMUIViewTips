//
//  YMTransformView.m
//  UIView进阶
//
//  Created by yons on 16/12/2.
//  Copyright © 2016年 yons. All rights reserved.
//

#import "YMTransformView.h"


@implementation YMTransformView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.frame = self.bounds;
        self.imageView.image = [UIImage imageNamed:@"papa"];
        [self addSubview:self.imageView];
        
    };
    

    return self;
}


#pragma mark 测试尺寸的动画

-(void)TransformScaleAnnimation{
    
    //核心动画使用步骤
    //1.创建一个动画对象
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    
//#warning 核心动画，只是一个假象，真实的大小是没有变化，
    /*
     *解决方案1：如果想控件的大小真实改变，要在动画结束之后设置控件的尺寸
     *解决方案2：使动画保存执行之后的状态，默认动画执行完后，会返回原来的状态
     */
    
    
    //设置图层的 "属性"来 决定 "动画类型"
    //bounds 图层的尺寸动画
    animation.keyPath = @"bounds";
    
    //设置bounds尺寸变化后的大小
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 150, 150)];
    
    //解决方案1： 动画的代理
    //animation.delegate = self;
    
    //解决方案2：使动画保存执行之后的状态，只要设置动画的两个属性
    animation.removedOnCompletion = NO;//动画对象不要移除
    animation.fillMode = kCAFillModeForwards;//保存当前的状态
    
    
    //2.往控件的图层添加动画
    [self.imageView.layer addAnimation:animation forKey:nil];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.imageView.bounds = CGRectMake(0, 0, 150, 150);
}

@end
