//
//  ElectricDefaultView.m
//  Hustpass
//
//  Created by zwenqiang on 15/10/10.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import "ElectricDefaultView.h"

@implementation ElectricDefaultView
@synthesize sorryMsg,sorryView;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"sorry"];
        self.sorryView = [[UIImageView alloc] initWithImage:image];
        self.sorryView.frame = CGRectMake(95, 0, 130, 170);
        [self addSubview:self.sorryView];
        
        //添加标签
        self.sorryMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 30)];
        self.sorryMsg.text = @"哎呀，怎么啥都没有了，等等再来看吧！";
        self.sorryMsg.textAlignment = NSTextAlignmentCenter;
        self.sorryMsg.font = [UIFont systemFontOfSize:13.0f];
        self.sorryMsg.tintColor = [UIColor colorWithRed:216/255.0f green:216/255.0f blue:216/255.0f alpha:0.74f];
        [self addSubview:self.sorryMsg];
    }
    return self;
}
@end
