//
//  ElectricRoundView.h
//  Hustpass
//
//  Created by zwenqiang on 15/10/11.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElectricRoundView : UIView

@property(nonatomic, retain) UILabel *powerLabel;
@property(nonatomic, assign) double remain;
@property(nonatomic, assign) double anglePercent;


- (void) drawElectricArc:(CGContextRef)context Rect:(CGRect) rect Redius: (NSInteger) r angle: (double) angle Width:(CGFloat) width;


@end
