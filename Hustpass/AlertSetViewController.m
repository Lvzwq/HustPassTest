//
//  AlertSetViewController.m
//  Hustpass
//
//  Created by zwenqiang on 15/10/17.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import "AlertSetViewController.h"
#import "popupViewController/LewPopupViewAnimationDrop.h"
#import "popupViewController/LewPopupViewAnimationSpring.h"
#import "EmailAlertView.h"
#import "ElectricDataService.h"
#import "MainFunction.h"

@interface AlertSetViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic, strong) UIImageView *alertImageView;
@end

@implementation AlertSetViewController
@synthesize threshold=_threshold;

- (void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"%@, viewDidLoad", self.class);
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"警报";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置警报" style:UIBarButtonItemStylePlain target:self action:@selector(alertSet)];
    [self setup];
}

- (void)setup{
    UILabel *alertHint = [[UILabel alloc] initWithFrame:CGRectMake(70, 80, 180, 60)];
    alertHint.numberOfLines = 2;
    alertHint.font = [UIFont systemFontOfSize:15.0f];
    alertHint.text = @"当寝室电量这个数值时,系统会提醒你赶快充电哦!";
    [self.view addSubview:alertHint];
    
    self.alertImageView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 80, 29, 29)];
    UIImage *alertImage = [UIImage imageNamed:@"alarm"];
    self.alertImageView.tag = 30;
    self.alertImageView.image = alertImage;
    
    //add GestureRecognizer
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelEmailed:)];
    g.numberOfTapsRequired = 1;
    g.delegate = self;
    [self.alertImageView addGestureRecognizer:g];
    [self.view addSubview:self.alertImageView];
    
   
    _threshold = [[UITextField alloc] init];
    _threshold.frame = CGRectMake(100, 150, 120, 70);
    _threshold.placeholder = @"10";
    _threshold.font = [UIFont systemFontOfSize:40.0f];
    _threshold.borderStyle = UITextBorderStyleRoundedRect;
    _threshold.textAlignment = NSTextAlignmentCenter;
    _threshold.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:_threshold];
    
    UILabel *kWh = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_threshold.frame) + 20, CGRectGetMidY(_threshold.frame) - 10, 100, 20)];
    kWh.text = @"kW - h";
    kWh.textColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:1.0];
    [self.view addSubview:kWh];
    
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sure.frame = CGRectMake(80, 240, 160, 40);
    sure.layer.cornerRadius = 5;
    sure.clipsToBounds = YES;  //设置按钮圆角
    [sure setTitle:@"绑定邮箱" forState:UIControlStateNormal];
    [sure setTintColor:[UIColor whiteColor]];
    [sure addTarget:self action:@selector(rechargeGet:) forControlEvents:UIControlEventTouchUpInside];
    sure.backgroundColor = [UIColor colorWithRed:0.0f green:205/255.0f blue:144/255.0f alpha:1.0f];
    [self.view addSubview:sure];
    
    UIView *transitionLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sure.frame) + 20, 320, 1)];
    transitionLine.backgroundColor = [UIColor colorWithRed:0.0f green:205/255.0f blue:144/255.0f alpha:1.0f];
    [self.view addSubview:transitionLine];
    
    UILabel *rechargeHint = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(transitionLine.frame) + 10, 200, 25)];
    rechargeHint.text = @"电费充值地点";
    rechargeHint.font = [UIFont systemFontOfSize:16.0f];
    rechargeHint.textColor = [UIColor grayColor];
    [self.view addSubview:rechargeHint];
    
    //电费充值地点的图片
    UIImageView *recharge = [[UIImageView alloc] initWithFrame:CGRectMake(20, 350, 280, 180)];
    recharge.image = [UIImage imageNamed:@"recharge"];
    [self.view addSubview:recharge];
    
}

- (void)alertSet
{
    EmailAlertView *emailView = [EmailAlertView defaultPopupView];
    emailView.parentVC = self;
    NSLog(@"self = %@", self);
    [self lew_presentPopupView:emailView animation:[LewPopupViewAnimationSpring new] dismissed:^{
        NSLog(@"动画结束");
        if (emailView.isBind) {
            NSString *email = emailView.emailAddress.text;
            NSLog(@"确定绑定邮箱 email = %@", email);
            BOOL isValid = [MainFunction validateEmail:email];
            if (isValid) {
                NSString *filePath = [MainFunction documentPath:@"electric.plist"];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
                [dict setObject:email forKey:@"email"];
                [dict writeToFile: filePath atomically:YES];
                
                NSString *r = [ElectricDataService addEmailNotify:dict];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:r delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                return ;
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"邮箱地址不规范" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                return ;
            }
        }
        
    }];

}

- (void) rechargeGet:(UIButton *)btn{
    NSLog(@"点击了确定");
    EmailAlertView *emailView = [EmailAlertView defaultPopupView];
    emailView.parentVC = self;
    NSLog(@"self = %@", self);
    [self lew_presentPopupView:emailView animation:[LewPopupViewAnimationDrop new] dismissed:^{
        if (emailView.isBind) {
            NSString *email = emailView.emailAddress.text;
            NSLog(@"确定绑定邮箱 email = %@", email);
            BOOL isValid = [MainFunction validateEmail:email];
            if (isValid) {
                NSString *filePath = [MainFunction documentPath:@"electric.plist"];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
                [dict setObject:email forKey:@"email"];
                [dict writeToFile: filePath atomically:YES];
                
                NSString *r = [ElectricDataService addEmailNotify:dict];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:r delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                return ;
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"邮箱地址不规范" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                return ;
            }
            
        }
        
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_threshold resignFirstResponder];
    NSLog(@"触摸来关闭键盘");
    //[self.nextResponder touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    CGPoint hitPoint = [self.alertImageView convertPoint:point fromView:self.view];
    if ([self.alertImageView pointInside:hitPoint withEvent:event]) {
         NSLog(@"点击了图片");
        if (self.alertImageView.tag == 30) {
            self.alertImageView.image = [UIImage imageNamed:@"cancel_bind"];
            self.alertImageView.tag = 31;
        }else if (self.alertImageView.tag == 31){
            self.alertImageView.image = [UIImage imageNamed:@"alarm"];
            self.alertImageView.tag = 30;
        }
        
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:[MainFunction documentPath:@"electric.plist"]];
        NSLog(@"设置的dict = %@", dict);
        NSString *email = [dict objectForKey:@"email"];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"提示" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        if (email == nil) {
            alertView.message = @"还没有设置邮件地址";
            [alertView show];
            return;
        }
        NSString *r = [ElectricDataService addEmailNotify:dict];
        [alertView setMessage:r];
        [alertView show];
        return;
        
    }
}

#pragma mark hitTest
/*
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // 本View不响应用户事件
    CGPoint hitPoint = [self.alertImageView convertPoint:point fromView:self.view];
    if([self.alertImageView pointInside:hitPoint withEvent:event]){
        return NO;
    }
    return YES;
}
*/

#pragma mark UIGestureRecognizer
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIImageView class]])
    {
        return YES;
    }
    return NO;
}

- (void)cancelEmailed: (UIImageView *)imageView{
    NSLog(@"imageView = %@", imageView);
    if (imageView.tag == 30) {
        imageView.image = [UIImage imageNamed:@"cancel_bind"];
        imageView.tag = 31;
    }else if (imageView.tag == 31){
        imageView.image = [UIImage imageNamed:@"alarm"];
        imageView.tag = 30;
    }
}

@end
