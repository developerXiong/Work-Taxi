//
//  JDMainView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/19.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMainView.h"
#import "JDMainBar.h"
#import "JDMainBtnView.h"

#define BarHeight 64 // 导航栏的高度

#define BackImage [UIImage imageNamed:@"背景"] // 背景图片

#define BackScale [BackImage size].height/[BackImage size].width // 背景图片的高宽比例

@interface JDMainView ()


@end

@implementation JDMainView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
        [self setUpChildViews];
        
    }
    
    return self;
}

-(void)setUpChildViews
{
    // 下方整体视图
    _mainBtn = [[JDMainBtnView alloc] init];
    [self addSubview:_mainBtn];
    if (JDScreenSize.width==320&&JDScreenSize.height==480) {
        
        _mainBtn.contentSize = CGSizeMake(JDScreenSize.width, JDScreenSize.width*BackScale);
//        _mainBtn.bounces=NO;
        _mainBtn.showsVerticalScrollIndicator = NO;
        
    }
    
    // 导航栏
    _mainBar = [[JDMainBar alloc] init];
    [self addSubview:_mainBar];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _mainBar.frame = CGRectMake(0, 0, JDScreenSize.width, BarHeight);
    
    _mainBtn.frame = CGRectMake(0, BarHeight, JDScreenSize.width, JDScreenSize.height-BarHeight);
    
    _contentH = CGRectGetMaxY(_mainBtn.frame);
}

@end
