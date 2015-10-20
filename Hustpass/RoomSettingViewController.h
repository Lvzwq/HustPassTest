//
//  RoomSettingViewController.h
//  Hustpass
//
//  Created by zwenqiang on 15/10/9.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropList.h"
#import "ElectricViewController.h"



@interface RoomSettingViewController : UIViewController
@property(nonatomic, retain) UIImageView *titleView;
@property(nonatomic, retain) UIImageView *areaView;
@property(nonatomic, retain) UIImageView *buildingView;
@property(nonatomic, retain) UIImageView *roomView;

@property(nonatomic, retain) UIButton *sure;

@property(nonatomic, retain) DropList *areaField;
@property(nonatomic, retain) UITextField *buildField;
@property(nonatomic, retain) UITextField *roomField;

//定义协议变量
@property(assign)id<ElectricInfoDelegate> delegate;

@end
