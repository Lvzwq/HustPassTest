//
//  ElectricDataService.h
//  Hustpass
//
//  Created by zwenqiang on 15/10/10.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ElectricDataService : NSObject
{
    NSError *_error;
    UIView *_innerView;
    NSDictionary *_resDict;
    UIActivityIndicatorView *indicator;
}

@property(nonatomic, strong) NSError *_error;
@property(nonatomic, strong) UIView *_innerView;
@property(nonatomic, readwrite, strong) NSDictionary *_resDict;
@property(nonatomic, strong) UIActivityIndicatorView *indicator;

- (void) requestWithArea:(NSString *) area Building:(NSString *)building Room:(NSString *)room;

+ (NSString *) addEmailNotify: (NSDictionary *)param;


@end
