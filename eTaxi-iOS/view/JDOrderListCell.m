//
//  JDOrderListCell.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDOrderListCell.h"
#import "JDOrderListImageView.h"
#import "HeadFile.pch"
#import "JDCallCarListViewModel.h"

#define NowUseCarImage [UIImage imageNamed:@"现在用车_list"]
#define FeaUseCarImage [UIImage imageNamed:@"预约用车_list"]

@interface JDOrderListCell ()



@end

@implementation JDOrderListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        [self setUpAllChildViews];
        
    }
    return self;
}

-(void)setUpAllChildViews
{
    
    // 图片
    _orderImageView = [[JDOrderListImageView alloc] init];
    [self addSubview:_orderImageView];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize imageS = [NowUseCarImage size];
    _orderImageView.frame = CGRectMake((JDScreenSize.width-imageS.width)/2, 12, imageS.width, self.bounds.size.height-12);
}

-(void)setViewModel:(JDCallCarListViewModel *)viewModel
{
    _viewModel = viewModel;
    
    _orderImageView.listViewModel = viewModel;
    
}

@end
