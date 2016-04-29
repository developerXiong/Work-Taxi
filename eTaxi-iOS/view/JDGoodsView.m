//
//  JDGoodsView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDGoodsView.h"

#import "HeadFile.pch"

#import "JDGoodsCell.h"

@interface JDGoodsView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UILabel *topLabel;

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation JDGoodsView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpAllChildViews];
        
    }
    return self;
}

-(void)setModelArr:(NSMutableArray *)modelArr
{
    _modelArr = modelArr;
    
    [self.collectionView reloadData];
    
}

-(void)setUpAllChildViews
{
    // 顶部的label
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, 30)];
    [self addSubview:topLabel];
    _topLabel = topLabel;
    topLabel.text = @"热门兑换";
    topLabel.font = [UIFont systemFontOfSize:16];
    topLabel.textColor = [UIColor whiteColor];
    topLabel.backgroundColor = COLORWITHRGB(255, 56, 56, 1);
    topLabel.textAlignment = NSTextAlignmentCenter;
    
    // collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((JDScreenSize.width-2)/2, 354/2);// 每个item大小
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical; // 垂直滚动
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 1, 1);
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.minimumLineSpacing = 2;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topLabel.frame), JDScreenSize.width, self.bounds.size.height-30) collectionViewLayout:flowLayout];
    [self addSubview:collectionView];
    _collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = ViewBackgroundColor;
    [collectionView registerClass:[JDGoodsCell class] forCellWithReuseIdentifier:@"cell"];

    
}


#pragma mark - collection view delegate & datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _modelArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JDGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.goodsData = _modelArr[indexPath.row];

    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JDLog(@"%ld",(long)indexPath.row);
    if ([_delegate respondsToSelector:@selector(goodsViewSelectItem:)]) {
        [_delegate goodsViewSelectItem:_modelArr[indexPath.row]];
    }
    
}


@end
