//
//  UIImage+YMClipImage.m
//  UIView进阶
//
//  Created by yons on 16/12/2.
//  Copyright © 2016年 yons. All rights reserved.
//

#import "UIImage+YMClipImage.h"

@implementation UIImage (YMClipImage)

+(UIImage *)waterImageWithBgImageName:(NSString *)bgImageName waterImageName:(NSString *)waterImageName scale:(CGFloat)scale{
    // 生成一张有水印的图片，一定要获取UIImage对象 然后显示在imageView上
    
    //创建一背景图片
    UIImage *bgImage = [UIImage imageNamed:bgImageName];
    //NSLog(@"bgImage Size: %@",NSStringFromCGSize(bgImage.size));
    // 1.创建一个位图【图片】，开启位图上下文
    // size:位图大小
    // opaque: alpha通道 YES:不透明/ NO透明 使用NO,生成的更清析
    // scale 比例 设置0.0为屏幕的比例
    // scale 是用于获取生成图片大小 比如位图大小：20X20 / 生成一张图片：（20 *scale X 20 *scale)
    //NSLog(@"当前屏幕的比例 %f",[UIScreen mainScreen].scale);
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, scale);
    
    // 2.画背景图
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    // 3.画水印
    // 算水印的位置和大小
    // 一般会通过一个比例来缩小水印图片
    UIImage *waterImage = [UIImage imageNamed:waterImageName];
//#warning 水印的比例，根据需求而定
    CGFloat waterScale = 0.4;
    CGFloat waterW = waterImage.size.width * waterScale;
    CGFloat waterH = waterImage.size.height * waterScale;
    CGFloat waterX = bgImage.size.width - waterW;
    CGFloat waterY = bgImage.size.height - waterH;
    
    
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    
    // 4.从位图上下文获取 当前编辑的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    // 5.结束当前位置编辑
    UIGraphicsEndImageContext();
    
    
    return newImage;
}


+(UIImage *)circleImageWithImageName:(NSString *)imageName borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    
    //需求：从位图上下文，裁剪图片[裁剪成圆形，也添加圆形的边框]，生成一张图片
    
    // 获取要裁剪的图片
    UIImage *img = [UIImage imageNamed:imageName];
    CGRect imgRect = CGRectMake(0, 0, img.size.width, img.size.height);
    
    // 1.开启位图上下文
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0);
    
//#warning 在自定义的view的drawRect方法里，调用UIGraphicsGetCurrentContext获取的上下文，是图层上下文(Layer Graphics Context)
    // 1.1 获取位图上下文
    CGContextRef bitmapContext = UIGraphicsGetCurrentContext();
    
    // 2.往位图上下裁剪图片
    
    // 2.1 指定一个圆形的路径，把圆形之外的剪切掉
    CGContextAddEllipseInRect(bitmapContext, imgRect);
    CGContextClip(bitmapContext);
    
    
    // 2.2 添加图片
    [img drawInRect:imgRect];
    
    // 2.3 添加边框
    // 设置边框的宽度
    CGContextSetLineWidth(bitmapContext, borderWidth);
    // 设置边框的颜色
    [borderColor set];
    CGContextAddEllipseInRect(bitmapContext, imgRect);
    CGContextStrokePath(bitmapContext);
    
    
    // 3.获取当前位图上下文的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束位图编辑
    UIGraphicsEndImageContext();
    
    return newImage;
    
    
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (void)cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *image))completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 耗时操作
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        // 设置背景填充颜色
        [fillColor setFill];
        UIRectFill(rect);
        
        // Bezier绘制图形
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        [path addClip];
        [self drawInRect:rect];
        
        // 获得结果
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        
        // 关闭
        UIGraphicsEndImageContext();
        
        // 到主线程中刷新UI, 完成回调
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion != nil) {
                completion(result);
            }
        });
    });
}

@end
