//
//  ElectricRoundView.m
//  Hustpass
//
//  Created by zwenqiang on 15/10/11.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import "ElectricRoundView.h"

@interface ElectricRoundView (){
    double currentAngle;
}
@end

@implementation ElectricRoundView
@synthesize powerLabel=_powerLabel;

- (id) initWithFrame:(CGRect)frame{
    NSLog(@"%@, initWithFrame", self.class);
    self = [super initWithFrame:frame];
    self.anglePercent = 0;
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _powerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2 - 20, self.frame.size.width, 40)];
        _powerLabel.textAlignment = NSTextAlignmentCenter;
        [_powerLabel setFont:[UIFont boldSystemFontOfSize:30.0f]];
        [self addSubview:_powerLabel];
        UILabel *tint = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_powerLabel.frame), self.frame.size.width, 14)];
        tint.textAlignment = NSTextAlignmentCenter;
        tint.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        tint.text = @"kW.h";
        [self addSubview:tint];
    }
    return self;
}

- (void) setAnglePercent:(double)angle{
    _anglePercent = angle;
    [self setNeedsDisplay];
}


- (void) setRemain:(double)remain{
    _remain = remain;
    currentAngle = [self getAngle];
    _powerLabel.text = [NSString stringWithFormat:@"%.1f", remain];
     [NSTimer scheduledTimerWithTimeInterval:0.002f target:self selector:@selector(timerFunc:) userInfo:nil repeats:YES];
}

//计算电费占用百分比
- (double) getAngle{
    //分布时间戳0-50： 25%， 50-300  75% 300-400 100%
    if (self.remain <= 0) {
        return 0;
    }
    if (self.remain < 50) {
        return self.remain / 50 * 0.25;
    }else if (self.remain >= 50 && self.remain < 300){
        return 0.25 + (self.remain - 50) / 250 * 0.5;
    }else if(self.remain >= 300 && self.remain < 400){
        return 0.75 + (self.remain - 300) / 100 * 0.25;
    }else{
        return  1;
    }
    
}

//计时器执行函数
- (void) timerFunc: (NSTimer *) timer{
    if (self.anglePercent < currentAngle) {
        self.anglePercent += 0.02;
    }else{
        [timer invalidate];
    }
}

- (void) drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //第一个圆
    CGContextAddArc(context, rect.size.width/2, rect.size.height/2, rect.size.width/2 - 10, -M_PI_2, M_PI * 2, 0);
    CGContextSetLineWidth(context, 5);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetRGBStrokeColor(context, 220/255.0f, 220/255.0f, 220/255.0f, 1.0f);
    //渲染一次
    CGContextStrokePath(context);
    //电费的半个圆弧
    [self drawElectricArc:context Rect:self.frame Redius: self.frame.size.width/2 angle: self.anglePercent Width:8];
}

- (void) drawElectricArc:(CGContextRef)context Rect:(CGRect) rect Redius: (NSInteger) r angle: (double) angle Width:(CGFloat) width{
    CGContextAddArc(context, rect.size.width/2, rect.size.height/2, r-10, -M_PI_2, -M_PI_2 + angle * M_PI * 2, 0);
    CGContextSetRGBStrokeColor(context, 0.0f, 205/255.0f, 144/255.0f, 1.0f);
    CGContextSetLineWidth(context, width);
    CGContextSetLineCap(context, kCGLineCapRound);
    //渲染
    CGContextStrokePath(context);
}


@end
