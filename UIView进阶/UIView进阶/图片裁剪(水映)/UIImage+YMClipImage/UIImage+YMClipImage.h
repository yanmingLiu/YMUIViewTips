//
//  UIImage+YMClipImage.h
//  UIView进阶
//
//  Created by yons on 16/12/2.
//  Copyright © 2016年 yons. All rights reserved.
//



// 关于图片裁剪、UIImageView裁剪 + SDWebImage的使用可以看我的分类 里面有
// https://github.com/yanmingLiu/YMCategory



#import <UIKit/UIKit.h>

@interface UIImage (YMClipImage)


/**
 *
 *  @param bgImageName    背景图片
 *  @param waterImageName 水印图片
 *  @param scale 图片生成的比例
 *  @return 添加了水印的背景图片
 */
+(UIImage *)waterImageWithBgImageName:(NSString *)bgImageName waterImageName:(NSString *)waterImageName scale:(CGFloat)scale;


/**
 *
 *  @param imageName    需要裁剪的图片
 *  @param borderColor 边框的颜色
 *  @param borderWidth 边框的宽度
 *  @return 一个裁剪 带有边框的圆形图片
 */
+(UIImage *)circleImageWithImageName:(NSString *)imageName borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

//@property (nonatomic, copy) void (^locationBlock)(NSString *mapX, NSString *mapY, NSString *adrees);
- (void)cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completed:(void (^)(UIImage *image))completed;

@end
