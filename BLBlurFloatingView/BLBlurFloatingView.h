//
//  BLBlurFloatingView.h
//  BlurFloatingButtonDemo
//
//  Created by Met on 2020/11/8.
//  Copyright © 2020 bill. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 带有高斯模糊的，吸附浮动视图
@interface BLBlurFloatingView : UIView

/// 初始化时，指定圆角类型
/// @param cornerType 0左半边圆角，1右半边圆角，3全部圆角
- (id)initWithCornerType:(int)cornerType;

@property (nonatomic, strong) UIButton *button;

@end


@interface BLBlurFloatingView(Manager)

/// 添加视图到window上
/// @param origin 视图位置
/// @param target 点击事件的相应对象
/// @param action 点击事件
+ (BLBlurFloatingView*)showWithOrigin:(CGPoint)origin target:(id)target action:(SEL)action cornerType:(int)type;

+ (BLBlurFloatingView*)show;

@end

NS_ASSUME_NONNULL_END
