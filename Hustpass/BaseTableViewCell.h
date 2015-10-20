//
//  BaseTableViewCell.h
//  Hustpass
//
//  Created by zwenqiang on 15/10/9.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell
@property (nonatomic, retain) UILabel *identifierStr;
@property (nonatomic, retain) UIView *belowStrView;
@property (nonatomic, retain) UIImageView *HeadimageView;
@property (nonatomic, retain) UIView *viewEdge;
@property (nonatomic, retain) UIView *HeadLineImage;

@end
