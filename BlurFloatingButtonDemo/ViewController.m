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
    self.view.layer.contents = (__bridge id)([UIImage imageNamed:@"timg.jpeg"].CGImage);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [BLBlurFloatingView show];
}


@end
