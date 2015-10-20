//
//  KeBiaoTableViewCell.m
//  Hustpass
//
//  Created by zwenqiang on 15/10/8.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import "KeBiaoTableViewCell.h"
#import "MainFunction.h"
#import "ElectricRoundView.h"

@implementation KeBiaoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    NSLog(@"执行cell中awakeFromNib");
    self.textLabel.text = @"欢迎光临@";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor colorWithRed:255.0f green:255.0f blue:255.0f alpha:1.0f];
    if (self) {
        //添加 viewEdge背景
        self.viewEdge = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        self.viewEdge.backgroundColor = [UIColor colorWithWhite:0.9f alpha:0.6f];
        [self addSubview:self.viewEdge];
        
        //添加背景下的线条
        self.HeadLineImage = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.viewEdge.frame), 320, 3)];
        self.HeadLineImage.backgroundColor = [UIColor colorWithRed:0 green:255/255.0f blue:144/255.0f alpha:1.0f];
        [self addSubview:self.HeadLineImage];
        
        //添加文字标示
        self.identifierStr = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.HeadLineImage.frame) + 10, 80, 25)];
        
        self.identifierStr.text = @"剩余电量";
        [self.identifierStr setFont:[UIFont systemFontOfSize:16.0f]];
        self.identifierStr.textAlignment = NSTextAlignmentCenter;
        self.identifierStr.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.identifierStr];
        
        //添加电量显示图形
        self.message = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 25)];
        NSLog(@"self.frame.y = %f", CGRectGetMaxX(self.frame));
        self.message.backgroundColor = [UIColor whiteColor];
        self.message.text = @"电量慢慢地，空调随便用!";
        [self.message setFont:[UIFont systemFontOfSize:14.0f]];
        self.message.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.message];
        
        [self addSubview:[self getMainView]];
        
        //在文字标示下面的线条
        self.belowStrView = [[UIView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(self.identifierStr.frame), 60, 3)];
         
        self.belowStrView.backgroundColor = [UIColor greenColor];
        [self addSubview:self.belowStrView];
        
        
        
    }
    return self;
}

- (UIView *)getMainView{
    NSString *filePath = [MainFunction documentPath:@"electric.plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    if (dict != nil) {
        double remain = [[[dict objectForKey:@"data"] objectForKey:@"remain"] doubleValue];
        if (remain < 100) {
            self.message.text = @"电量不足，赶紧去充值吧!";
        }else{
            self.message.text = @"电量慢慢地，空调随便用!";
        }
        ElectricRoundView *electricRoundView = [[ElectricRoundView alloc] initWithFrame:CGRectMake(100, 65, 120, 120)];
        electricRoundView.remain = remain;
        return electricRoundView;
    }
    return nil;
}





@end
