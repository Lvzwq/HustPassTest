//
//  DropList.m
//  Hustpass
//
//  Created by zwenqiang on 15/10/10.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import "DropList.h"

@implementation DropList
@synthesize textValue, listView, tableArr;

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (frame.size.height < 200) {
        frameHeight = 200;
    }else{
        frameHeight = frame.size.height;
    }
    tabheight = frameHeight - 40;
    // frame.size.height = 40.0f;
    
    self=[super initWithFrame:frame];
    if (self) {
        showList = NO;
        textValue = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        textValue.frame = CGRectMake(0, 0, frame.size.width, 40);
        textValue.backgroundColor = [UIColor whiteColor];
        //按钮点击事件
        [textValue addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventTouchUpInside];
        [textValue.layer setMasksToBounds:YES];
        textValue.layer.cornerRadius = 5;
        textValue.clipsToBounds = YES;  //设置按钮圆角
        textValue.tintColor = [UIColor blackColor]; //设置按钮颜色
        [textValue.layer setBorderWidth:0.5f];
        //设置按钮边框颜色
//        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
//        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){1,0,0,1});
//        [textValue.layer setBorderColor:color];
        
        [textValue.layer setBorderColor:[[UIColor colorWithRed:220/255.0f green:189/255.0f blue:189/255.0f alpha:1.0f] CGColor]];
       
        
        [self addSubview:textValue];
        
        listView = [[UITableView alloc] initWithFrame: CGRectMake(0, CGRectGetMaxY(self.textValue.frame), frame.size.width, 0)];
        
        listView.dataSource = self;
        listView.delegate = self;
        listView.hidden = YES;
        [self addSubview:listView];
    }
    return self;
}

- (void)dropdown{
    NSLog(@"点击选择校区");
    if (showList) {
        return;
    }else{
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        listView.hidden = NO;
        [listView setSeparatorInset:UIEdgeInsetsZero];
        showList = YES;//显示下拉框
        
        CGRect frame = listView.frame;
        frame.size.height = 0;
        listView.frame = frame;
        frame.size.height = tabheight;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        listView.frame = frame;
        [UIView commitAnimations];
    }
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableArr count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.textLabel.text = [tableArr objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter; //设置表格文本居中
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [textValue setTitle:[NSString stringWithFormat:@"%@", [tableArr objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    showList = NO;
    tableView.hidden = YES;
    
    CGRect sf = self.frame;
    sf.size.height = 40;
    self.frame = sf;
    CGRect frame = listView.frame;
    frame.size.height = 0;
    listView.frame = frame;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
