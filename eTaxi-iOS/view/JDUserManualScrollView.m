//
//  JDUserManualScrollView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/5/16.
//  Copyright © 2016年 jeader. All rights reserved.
//  使用说明上的scrollview

#import "JDUserManualScrollView.h"

#import "HeadFile.pch"
#import "JDUserManualViewModel.h"

#import "JDUserManualAlertView.h"

@interface JDUserManualScrollView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIImageView *firstImageV;

@property (nonatomic, weak) UIImageView *secondImageV;

@property (nonatomic, weak) UIImageView *thirdImageV;

@property (nonatomic, weak) UIImageView *fourthImageV;

@property (nonatomic, weak) UIImageView *fiveImageV;

@property (nonatomic, weak) UIButton *tip;

@end

@implementation JDUserManualScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpChildViews];
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(void)setUpChildViews
{
    // 整体的scrollview
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    _scrollView = scrollView;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    
    // 1
    UIImageView *imageV1 = [[UIImageView alloc] init];
    [scrollView addSubview:imageV1];
    _firstImageV = imageV1;
    
    // 2
    UIImageView *imageV2 = [[UIImageView alloc] init];
    [scrollView addSubview:imageV2];
    _secondImageV = imageV2;
    imageV2.userInteractionEnabled = YES;
    
    // 弹窗按钮
    UIButton *tip = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageV2 addSubview:tip];
    _tip = tip;
    [tip addTarget:self action:@selector(clickTip:) forControlEvents:UIControlEventTouchUpInside];
    
    // 3
    UIImageView *imageV3 = [[UIImageView alloc] init];
    [scrollView addSubview:imageV3];
    _thirdImageV = imageV3;
    
    // 4
    UIImageView *imageV4 = [[UIImageView alloc] init];
    [scrollView addSubview:imageV4];
    _fourthImageV = imageV4;
    
    // 5
    UIImageView *imageV5 = [[UIImageView alloc] init];
    [scrollView addSubview:imageV5];
    _fiveImageV = imageV5;

    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _scrollView.frame = self.bounds;
    
}

-(void)setViewModel:(JDUserManualViewModel *)viewModel
{
    _viewModel = viewModel;
    
    JDLog(@"%@",viewModel.imageArr[0]);
    
    // scrollview
    _scrollView.contentSize = CGSizeMake(viewModel.scrollViewW, viewModel.scrollViewH);
    
    // 1
    _firstImageV.frame = viewModel.firstFrame;
    _firstImageV.image = [UIImage imageNamed:viewModel.imageArr[0]];
    
    // 2
    _secondImageV.frame = viewModel.secondFrame;
    _secondImageV.image = [UIImage imageNamed:viewModel.imageArr[1]];
    
    [_tip setFrame:viewModel.tipFrame];
    
    // 3
    _thirdImageV.frame = viewModel.thirdFrame;
    _thirdImageV.image = [UIImage imageNamed:viewModel.imageArr[2]];
    
    // 4
    _fourthImageV.frame = viewModel.fourthFrame;
    _fourthImageV.image = [UIImage imageNamed:viewModel.imageArr[3]];
    
    // 5
    _fiveImageV.frame = viewModel.fiveFrame;
    _fiveImageV.image = [UIImage imageNamed:viewModel.imageArr[4]];
    
}
// 点击特别提醒按钮
-(void)clickTip:(UIButton *)sender
{
    JDLog(@"success");
    
    JDUserManualViewModel *viewModel = [[JDUserManualViewModel alloc] init];
    viewModel.imageName = @"sysm_弹窗";
    
    JDUserManualAlertView *userAlertView = [JDUserManualAlertView userManualAlertView];
    userAlertView.viewModel = viewModel;
    [userAlertView showWithBtn:sender];
}

#pragma mark - scroll view delegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat scrollX = scrollView.contentOffset.x;
//    
//    if (_didScroll) {
//        _didScroll(scrollX);
//    }
//}
//
//-(void)selectIndexDidScroll:(ScrollViewDidScroll)didScroll
//{
//    _didScroll = didScroll;
//}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    [self selectScroll:scrollView];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self selectScroll:scrollView];
    
}

-(void)selectScroll:(UIScrollView *)scrollView
{
    CGFloat scrollX = scrollView.contentOffset.x;
    
    int index = scrollX/JDScreenSize.width;
    
    if (_scroll) {
        _scroll(index);
    }
    
}

-(void)scrollToIndex:(NSInteger)index
{
    NSArray *arrY = @[_firstImageV,_secondImageV,_thirdImageV,_fourthImageV,_fiveImageV];
    
    CGRect rect = [arrY[index] frame];
    
    [_scrollView scrollRectToVisible:rect animated:YES];
}

-(void)selectIndexScroll:(ScrollViewTo)scroll
{
    _scroll = scroll;
}

@end
