//
//  ElectricDetailView.m
//  Hustpass
//
//  Created by zwenqiang on 15/10/10.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import "ElectricDetailView.h"
#import "ElectricRoundView.h"

#import "AlertSetViewController.h"
#import "ElectricViewController.h"

@implementation ElectricDetailView
@synthesize pointMsg, avgUseLabel=_avgUseLabel;

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //电量提示标签
        self.pointMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, self.frame.size.width, 30)];
        self.pointMsg.textAlignment = NSTextAlignmentCenter;
        self.pointMsg.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:self.pointMsg];
        
        //设置警告图片
        self.alertView = [[UIImageView alloc] initWithFrame:CGRectMake(270.0f, 20, 29.0f, 29.0f)];
        self.alertView.image = [UIImage imageNamed:@"alarm"];
        self.alertView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertChange:)];
        tap.numberOfTapsRequired = 1;
        [self.alertView addGestureRecognizer:tap];
        [self addSubview:self.alertView];
        
        UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pointMsg.frame) + 20, self.frame.size.width, 1)];
        topLine.backgroundColor = [UIColor greenColor];
        [self addSubview:topLine];
        
        //平均电量获得
        UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topLine.frame) + 60, self.frame.size.width, 1)];
        bottomLine.backgroundColor = [UIColor greenColor];
        [self addSubview:bottomLine];
        
       
        
       _avgUseLabel = [ElectricDetailView textLabel:CGRectMake(140, CGRectGetMaxY(topLine.frame) + 10, 50, 30)];
        NSLog(@"_avgUseLabel = %@", _avgUseLabel);
        [self addSubview:_avgUseLabel];
        
        UILabel *f = [[UILabel alloc] initWithFrame:CGRectMake(55, CGRectGetMaxY(topLine.frame) + 15, 80, 30)];
        f.textAlignment = NSTextAlignmentRight;
        f.font = [UIFont systemFontOfSize:14.0f];
        f.text = @"日均电量: ";
        [self addSubview:f];
        
        UILabel *b = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_avgUseLabel.frame), CGRectGetMaxY(topLine.frame) + 15, 40, 30)];
        b.tag = 101;  //之后获取b的frame，进行调整
        b.textAlignment = NSTextAlignmentLeft;
        b.font = [UIFont systemFontOfSize:14.0f];
        b.text = @"kW.h";
        [self addSubview:b];
    }
    return self;
}

- (void)setAvgUse:(double)avgUse{
    NSString *text = [NSString stringWithFormat:@"%.1f", avgUse];
    NSLog(@"%@", text);
    _avgUseLabel.font = [UIFont fontWithName:@"Helvetica" size:30.0f];
    _avgUseLabel.numberOfLines = 1;
    //自适应文本
    CGRect rect = [text boundingRectWithSize:CGSizeMake(320, 40) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_avgUseLabel.font} context:nil];
    NSLog(@"rect.size.width=%f, y=%f", rect.size.width, _avgUseLabel.frame.origin.y);
    _avgUseLabel.frame = CGRectMake(140, _avgUseLabel.frame.origin.y, rect.size.width, rect.size.height);
    [_avgUseLabel setTextAlignment:NSTextAlignmentCenter];
    [_avgUseLabel setText:text];
    
    //修改之后的偏移
    UILabel *b = (UILabel *)[self viewWithTag:101];
    CGRect fb = b.frame;
    fb.origin.x = 135 + rect.size.width + 10;
    b.frame = fb;
}

+ (UILabel *)textLabel:(CGRect)rect{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    return label;
}

- (void) setPowerUsage:(double)powerUsage{
    _powerUsage = powerUsage;
    //画圆形图
    ElectricRoundView *electricRoundView = [[ElectricRoundView alloc] initWithFrame:CGRectMake(100, 40, 120, 120)];
    electricRoundView.remain = powerUsage;
    [self addSubview:electricRoundView];
}

- (void)alertChange: (UITapGestureRecognizer*) sender{
    NSLog(@"你点击了图片");
    NSLog(@"super.view = %@, super.class = %@",self.superview, self.superclass);
    
    //跳转
    UIView *next = [self superview];
    UIResponder *response = [next nextResponder];
    if ([response isKindOfClass:[UIViewController class]]) {
        UIViewController *viewController = (UIViewController *)response;
        AlertSetViewController *alertViewController = [[AlertSetViewController alloc] init];
        [viewController.navigationController pushViewController:alertViewController animated:YES];
    }
}

@end
