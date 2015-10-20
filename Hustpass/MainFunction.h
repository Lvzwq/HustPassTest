//
//  MainFunction.h
//  Hustpass
//
//  Created by zwenqiang on 15/10/19.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainFunction : NSObject

+ (BOOL) validateEmail:(NSString *)email;

+ (NSString *)documentPath:(NSString *)fileName;

@end
