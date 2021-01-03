//
//  ViewController.m
//  BlurFloatingButtonDemo
//
//  Created by Met on 2020/11/8.
//  Copyright © 2020 bill. All rights reserved.
//

#import "ViewController.h"
#import "BLBlurFloatingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.contents = (__bridge id)([UIImage imageNamed:@"首页"].CGImage);
    
    UIImageView * iv = [UIImageView new];
    iv.frame = self.view.bounds;
    iv.image = [UIImage imageNamed:@"首页"];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iv];
    iv.backgroundColor = [UIColor colorWithWhite:1 alpha:0.75];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    [self addTimeBtn];
//    return;
//    [BLBlurFloatingView show]
    
    BLBlurFloatingView *fv = [BLBlurFloatingView show];
    [fv.button setImage:nil forState:UIControlStateNormal];
    
    CGSize size = fv.frame.size;
    
    UILabel *titleL = [UILabel new];
    titleL.font = [UIFont systemFontOfSize:12.0];
    titleL.textColor = [UIColor colorWithWhite:51.0/255.0 alpha:1];
    titleL.frame = CGRectMake(0, 10, size.width, size.height/2-20);
    titleL.textAlignment = NSTextAlignmentCenter;
    [fv addSubview:titleL];
    
    CGFloat iy = CGRectGetMaxY(titleL.frame);
    UILabel *timeL = [UILabel new];
    timeL.font = [UIFont boldSystemFontOfSize:20.0];
    timeL.textColor = [UIColor colorWithWhite:51/255.0 alpha:1.0];
    timeL.frame = CGRectMake(0, iy, size.width, size.height-iy-3);
    timeL.textAlignment = NSTextAlignmentCenter;
    [fv addSubview:timeL];
    
    timeL.textColor = [UIColor colorWithRed:37/155.0 green:119/255.0 blue:241/255.0 alpha:1];
//    timeL.textColor = [UIColor blueColor];
    
    titleL.text = @"跑步计时中";
    timeL.text = @"00:13:52";
}

- (void)addTimeBtn{
    BLBlurFloatingView *fv = [BLBlurFloatingView show];
//    [fv.button setImage:nil forState:UIControlStateNormal];
    
    CGSize size = fv.frame.size;
    //添加一个白色的背景视图
    CGFloat padding = 6;
    CGFloat w = size.width-2*padding;
    CGFloat h = size.height - 2*padding;
    
    UIView *view = [UIView new];
    view.tag = 101;
    view.userInteractionEnabled = NO;
    view.backgroundColor = [UIColor whiteColor];
    [fv.button addSubview:view];
    
    view.frame = CGRectMake(padding, padding, w, h);
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = h/2;

//    [self sendSubviewToBack:sd];
    
    [fv.button sendSubviewToBack:view];
}

@end
