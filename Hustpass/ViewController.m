//
//  ViewController.m
//  Hustpass
//
//  Created by zwenqiang on 15/10/8.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import "ViewController.h"
#import "KeBiaoTableViewCell.h"
#import "ElectricViewController.h"
#import "LibraryTableViewCell.h"

@interface ViewController ()
{
    NSArray *linkArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewDidLoad");
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    linkArr = [[NSArray alloc] initWithObjects:@"华中大在线 - 华中科技大学门户网站", @"iKown - 华中科技大学校内问答社区", nil];
    
    /*
     //创建一个导航栏
     UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
     //设置导航栏标题属性
     NSDictionary *navTitleArr = [NSDictionary dictionaryWithObjectsAndKeys:
     [UIFont systemFontOfSize:20.0f], NSFontAttributeName,
     [UIColor whiteColor], NSForegroundColorAttributeName,
     nil];
     [navBar setTitleTextAttributes:navTitleArr];
     
     navBar.backgroundColor = [UIColor colorWithRed:1/255.0f green:184/255.0f blue:130/255.0f alpha:1.0f];
     //创建一个导航栏集合
     UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle: @"华中大校园通"];
     
     //把导航栏集合添加到导航栏中，设置动画关闭
     [navBar pushNavigationItem:navItem animated:NO];
     
     //将标题栏中的内容全部添加到主视图当中
     [self.view addSubview:navBar];
     */
    
    self.navigationItem.title = @"华中大校园通";
    //设置导航栏标题属性
    NSDictionary *navTitleArr = [NSDictionary dictionaryWithObjectsAndKeys:
                                 //[UIFont systemFontOfSize:18.0f], NSFontAttributeName,
                                 [UIColor whiteColor], NSForegroundColorAttributeName,
                                 nil];
    [self.navigationController.navigationBar setTitleTextAttributes:navTitleArr];
    
    //去掉分界线
    self.listView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.listView.dataSource = self;
    self.listView.delegate = self;
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    NSInteger cellRow = indexPath.row;
    NSLog(@"当前显示的是 %ld", (long)cellRow);
    if (cellRow == 0) {
        KeBiaoTableViewCell *cell = [[KeBiaoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        return  cell;
    }else if (cellRow == 1){
        LibraryTableViewCell *cell = [[LibraryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        return cell;
    }else{
        KeBiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[KeBiaoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        return cell;
    }
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
    view.backgroundColor = [UIColor colorWithRed:166/255.0f green:238/255.0f blue:195/255.0f alpha:1.0f];
    UILabel *link = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
    link.text = [linkArr objectAtIndex:1];
    NSLog(@"%@", link);
    link.textAlignment = NSTextAlignmentCenter;
    [link setFont:[UIFont systemFontOfSize:[UIFont smallSystemFontSize]]];
    [view addSubview:link];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 32.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中了第%ld", (long)indexPath.row);
    if (indexPath.row == 0) {
        NSLog(@"选中了第一个");
        
        ElectricViewController *electric = [[ElectricViewController alloc] init];
        //方法一
        [self.navigationController pushViewController:electric animated:YES];
        //方法二
        //[self presentViewController:electric animated:YES completion:nil];
    }else if (indexPath.row == 1){
        NSLog(@"选中了第二个");
        
    }
    
}



@end
