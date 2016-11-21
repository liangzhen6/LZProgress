//
//  LZProgressView.m
//  CircularProgress
//
//  Created by shenzhenshihua on 2016/11/21.
//  Copyright © 2016年 shenzhenshihua. All rights reserved.
//

#import "LZProgressView.h"


@interface LZProgressView()

@property(nonatomic,strong)UILabel *progressLable;

@property(nonatomic,strong)CAShapeLayer * progressLayer;

@property(nonatomic,strong)CALayer * gradientLayer;

@end

@implementation LZProgressView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    self.backgroundColor = [UIColor whiteColor];
    self.progressLable = [[UILabel alloc] initWithFrame:CGRectMake(20, self.frame.size.height/2-20, self.frame.size.width-40, 40)];
    self.progressLable.text = @"0%";
    self.progressLable.textColor = [UIColor blackColor];
    self.progressLable.textAlignment = NSTextAlignmentCenter;
    self.progressLable.backgroundColor = [UIColor clearColor];
    [self addSubview:self.progressLable];

}



- (void)setProgress:(CGFloat)progress{
    _progress = progress;

    self.progressLable.text = [NSString stringWithFormat:@"%.f%%",self.progress*100];
    [self setNeedsDisplay];
    
   
}

- (CALayer *)gradientLayer{
    if (_gradientLayer==nil) {
        _gradientLayer = [CALayer layer];
        //单色
        CAGradientLayer *backLayer = [[CAGradientLayer alloc] init];
        backLayer.frame = self.bounds;
        backLayer.backgroundColor = [UIColor greenColor].CGColor;
        [_gradientLayer addSublayer:backLayer];
        
        /*渐变色彩  七彩
        //左侧渐变色
        CAGradientLayer *leftLayer = [CAGradientLayer layer];
        leftLayer.frame = CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.height);    // 分段设置渐变色
        leftLayer.locations = @[@0.3, @0.9, @1];
//        leftLayer.colors = @[(id)[UIColor yellowColor].CGColor, (id)[UIColor greenColor].CGColor];
        leftLayer.colors = @[(id)[UIColor greenColor].CGColor, (id)[UIColor yellowColor].CGColor];

        [_gradientLayer addSublayer:leftLayer];
        
        //右侧渐变色
        CAGradientLayer *rightLayer = [CAGradientLayer layer];
        rightLayer.frame = CGRectMake(self.bounds.size.width / 2, 0, self.bounds.size.width / 2, self.bounds.size.height);
        rightLayer.locations = @[@0.3, @0.9, @1];
//        rightLayer.colors = @[(id)[UIColor yellowColor].CGColor, (id)[UIColor redColor].CGColor];
        rightLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor yellowColor].CGColor];

        [_gradientLayer addSublayer:rightLayer];
         */
    }

    return _gradientLayer;

}

// Only override drawRect: if you perform custom drawing.
//http://www.cnblogs.com/jgCho/p/5253364.html
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGFloat W = self.bounds.size.width/2;
//    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取上下文

    CGPoint center = CGPointMake(W, W);//设置时给的应该是个正方形；
    CGFloat radius = W-10;
    CGFloat startA = -M_PI_2;//园的起点位置
    CGFloat endA   = -M_PI_2 + M_PI * 2 * _progress;
 
//    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
//    CGContextSetLineWidth(ctx, 5);//设置线条宽度
//    
//    [[UIColor blueColor] setStroke];//设置颜色
//    
//    CGContextAddPath(ctx, path.CGPath);//把路径添加到上下文
//    [UIView animateWithDuration:0.5 animations:<#^(void)animations#>]
//    CGContextStrokePath(ctx);//渲染
 
    
    //获取环形路径（画一个圆形，填充色透明，设置线框宽度为10，这样就获得了一个环形）
    _progressLayer = [CAShapeLayer layer];//创建一个track shape layer
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [[UIColor clearColor] CGColor];  //填充色为无色
    _progressLayer.strokeColor = [[UIColor greenColor] CGColor]; //指定path的渲染颜色,这里可以设置任意不透明颜色
    _progressLayer.opacity = 1; //背景颜色的透明度
    _progressLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _progressLayer.lineWidth = 5;//线的宽度
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];//上面说明过了用来构建圆形
    _progressLayer.path =[path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
//    [self.layer addSublayer:_progressLayer];
    
    [self.gradientLayer setMask:_progressLayer]; //用progressLayer来截取渐变层
    [self.layer addSublayer:self.gradientLayer];
    
    // Drawing code
}

@end
