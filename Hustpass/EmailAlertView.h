//
//  EmailAlertView.h
//  Hustpass
//
//  Created by zwenqiang on 15/10/17.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmailAlertView : UIView{
    
}

@property(nonatomic) Boolean isBind;
@property(nonatomic, strong) UIView *innerView;
@property(nonatomic, weak) UIViewController *parentVC;
@property(nonatomic, retain) UITextField *emailAddress;

+ (instancetype)defaultPopupView;

@end
