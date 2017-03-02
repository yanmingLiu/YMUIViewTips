//
//  ViewController.m
//  UIView进阶
//
//  Created by yons on 16/12/2.
//  Copyright © 2016年 yons. All rights reserved.
//

#import "ViewController.h"

#import "YMPieView.h"
#import "YMBallonView.h"
#import "YMMoreBallonView.h"
#import "UIImage+YMClipImage.h"
#import "YMTouchView.h"
#import "YMTransformView.h"
#import "YMCAKeyframeAnimationView.h"

@interface ViewController ()

@property (strong, nonatomic)  UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self YMPieView];
//    [self YMBallonView];
//    [self YMMoreBallonView];
//    [self YMClipImageView];
//    [self waterImage];
//    [self touchView];
//    [self YMTransformView];
    
    [self YMCAKeyframeAnimationView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


/**
 // 核心动画  动画封装到YMCAKeyframeAnimationView touchesBegan 点一下出现效果
 */
- (void)YMCAKeyframeAnimationView {
    YMCAKeyframeAnimationView *view = [[YMCAKeyframeAnimationView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];
}

/**
 // 图层的隐式动画
 */
- (void)YMTransformView {
    
    YMTransformView *view = [[YMTransformView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    int64_t delayInSeconds = 1;      // 延迟的时间

    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // do something
        [view TransformScaleAnnimation];
    });
    
}


/**
 可以移动的view
 */
- (void)touchView {
    
    YMTouchView *touchView = [[YMTouchView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    touchView.backgroundColor = [UIColor redColor];
    [self.view addSubview:touchView];
    
}

/**
 //水印图片
 */
- (void)waterImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    self.imageView = imageView;
    [self.view addSubview:imageView];
    
    self.imageView.image =[UIImage waterImageWithBgImageName:@"papa" waterImageName:@"sandyBalloon" scale:1];
}

/**
 //裁剪的图片
 */
- (void)YMClipImageView {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    self.imageView = imageView;
    [self.view addSubview:imageView];
    
    self.imageView.image =[UIImage circleImageWithImageName:@"papa" borderColor:[UIColor yellowColor] borderWidth:3];
}

/**
 // 添加 自定义气球的view到控制器view
 */
- (void)YMMoreBallonView {
    
    YMMoreBallonView *ballonView = [[YMMoreBallonView alloc] init];
    ballonView.frame = self.view.bounds;
    ballonView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:ballonView];
    
}

/**
 // 添加 自定义气球的view到控制器view
 */
- (void)YMBallonView {
    
    YMBallonView *ballonView = [[YMBallonView alloc] init];
    ballonView.frame = self.view.bounds;
    ballonView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:ballonView];
}


/**
 //实现饼状图 - quartz2d 画不同比例的扇形
 */
- (void)YMPieView {
    
    //1.自定义view
    YMPieView *pieView =[[YMPieView alloc] init];
    pieView.frame = CGRectMake(10, 40, 200, 200);
    pieView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:pieView];
    
    
    //2.在自定义的view给个数据属性[NSArray]，往sections添加数据
    pieView.sections = @[@20,@30,@40,@10];
    
    // 设置颜色
    pieView.sectionColors = @[[UIColor redColor],[UIColor greenColor],[UIColor purpleColor],[UIColor yellowColor]];
}



@end
