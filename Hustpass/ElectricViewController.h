//
//  ElectricViewController.h
//  Hustpass
//
//  Created by zwenqiang on 15/10/9.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


//定义协议
@protocol ElectricInfoDelegate <NSObject>

//获取返回的数据
- (void)infoGetTimely: (NSDictionary *) value;
@end


@interface ElectricViewController : UIViewController<ElectricInfoDelegate>

- (void) setup: (NSDictionary *)data;

@end
