//
//  UIView+CornerRadius.m
//  ANYpocket
//
//  Created by wkun on 2019/10/5.
//  Copyright © 2019 bill. All rights reserved.
//

#import "UIView+CornerRadius.h"
@implementation UIView (CornerRadius)

#pragma mark - 设置View任意角为圆角

/// 设置View任意角度为圆角
/// @param view 待设置的view
/// @param viewSize view的size
/// @param corners 设置的角，左上、左下、右上、右下，可以组合
/// 如左下和右上 (UIRectCornerBottomLeft | UIRectCornerTopRight)
/// @param radius 圆角的半径
+ (CAShapeLayer*)setCornerWithView:(UIView*)view
                 viewSize:(CGSize)viewSize
                  corners:(UIRectCorner)corners
                   radius:(CGFloat)radius{
    CGRect fr = CGRectZero;
    fr.size = viewSize;
    
    UIBezierPath *round = [UIBezierPath bezierPathWithRoundedRect:fr byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *shape = [[CAShapeLayer alloc]init];
    [shape setPath:round.CGPath];
    view.layer.mask = shape;
    
    return shape;
}

/// 绘制view的圆角边框, 只是在view上画了一个圆角边框，并不会裁剪view
/// @param view 待设置的view
/// @param viewSize view的size
/// @param corners 设置的角，左上、左下、右上、右下，可以组合
/// 如左下和右上 (UIRectCornerBottomLeft | UIRectCornerTopRight)
/// @param radius 圆角的半径
/// @param borderColor 边框颜色
+ (CAShapeLayer*)setCornerWithView:(UIView*)view
                 viewSize:(CGSize)viewSize
                  corners:(UIRectCorner)corners
                   radius:(CGFloat)radius
              borderColor:(UIColor*)borderColor{
    CGRect fr = CGRectZero;
    fr.size = viewSize;
    
    UIBezierPath *round = [UIBezierPath bezierPathWithRoundedRect:fr byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *shape = [[CAShapeLayer alloc]init];
    [shape setPath:round.CGPath];
    shape.strokeColor = borderColor.CGColor;
    shape.fillColor = [UIColor clearColor].CGColor;
    [view.layer addSublayer:shape];
    
    return shape;
}
@end
