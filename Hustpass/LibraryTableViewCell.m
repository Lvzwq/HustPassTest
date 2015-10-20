//
//  LibraryTableViewCell.m
//  Hustpass
//
//  Created by zwenqiang on 15/10/19.
//  Copyright © 2015年 zwenqiang. All rights reserved.
//

#import "LibraryTableViewCell.h"
#import "BookCellctionViewCell.h"

@interface LibraryTableViewCell()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation LibraryTableViewCell
@synthesize bookView;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
        
        self.identifierStr.text = @"热门图书";
        [self.identifierStr setFont:[UIFont systemFontOfSize:16.0f]];
        self.identifierStr.textAlignment = NSTextAlignmentCenter;
        self.identifierStr.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.identifierStr];
        
        //在文字标示下面的线条
        self.belowStrView = [[UIView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(self.identifierStr.frame), 60, 3)];
        
        self.belowStrView.backgroundColor = [UIColor greenColor];
        [self addSubview:self.belowStrView];
        
        
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //头部
        flowLayout.headerReferenceSize = CGSizeMake(240, 0);
        self.bookView = [[UICollectionView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.belowStrView.frame) + 10, 240, 140) collectionViewLayout:flowLayout];
        self.bookView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bookView];
        
        self.bookView.delegate = self;
        self.bookView.dataSource = self;
        
        //注册cell和ReusableView（相当于头部）
        [self.bookView registerClass:[BookCellctionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        [self.bookView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    }
    return self;
}

#pragma mark - UICollectionView Datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"Cell";
    BookCellctionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    
    [cell sizeToFit];
    if (cell == nil) {
        NSLog(@"进入中.....");
        cell = [[BookCellctionViewCell alloc] initWithFrame:CGRectMake(0, 0, 115, 26)];
    }
    cell.bookName.text = @"滑鬼头之孙";
    return cell;
}

#pragma mark – UICollectionViewDelegateFlowLayout
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(115, 26);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择%ld",(long)indexPath.row);
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
