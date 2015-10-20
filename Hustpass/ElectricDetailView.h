//
//  ElectricDetailView.h
//  Hustpass
//
//  Created by zwenqiang on 15/10/10.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
 

@interface ElectricDetailView : UIView
@property(nonatomic, retain)UILabel *pointMsg;
@property(nonatomic, strong)UILabel *avgUseLabel; //日准用电
@property(nonatomic, assign)double powerUsage; //用电量
@property(nonatomic, retain) UIImageView *alertView; //警告图片

- (void)setAvgUse:(double)avgUse;

+ (UILabel *) textLabel: (CGRect)rect;

@end
