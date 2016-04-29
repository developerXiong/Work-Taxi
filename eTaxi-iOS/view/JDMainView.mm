//
//  JDMainView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/1/9.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMainView.h"
#import "HeadFile.pch"

@interface JDMainView ()<UIScrollViewDelegate>

@end

@implementation JDMainView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 64, JDScreenSize.width, JDScreenSize.height - 64);
        [self setUpSubViews];
        
    }
    return self;
}

-(void)setUpSubViews
{
    //topscrollView
    UIScrollView *topScrollView = [[UIScrollView alloc] init];
    topScrollView.frame = CGRectMake(0, 0, JDScreenSize.width, JDScreenSize.width / 2);
    topScrollView.backgroundColor = [UIColor lightGrayColor];
    topScrollView.pagingEnabled = YES;
    topScrollView.bounces = NO;
    topScrollView.delegate = self;
    _topScrollView = topScrollView;
    
    //pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(JDScreenSize.width - 40 - 40, topScrollView.bounds.size.height - 37 - 20  , 40, 37)];
    [pageControl addTarget:self action:@selector(clickPageControl:) forControlEvents:UIControlEventValueChanged];
    pageControl.pageIndicatorTintColor = [UIColor redColor];
    
    _pageControl = pageControl;
    
    //integrate
    CGFloat margin = 20; //间隔
    CGFloat WH = (JDScreenSize.width - margin * 3) / 2;
    UIButton *integrate = [self btnWithFrame:CGRectMake(margin, CGRectGetMaxY(topScrollView.frame) + margin, WH, WH) backgroundColor:[UIColor redColor] title:@"积分兑换"];
    _integrateChange = integrate;
    
    //维修预约
    UIButton *repair = [self btnWithFrame:CGRectMake(CGRectGetMaxX(integrate.frame) + margin, integrate.frame.origin.y, WH, WH) backgroundColor:[UIColor greenColor] title:@"违章查询"];
    _repair = repair;
    
    //违章查询
    UIButton *breaks = [self btnWithFrame:CGRectMake( margin, CGRectGetMaxY(repair.frame) + margin, JDScreenSize.width - 2 * margin, WH * 2 / 3) backgroundColor:[UIColor redColor] title:@"维修预约"];
    _breakRules = breaks;
    
}

//点击pageControl的时候调用
-(void)clickPageControl:(UIPageControl *)page
{
    [self.topScrollView setContentOffset:CGPointMake(page.currentPage * JDScreenSize.width, 0)];
    
}

//scrollView的代理方法，滚动的时候调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //scrollView的偏移量改变的时候pagecontrol的值跟着改变
    [self.pageControl setCurrentPage:scrollView.contentOffset.x / JDScreenSize.width];
    
}

//创建button
-(UIButton *)btnWithFrame:(CGRect)frame backgroundColor:(UIColor *)color title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setBackgroundColor:color];
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];
    
    return btn;
}

@end
