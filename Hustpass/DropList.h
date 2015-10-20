//
//  DropList.h
//  Hustpass
//
//  Created by zwenqiang on 15/10/10.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropList : UIView<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *listView;
    NSArray *tableArr; //下拉的数据
    UIButton *textValue;//文本输入框
    BOOL showList; //是否显示下拉数据
    CGFloat tabheight;//table下拉列表的高度
    CGFloat frameHeight;//frame的高度
}

@property (nonatomic,retain) UITableView *listView;
@property (nonatomic,retain) NSArray *tableArr;
@property (nonatomic,retain) UIButton *textValue;

@end
