//
//  ElectricDataService.m
//  Hustpass
//
//  Created by zwenqiang on 15/10/10.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ElectricDataService.h"
#import "Constant.h"

@interface ElectricDataService()<NSURLConnectionDataDelegate>

@end

@implementation ElectricDataService
@synthesize _error, _resDict, _innerView, indicator;
- (void)requestWithArea:(NSString *)area Building:(NSString *)building Room:(NSString *)room
{
    NSString *requestURLStr = [NSString stringWithFormat:@"%@?area=%@&build=%@&room=%@", BASEURL, area, building, room];
    NSLog(@"url = %@", requestURLStr);
    NSURL *requestURL = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    /****************************************************/
    NSURLResponse *response = nil;
    NSError *error = nil;
//    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicator.frame = CGRectMake(0, 0, 20, 20);
//    indicator.center = _innerView.center;
//    [_innerView addSubview:indicator];
//    [indicator startAnimating];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error == nil) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        _resDict = dict;
        NSLog(@"return = %@", dict);
    }
    /***********************************************/
    
    /**
    //发送请求
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.center = _innerView.center;
    [_innerView addSubview:indicator];
    [indicator startAnimating];
     */
}


/**
 * 设置邮件通知
 */
+ (NSString *) addEmailNotify: (NSDictionary *)param {
    NSURL *requestURL = [NSURL URLWithString:[EMAILNOTIFY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    //设置参数
    NSString *paramStr = [NSString stringWithFormat:@"area=%@&build=%@&room=%@&email=%@&notify=%@", [param objectForKey:@"area"], [param objectForKey:@"building"], [param objectForKey:@"room"], [param objectForKey:@"email"], [param objectForKey:@"threshold"]];
    NSLog(@"参数有%@", paramStr);
    NSData *dataStr = [paramStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:dataStr];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    //同步请求
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: &error];
    if (error != nil) {
        return @"请检查网络设置，网络连接失败!";
    }
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
    int code = [[dict objectForKey:@"code"] intValue];
    NSLog(@"放回数据dict = %@, code = %d", dict, code);
    
    if (code == 200) {
        return @"设置邮件提醒成功";
    }else if (code == 410){
        return @"邮箱已经被绑定";
    }else if(code == 402){
        return @"输入错误";
    }else{
        return @"绑定失败";
    }
}

#pragma mark -- NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _resDict = [[NSDictionary alloc] init];
    [indicator stopAnimating];
    
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to the instance variable you declared
    //解析数据,转化为json数据
    NSError *error = nil;
    _resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"return = %@", _resDict);
    _error = error;
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}




@end
