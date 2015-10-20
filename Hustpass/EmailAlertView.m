//
//  EmailAlertView.m
//  Hustpass
//
//  Created by zwenqiang on 15/10/17.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import "EmailAlertView.h"
#import "popupViewController/UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationDrop.h"
#import <QuartzCore/QuartzCore.h>

@interface EmailAlertView ()<UITextFieldDelegate>

@end

@implementation EmailAlertView
@synthesize isBind, innerView=_innerView;


+ (instancetype)defaultPopupView{
    return [[EmailAlertView alloc]initWithFrame:CGRectMake(0, 0, 280, 280)];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    // return NO to disallow editing
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    // became first responder
    NSLog(@"点击编辑事件");
    CGRect frame = self.frame;
    frame.origin.y -= 60;
    self.frame = frame;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"结束编辑");
    CGRect frame = self.frame;
    frame.origin.y += 60;
    self.frame = frame;

    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
     [textField resignFirstResponder];
    return YES;
}

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"继承父视图");
        isBind = false;
        self.backgroundColor = [UIColor clearColor];
        _innerView = [[UIView alloc] init];
        _innerView.frame = frame;
        [_innerView.layer setCornerRadius:10];
        _innerView.backgroundColor = [UIColor colorWithRed:244/255.0f green:244/255.0f blue:244/255.0f alpha:1.0f];
        [self addSubview:_innerView];
        
        UILabel *bindEmail = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 280, 40)];
        bindEmail.textAlignment = NSTextAlignmentCenter;
        bindEmail.font = [UIFont boldSystemFontOfSize:20.0f];
        bindEmail.textColor = [UIColor colorWithRed:0 green:205/255.0f blue:144/255.0f alpha:1.0f];
        bindEmail.text = @"绑定邮箱";
        [_innerView addSubview:bindEmail];
        
        //过渡线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 70, 250, 1)];
        line.backgroundColor = [UIColor colorWithRed:0 green:205/255.0f blue:144/255.0f alpha:1.0f];
        [_innerView addSubview:line];
        
        //area building room info
        NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [pathArray objectAtIndex:0];
        NSString *filePath = [path stringByAppendingPathComponent:@"electric.plist"];
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        NSString *area = [dict objectForKey:@"area"];
        NSString *building = [dict objectForKey:@"building"];
        NSString *room = [dict objectForKey:@"room"];
        
        UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 280, 30)];
        address.text = [NSString stringWithFormat:@"%@   %@栋   %@室", area, building, room];
        address.textColor = [UIColor colorWithRed:0 green:205/255.0f blue:144/255.0f alpha:1.0f];
        address.font = [UIFont systemFontOfSize:16.0f];
        address.textAlignment = NSTextAlignmentCenter;
        [_innerView addSubview:address];
        
        //hint
        UILabel *hint = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(address.frame), 200,40)];
        hint.numberOfLines = 2;
        hint.text = @"为了保证你能正常收到邮件  请正确填写邮箱哦~";
        hint.textColor = [UIColor grayColor];
        hint.font = [UIFont systemFontOfSize:16.0f];
        [_innerView addSubview:hint];
        
        //emailAddress
        self.emailAddress = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(hint.frame) + 10, 250, 40)];
        self.emailAddress.placeholder = @"填写邮箱: test@example.com";
        self.emailAddress.borderStyle = UITextBorderStyleRoundedRect;
        self.emailAddress.delegate = self;
        [_innerView addSubview:self.emailAddress];

        
        //确定按钮
        UIButton *sure = [[UIButton alloc] initWithFrame:CGRectMake(145, 220, 120, 40)];
        sure.layer.cornerRadius = 5;
        sure.backgroundColor = [UIColor colorWithRed:0.0f green:205/255.0f blue:144/255.0f alpha:1.0f];
        [sure setTintColor:[UIColor whiteColor]];
        [sure setTitle:@"确定" forState:UIControlStateNormal];
        [sure addTarget:self.parentVC action:@selector(getEmail) forControlEvents:UIControlEventTouchUpInside];
        [_innerView addSubview:sure];
        
        //取消按钮
        UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(15, 220, 120, 40)];
        cancel.layer.cornerRadius = 5;
        [cancel setTintColor:[UIColor whiteColor]];
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        cancel.backgroundColor = [UIColor colorWithRed:183/255.0f green:183/255.0f blue:183/255.0f alpha:1.0f];
        [cancel addTarget:self action:@selector(dismissPop:) forControlEvents:UIControlEventTouchUpInside];
        [_innerView addSubview:cancel];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(114, -24, 49, 52)];
        UIImage *email = [UIImage imageNamed:@"email"];
        imageView.image = email;
        [self addSubview:imageView];
    }
    return self;
}

//the action to click cancel button
- (void)dismissPop: (UIButton *)btn{
    NSLog(@"取消绑定邮箱");
    isBind = false;
    [self.parentVC lew_dismissPopupView];
}

- (void)getEmail{
    NSLog(@"确定绑定邮箱");
    isBind = true;
    [self.parentVC lew_dismissPopupView];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"触摸来关闭邮箱填写的键盘");
    [self.emailAddress resignFirstResponder];
}
@end
