//
//  YMPieView.h
//  UIView进阶
//
//  Created by yons on 16/12/2.
//  Copyright © 2016年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMPieView : UIView


/**
 * 数据里只能放int @[@20,@30,@20,@30]
 */
@property (nonatomic,strong)NSArray   *sections;


/**
 *  指定不同section的饼状颜色
 */
@property (nonatomic,strong)NSArray   *sectionColors;



@end
