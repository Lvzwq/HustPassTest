//
//  KeBiaoTableViewCell.h
//  Hustpass
//
//  Created by zwenqiang on 15/10/8.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface KeBiaoTableViewCell : BaseTableViewCell
/**
 * 电费图片
 */
@property(nonatomic, weak) UIView *main;

/**
 * 电费显示的提示信息
 */
@property(nonatomic, retain) UILabel *message;

- (UIView *)getMainView;
@end
