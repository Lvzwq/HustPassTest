//
//  RoomSettingViewController.m
//  Hustpass
//
//  Created by zwenqiang on 15/10/9.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//


#import "RoomSettingViewController.h"
#import "ElectricDataService.h"
#import <QuartzCore/QuartzCore.h>

@interface RoomSettingViewController ()<UITextFieldDelegate>
{
    UIActivityIndicatorView *indicator;
}
@end

@implementation RoomSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置寝室";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1.0f];
    [self setSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setSize
{
    //新建UIControl，用于关闭键盘
    UIControl *control = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [control addTarget:self action:@selector(closeTextFieldKeyBorad:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:control];
    
    self.titleView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 90, 80, 80)];
    UIImage *titleImage = [UIImage imageNamed:@"title_thumb.jpg"];
    self.titleView.image = titleImage;
    [self.view addSubview:self.titleView];
    
    self.areaView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 200, 40, 40)];
    self.areaView.image = [UIImage imageNamed:@"area_thumb.jpg"];
    [self.view addSubview:self.areaView];
    
    self.buildingView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 260, 40, 40)];
    self.buildingView.image = [UIImage imageNamed:@"building_thumb.jpg"];
    [self.view addSubview:self.buildingView];

    self.roomView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 320, 40, 40)];
    self.roomView.image = [UIImage imageNamed:@"room_thumb.jpg"];
    [self.view addSubview:self.roomView];
    
 
    //使用下拉菜单
    self.areaField = [[DropList alloc] initWithFrame:CGRectMake(100, 200, 160, 160)];
    
    NSArray *arr = [[NSArray alloc] initWithObjects:@"韵苑", @"紫松", @"东区", @"西区", nil];
    [self.areaField.textValue setTitle: @"韵苑" forState:UIControlStateNormal];
    self.areaField.tableArr = arr;
    [self.view addSubview:self.areaField];
    
    //楼栋
    self.buildField = [[UITextField alloc] initWithFrame:CGRectMake(100, 260, 160, 40)];
    self.buildField.placeholder = @"请输入楼栋";
    self.buildField.borderStyle = UITextBorderStyleRoundedRect;
    self.buildField.textAlignment = NSTextAlignmentCenter;  //文本居中
    self.buildField.font = [UIFont systemFontOfSize:15.0f];
    self.buildField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.buildField];
    
    //寝室
    self.roomField = [[UITextField alloc] initWithFrame:CGRectMake(100, 320, 160, 40)];
    self.roomField.placeholder = @"请输入寝室号";
    self.roomField.borderStyle = UITextBorderStyleRoundedRect;
    self.roomField.textAlignment = NSTextAlignmentCenter;
    self.roomField.font = [UIFont systemFontOfSize: 15.0f];
    self.roomField.keyboardType = UIKeyboardTypeNumberPad;
    self.roomField.delegate = self;
    //方法一
    //[self.roomField addTarget:self action:@selector(closeTextFieldKeyBorad:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:self.roomField];
    
    //确定按钮
    self.sure = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.sure.frame = CGRectMake(90.0f, 420.0f, 140.0f, 40.0f);
    [self.sure setTitle:@"确定" forState:UIControlStateNormal];
    self.sure.backgroundColor = [UIColor colorWithRed:0.0f green:205/255.0f blue:144/255.0f alpha:1.0f];
    [self.sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sure.layer.cornerRadius = 5;
    self.sure.clipsToBounds = YES;  //设置按钮圆角
    [self.sure addTarget:self action:@selector(getRoomData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sure];
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0, 0, 20, 20);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
}


#pragma mark -- 按钮点击事件
- (void)getRoomData{
    NSString *area = [NSString stringWithFormat:@"%@",self.areaField.textValue.currentTitle];
    NSString *building = [NSString stringWithFormat:@"%@", self.buildField.text];
    NSString *room = [NSString stringWithFormat:@"%@", self.roomField.text];
    
    BOOL isRight = TRUE;
    NSMutableString *msg = [[NSMutableString alloc] init];
    
    if (building.length == 0 || building == nil) {
        isRight = FALSE;
        [msg appendString:@"请选择楼层"];
    }
    
    if (room.length == 0 || building == nil) {
        isRight = FALSE;
        if ([msg isEqualToString:@""]) {
            [msg appendString:@"请选择寝室"];
        }else{
            [msg appendString:@"和寝室"];
        }
    }
    
    if (isRight == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [NSTimer scheduledTimerWithTimeInterval:0.8f target:self selector:@selector(performDismiss:) userInfo:alert repeats:NO];
        [alert show];
        return ;
    }
    
    NSLog(@"你的选择是%@, room=%@", building, room);

    [indicator startAnimating];
    //显示网络请求
    UIApplication* app = [ UIApplication sharedApplication ];
    app.networkActivityIndicatorVisible = YES;
    // 网络请求
    ElectricDataService *service = [[ElectricDataService alloc] init];
    service._innerView = self.view;
    [service requestWithArea:area Building:building Room:room];
    NSDictionary *dict = service._resDict;
    
    NSLog(@"dict = %@", service._resDict);
    
    
    if(dict == nil){
        isRight = NO;
        [msg appendString:@"网络请求失败，请检查网络设置!"];
    }else{
        int code = [[dict objectForKey:@"code"] intValue];
        if (code == 200) {
            //存入数据到plist中
            NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *path = [pathArray objectAtIndex:0];
            //电费存储的文件
            NSString *pathFile = [path stringByAppendingPathComponent:@"electric.plist"];
            NSMutableDictionary *mutable = [[NSMutableDictionary alloc] init];
            NSLog(@"mutable = %@", mutable);
            
            [mutable setObject:[dict objectForKey:@"data"] forKey:@"data"];
            [mutable setObject:area forKey:@"area"];
            [mutable setObject:building forKey:@"building"];
            [mutable setObject:room forKey:@"room"];
            [mutable setObject:@"10" forKey:@"threshold"];
            NSLog(@"mutable = %@", mutable);
            //写入文件
            [mutable writeToFile:pathFile atomically:YES];
            //传递数据到第一个页面
            [self.delegate infoGetTimely:[dict objectForKey:@"data"]];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }else{
            isRight = NO;
            [msg appendString:[dict objectForKey:@"msg"]];
        }
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    //弹框定时
    [NSTimer scheduledTimerWithTimeInterval:0.8f target:self selector:@selector(performDismiss:) userInfo:alert repeats:NO];
    
    [indicator stopAnimating];
    app.networkActivityIndicatorVisible = NO;
    [alert show];
    return ;
}


#pragma  mark -- 弹框警告
- (void) performDismiss: (NSTimer *)timer
{
    [timer.userInfo dismissWithClickedButtonIndex:0 animated: YES];
}

#pragma mark -- 关闭键盘
- (void)closeTextFieldKeyBorad: (id)sender{
    NSLog(@"开始关闭键盘");
    [self.buildField resignFirstResponder];
    [self.roomField resignFirstResponder];
    NSLog(@"关闭键盘%@",sender);
}

/*
#pragma mark --方法二
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.roomField resignFirstResponder];
    [self.buildField resignFirstResponder];
}
*/

#pragma mark --UITextFieldDelegate 方法三
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // called when 'return' key pressed. return NO to ignore.
    NSLog(@"按下了return键");
    [textField resignFirstResponder];//等于上面两行的代码
    return YES;
}


@end
