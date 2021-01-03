//
//  BLBlurFloatingView.m
//  BlurFloatingButtonDemo
//
//  Created by Met on 2020/11/8.
//  Copyright © 2020 bill. All rights reserved.
//

#import "BLBlurFloatingView.h"
#import "BLBlurEffect.h"
#import "UIView+CornerRadius.H"

@interface BlurFloatingButton : UIButton
@end

@implementation BlurFloatingButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat wh = 28;
    
    return CGRectMake(contentRect.size.width/2-wh/2, contentRect.size.height/2-wh/2, wh, wh);
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    return;
    
    
    //添加一个白色的背景视图
    CGFloat padding = 6;
    CGFloat w = self.frame.size.width-2*padding;
    CGFloat h = self.frame.size.height - 2*padding;
    UIView *sd = [self viewWithTag:101];
    if ( !sd ) {
        
        UIView *view = [UIView new];
        view.tag = 101;
        view.userInteractionEnabled = NO;
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
    }
    sd.frame = CGRectMake(padding, padding, w, h);
    sd.layer.masksToBounds = YES;
    sd.layer.cornerRadius = h/2;

    [self sendSubviewToBack:sd];
}

@end


@interface BLBlurFloatingView()

@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, strong) CAShapeLayer *cornerLayer;

@property (nonatomic, assign) int cornerType;

@end

@implementation BLBlurFloatingView

- (id)initWithCornerType:(int)cornerType{
    self = [super init];
    if ( self ){
        _cornerType = cornerType;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.effectView.frame = self.bounds;
    self.button.frame = self.effectView.bounds;
    
    [self setViewCornerRaidusWithType:_cornerType];
}

#pragma mark - TouchEvent
 
- (void)panAction:(UIPanGestureRecognizer *)recognizer {
    
    CGRect fr = recognizer.view.frame;
    
    UIGestureRecognizerState state = recognizer.state;
    if( state == UIGestureRecognizerStateBegan ){
        //开始拖动，设置全部圆角
        [UIView animateWithDuration:0.2 animations:^{
            [self setViewCornerRaidusWithType:3];
        }];
    }
    else if( state == UIGestureRecognizerStateEnded ){
        //结束拖拽，做吸附效果
        
        CGRect sFr = recognizer.view.superview.frame;
        CGFloat minY = 20;
        CGFloat maxY = sFr.size.height - fr.size.height;
        CGFloat minX = 0;
        CGFloat maxX = sFr.size.width - fr.size.width;
        
        CGFloat cx = sFr.size.width/2;
        
        CGFloat ix = 0, iy = fr.origin.y;
        //1.如果view在父视图的中心点左边，则x为0.在后边则为maxY
        if( fr.origin.x > cx ) ix = maxX;
        else{ ix = minX; }
        
        //2.判断y值是否超出范围
        if( iy < minY ) iy = minY;
        else if ( iy > maxY ) iy = maxY;
        
        int cornerType = (fr.origin.x > cx)?0:1;
        
        //记录下圆角类型，防止调动layoutsubviews时，再次绘制会正确
        _cornerType = cornerType;
        
        fr.origin.x = ix;
        fr.origin.y = iy;
        
        [UIView animateWithDuration:0.2 animations:^{
            recognizer.view.frame = fr;
        } completion:^(BOOL finished) {
            [self setViewCornerRaidusWithType:cornerType];
        }];
        
        return;
    }
    
    UIView *inView = self.superview;
    
    CGPoint translationPoint = [recognizer translationInView:inView];
    CGPoint center = recognizer.view.center;
    recognizer.view.center = CGPointMake(center.x + translationPoint.x, center.y + translationPoint.y);
    [recognizer setTranslation:CGPointZero inView:inView];
}

#pragma mark - SetCornerRadius
- (void)setViewCornerRaidus{
    [self setViewCornerRaidusWithType:3];
}

/// 设置effectView和button的圆角
/// @param type 0左边，1右边，其他全部
- (void)setViewCornerRaidusWithType:(NSInteger)type{
    
    CGFloat ih = self.frame.size.height;
    
    UIRectCorner rc = UIRectCornerAllCorners;
    if( type == 0 ) {
        rc = UIRectCornerTopLeft|UIRectCornerBottomLeft;
    }else if( type == 1 ){
        rc = UIRectCornerTopRight|UIRectCornerBottomRight;
    }
    
    //圆角处理
    [UIView setCornerWithView:self.button viewSize:self.button.frame.size corners:rc radius:ih/2];
    [UIView setCornerWithView:self.effectView viewSize:self.effectView.frame.size corners:rc radius:ih/2];
     
    
    //添加边框图层时，移除上一个边框
    if( _cornerLayer ){
        [_cornerLayer removeFromSuperlayer];
    }
    
    //添加圆角边框图层
    _cornerLayer =
    [UIView setCornerWithView:self.effectView viewSize:self.effectView.frame.size corners:rc radius:ih/2 borderColor:[UIColor colorWithWhite:0.8 alpha:1]];
}

#pragma mark - SetupUI
- (void)setupUI{
    //使用修改blurRadius后的模糊效果, 更加透明
    UIBlurEffect *effect = [BLBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self addSubview:_effectView];

    _button = [BlurFloatingButton new];
    UIImage *highlightImg = [self imageFromColor:[UIColor colorWithWhite:0.85 alpha:0.3]];
    [_button setBackgroundImage:highlightImg forState:UIControlStateHighlighted];
    [_button setImage:[UIImage imageNamed:@"shijian-2"] forState:UIControlStateNormal];
    [self.effectView.contentView addSubview:_button];
    
    //阴影
    UIView *shadowView = self;
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOpacity = 0.15;
    shadowView.layer.shadowOffset = CGSizeZero;
    shadowView.layer.shadowRadius = 5;
    shadowView.clipsToBounds = NO;

    //添加拖动
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:pan];
}

- (UIImage *)imageFromColor:(UIColor *)color{

    CGRect rect = CGRectMake(0, 0, 10,10);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end



@implementation BLBlurFloatingView(Manager)

+ (BLBlurFloatingView *)showWithOrigin:(CGPoint)origin target:(id)target action:(SEL)action cornerType:(int)type{
    
    BLBlurFloatingView *bfv = [[BLBlurFloatingView alloc] initWithCornerType:type];
    bfv.frame = CGRectMake(origin.x, origin.y, self.viewWH*2+10, self.viewWH);
    if( target && action ){
        if( [target respondsToSelector:action] ){
            [bfv.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    UIView *win = [UIApplication sharedApplication].keyWindow;
    if( win == nil ){
        NSArray *ws = [UIApplication sharedApplication].windows;
        if( ws.count ){
            win = ws[0];
        }
    }
    
    if( win ){
        [win addSubview:bfv];
    }
    
    return bfv;
}

+ (BLBlurFloatingView *)show{
    CGFloat wh = self.viewWH;
    CGSize size = UIScreen.mainScreen.bounds.size;
    
    BLBlurFloatingView *fv =
    [self showWithOrigin:CGPointMake(size.width-wh, size.height-wh-100) target:nil action:nil cornerType:0];
    
    [fv.button addTarget:fv action:@selector(handleBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return fv;
}

+ (CGFloat)viewWH{
    return 56;
}

- (void)handleBtn{
    NSLog(@"------ handle btn -------");
}

@end
