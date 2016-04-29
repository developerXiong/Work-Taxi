//
//  JDGoodsCell.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDGoodsCell.h"

#import "JDGoodsData.h"

#import "UIImageView+WebCache.h"

#define Image [UIImage imageNamed:@"积分"]

@interface JDGoodsCell ()

@property (nonatomic, weak) UIImageView *goodsImageView;

@property (nonatomic, weak) UILabel *name;

@property (nonatomic, weak) UIImageView *scoreImageView;

@property (nonatomic, weak) UILabel *score;

@property (nonatomic, weak) UILabel *exchangeCount;

@end

@implementation JDGoodsCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpAllChildViews];
        
    }
    return self;
}

-(void)setUpAllChildViews
{
    // 图片
    UIImageView *goodsImageView = [[UIImageView alloc] init];
    [self addSubview:goodsImageView];
    _goodsImageView = goodsImageView;
    
    // 名字
    UILabel *name = [[UILabel alloc] init];
    [self addSubview:name];
    _name = name;
    name.numberOfLines = 0;
    name.font = [UIFont systemFontOfSize:12];
    
    // 积分前面的图片
    UIImageView *scoreImageView = [[UIImageView alloc] init];
    [self addSubview:scoreImageView];
    _scoreImageView = scoreImageView;
    scoreImageView.image = Image;
    
    // 积分
    UILabel *score = [[UILabel alloc] init];
    [self addSubview:score];
    _score = score;
    score.font = [UIFont systemFontOfSize:15];
    
    // 已兑换
    UILabel *exchangeCount = [[UILabel alloc] init];
    [self addSubview:exchangeCount];
    _exchangeCount = exchangeCount;
    exchangeCount.font = [UIFont systemFontOfSize:12];
    exchangeCount.textColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    // 图片
    CGFloat iwh = 80; // 图片的宽高
    _goodsImageView.frame = CGRectMake((self.bounds.size.width-80)/2, 20, iwh, iwh);
    
    // 名字 12
    CGFloat nx = 10, ny = CGRectGetMaxY(_goodsImageView.frame)+15, nw = self.bounds.size.width-2*nx, nh = 29;
    _name.frame = CGRectMake(nx, ny, nw, nh);
    
    CGSize imageS = [Image size];
    // 积分前面的图片
    CGFloat sx = nx, sy = CGRectGetMaxY(_name.frame)+10, sw = imageS.width, sh = imageS.height;
    _scoreImageView.frame = CGRectMake(sx, sy, sw, sh);
    
    // 积分 15
    _score.frame = CGRectMake(CGRectGetMaxX(_scoreImageView.frame)+5, sy, 76, 18);
    
    // 已兑换 12
    _exchangeCount.frame = CGRectMake(CGRectGetMaxX(_score.frame)+12, sy+3, 84, 15);
    
}

-(void)setGoodsData:(JDGoodsData *)goodsData
{
    _goodsData = goodsData;
    
    // 图片
    [_goodsImageView sd_setImageWithURL:goodsData.imgAddress];
    
    // 名字
    _name.text = goodsData.goodName;
    
    // 积分
    _score.text = [NSString stringWithFormat:@"%@积分",goodsData.cost];;
    
    // 已兑换
    _exchangeCount.text = [NSString stringWithFormat:@"已兑换%@份",goodsData.goodCount];
    
}

@end
