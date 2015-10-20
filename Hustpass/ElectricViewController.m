//
//  ElectricViewController.m
//  Hustpass
//
//  Created by zwenqiang on 15/10/9.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import "ElectricViewController.h"
#import "RoomSettingViewController.h"
#import "ElectricDefaultView.h"
#import "ElectricDetailView.h"
#import "ViewController.h"



@interface ElectricViewController ()

@end

@implementation ElectricViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"进入电费详情页面");
    self.navigationItem.title = @"电费";
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *navTitleArr = [NSDictionary dictionaryWithObjectsAndKeys:
                                 //[UIFont systemFontOfSize:18.0f], NSFontAttributeName,
                                 [UIColor whiteColor], NSForegroundColorAttributeName,
                                 nil];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"切换寝室" style:UIBarButtonItemStylePlain target: self action:@selector(changeRoom:)];
    //右边的文字
    [right setTitleTextAttributes:navTitleArr forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = right;
    [self.navigationController.navigationBar setTitleTextAttributes:navTitleArr];
    
    //左边的返回
    //self.navigationItem.backBarButtonItem.title = @"返回";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismissMyView)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:navTitleArr forState:UIControlStateNormal];
    
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    NSString *pathFile = [path stringByAppendingPathComponent:@"electric.plist"];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:pathFile];
    //添加View
    if(data != nil){
        [self setup:[data objectForKey:@"data"]];
    }else{
        ElectricDefaultView *defauleView = [[ElectricDefaultView alloc] initWithFrame:CGRectMake(0, 64, 320, self.view.frame.size.height - 64)];
        defauleView.tag = 100;
        [self.view addSubview:defauleView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

//初始化数据
- (void) setup: (NSDictionary *)data
{
    ElectricDetailView *detailView = [[ElectricDetailView alloc] initWithFrame:CGRectMake(0, 64, 320, 480)];
    detailView.tag = 100;
    [self.view addSubview:detailView];
    
    //剩余电量
    double remain = [[data valueForKey:@"remain"] doubleValue]; //获取电量
    detailView.powerUsage = remain;
    NSLog(@"电量为%f", remain);
    if (remain > 100) {
        detailView.pointMsg.text = @"电量满满地，放心使用空调吧";
    }else{
        detailView.pointMsg.text = @"电量不足，快去充值吧";
    }
    
    NSDictionary *recent = [data valueForKey:@"recent"];
    NSString *lastUpdateStr = [data valueForKey:@"last_update"];
    
    //获取当前时间
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZone]; //设置时区
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *lastUpdate = [formatter dateFromString:lastUpdateStr];
    
    [formatter setDateFormat:@"YYYYMMdd"];
    NSString *nowtimeStr = [formatter stringFromDate:lastUpdate];
    NSString *weekTimeStr = [NSString stringWithFormat:@"%u", [nowtimeStr intValue] - 6];
    NSLog(@"当前时间%@", nowtimeStr);
    
    
    NSArray *firstDay = [recent valueForKey:weekTimeStr];
    double powerAtWeekAgo = [[firstDay valueForKey:@"dianfei"] doubleValue];
    NSLog(@"一周前 %f", powerAtWeekAgo);
    
    [detailView setAvgUse: (powerAtWeekAgo - remain) / [recent count]];
    [self.view addSubview:detailView];

    
}


#pragma mark -- 返回按钮
- (void)dismissMyView {
    NSLog(@"test");
    NSArray *allControllers = self.navigationController.viewControllers;
    ViewController *parent = [allControllers objectAtIndex:[allControllers count] - 2];
    [parent.listView reloadData];
    [parent.listView layoutIfNeeded];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- 切换寝室的点击事件
- (void)changeRoom:(id)sender{
    NSLog(@"切换寝室");
    RoomSettingViewController *roomSetting = [[RoomSettingViewController alloc] init];
    if (roomSetting) {
        roomSetting.delegate = self;
        [self.navigationController pushViewController:roomSetting animated:YES];
    }
}

#pragma mark -- ElectricInfoDelegate
/**
 *获得数据
 */
- (void)infoGetTimely: (NSDictionary *) value
{
    NSLog(@"进入Delegate");
    NSLog(@"value=%@", value);
    UIView *defaultView = [self.view viewWithTag:100];
    [defaultView removeFromSuperview];  //删除子视图
    [self setup:value];
}
@end
