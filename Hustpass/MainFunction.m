//
//  MainFunction.m
//  Hustpass
//
//  Created by zwenqiang on 15/10/19.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import "MainFunction.h"
@implementation MainFunction


//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//获得沙盒的文档目录下文件名
+ (NSString *)documentPath:(NSString *)fileName
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    return [path stringByAppendingPathComponent:fileName];
}

@end
