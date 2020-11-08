//
//  BLBlurEffect.m
//  TimerButton
//
//  Created by Met on 2020/11/8.
//  Copyright © 2020 bill. All rights reserved.
//

#import "BLBlurEffect.h"

// 通过这个扩展自定义effectSettings，取代主类中的effectSettings；
// 也可以简单理解为将主类中的effectSettings暴露出来
@interface UIBlurEffect (BLBlurEffect)
@property (nonatomic, readonly) id effectSettings;
@end

@implementation BLBlurEffect

- (id)effectSettings {
    // 为了保持除了radius以外的属性不变，需要先把基类的settings取出来
    id settings = [super effectSettings];
    [settings setValue:@(4) forKey:@"blurRadius"];
    return settings;
}

@end
