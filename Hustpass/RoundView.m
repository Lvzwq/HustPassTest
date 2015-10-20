//
//  RoundView.m
//  Hustpass
//
//  Created by zwenqiang on 15/10/19.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import "RoundView.h"

@implementation RoundView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0.0f, 205/255.0f, 144/255.0f, 1.0f);
    CGContextFillEllipseInRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    //渲染一次
    CGContextStrokePath(context);
}


@end
