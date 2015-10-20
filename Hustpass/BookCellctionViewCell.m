//
//  BookCellctionView.m
//  Hustpass
//
//  Created by zwenqiang on 15/10/19.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import "BookCellctionViewCell.h"
#import "RoundView.h"
@interface BookCellctionViewCell ()

@end
@implementation BookCellctionViewCell
@synthesize bookName;

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.bookName = [[UILabel alloc] init];
        self.bookName.frame = CGRectMake(20, 0, 100, 26);
        self.bookName.font = [UIFont systemFontOfSize:15.0f];
        self.bookName.text = @"冰与火之歌";
        self.bookName.textColor = [UIColor blackColor];
        self.bookName.textAlignment = NSTextAlignmentLeft;
        RoundView *round = [[RoundView alloc] initWithFrame:CGRectMake(2, 8, 10, 10)];
        
        [self addSubview:round];
        [self addSubview:self.bookName];
    }
    return  self;
}


@end
