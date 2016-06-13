//
//  JDUserManualView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/5/16.
//  Copyright © 2016年 jeader. All rights reserved.
//  使用说明的主界面

#import "JDUserManualView.h"

#import "HeadFile.pch"
#import "JDUserManualButton.h"
#import "JDUserManualBtnView.h"
#import "JDUserManualScrollView.h"
#import "JDUserManualViewModel.h"
#import "CYPageControl.h"
#import "UIView+UIView_CYChangeFrame.h"

@interface JDUserManualView ()

@property (nonatomic, strong) JDUserManualBtnView *btnView;

@property (nonatomic, strong) JDUserManualScrollView *scrollView;

@property (nonatomic, weak) CYPageControl *pageControl;

@end

@implementation JDUserManualView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, 64, JDScreenSize.width, JDScreenSize.height-64);
        
        [self setUpChildViews];
        
        
    }
    return self;
}

-(void)setUpChildViews
{
    // 五个按钮视图
    JDUserManualBtnView *btnView = [[JDUserManualBtnView alloc] init];
    _btnView = btnView;
    [self addSubview:btnView];
    btnView.btnArr = (NSMutableArray *)@[@"sysm_预约维修",@"sysm_召车",@"sysm_违章",@"sysm_路况",@"sysm_失物"];
    btnView.highlightBtnArr = (NSMutableArray *)@[@"sysm_预约维修高亮",@"sysm_召车高亮",@"sysm_违章高亮",@"sysm_路况高亮",@"sysm_失物高亮"];
    btnView.currentIndex = 0;
    
    
    // scrollview
    JDUserManualScrollView *scrollView = [[JDUserManualScrollView alloc] init];
    _scrollView = scrollView;
    [self addSubview:scrollView];
    
    // page control
    CYPageControl *pageControl = [[CYPageControl alloc] initWithFrame:CGRectMake((self.bounds.size.width-80)/2, self.bounds.size.height-20-20, 100, 40)];
    _pageControl = pageControl;
    pageControl.numberOfPages = 5;
    pageControl.currentCount = 0;
    [self addSubview:pageControl];
    
    // 视图模型
    JDUserManualViewModel *viewModel = [[JDUserManualViewModel alloc] init];
    viewModel.imageArr = @[@"new1_预约维修",@"new1_召车接单",@"new1_违章查询",@"new1_路况申报",@"new1_失物招领"];
    scrollView.viewModel = viewModel;
    
    // btnView按钮的点击方法
    [btnView userManualClickBtn:^(NSInteger index) {
        
        [scrollView scrollToIndex:index];
        pageControl.currentCount = index;
        
    }];
    // scrollView滚动的时候调用
    [scrollView selectIndexScroll:^(NSInteger scrollY) {
        
        [btnView selectBtnIndex:scrollY];
        pageControl.currentCount = scrollY;
        
    }];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _scrollView.frame = CGRectMake(0, CGRectGetMaxY(_btnView.frame), JDScreenSize.width, JDScreenSize.height-CGRectGetMaxY(_btnView.frame));
    
//    _pageControl.frame = CGRectMake((self.bounds.size.width-80)/2, self.bounds.size.height-30-20, 80, 30);
}


@end
