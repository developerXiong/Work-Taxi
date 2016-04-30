//
//  JDCallCarAlertView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/23.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDCallCarAlertView.h"
#import "HeadFile.pch"
#import "JDCallCarAlertBottomView.h"

#import "JDCallCarAlertViewFrame.h"
#import "JDCallCarData.h"

#define TextFont [UIFont systemFontOfSize:16]

@interface JDCallCarAlertView ()<JDCallCarAlertBottomViewDelaget>

@property (nonatomic, weak) UIView *totalView;

@property (nonatomic, weak) UILabel *repairDetail;

@property (nonatomic, weak) JDCallCarAlertBottomView *bottomView;

@property (nonatomic, weak) UIControl *mengc;

@end

@implementation JDCallCarAlertView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        [self setUpChildViews];
        self.alpha = 0;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
        self.frame = CGRectMake(0, 64, JDScreenSize.width, JDScreenSize.height-64);
        
    }
    return self;
}

-(void)setUpChildViews
{
    // 蒙层
    UIControl *mengc = [[UIControl alloc] init];
    _mengc = mengc;
    [self addSubview:mengc];
    [mengc addTarget:self action:@selector(clicMengc) forControlEvents:UIControlEventTouchUpInside];
    
    // 整体的View
    UIView *totalView = [[UIView alloc] init];
    [self addSubview:totalView];
    totalView.layer.masksToBounds = YES;
    totalView.layer.cornerRadius = 5.0;
    _totalView = totalView;
    totalView.backgroundColor = COLORWITHRGB(206, 206, 206, 1);
    
    
    // 预约详情
    UILabel *repairDetail = [[UILabel alloc] init];
    [totalView addSubview:repairDetail];
    _repairDetail = repairDetail;
    repairDetail.text = @"预约详情";
    repairDetail.font = TextFont;
    repairDetail.textColor = [UIColor blackColor];
    repairDetail.textAlignment = NSTextAlignmentCenter;
    
    // 其他
    JDCallCarAlertBottomView *bottomView = [[JDCallCarAlertBottomView alloc] init];
    [totalView addSubview:bottomView];
    _bottomView = bottomView;
    _bottomView.delegate = self;
    
    
}

-(void)setAlertViewFrame:(JDCallCarAlertViewFrame *)alertViewFrame
{
    _alertViewFrame = alertViewFrame;
    
    _totalView.frame = alertViewFrame.totalViewFrame;
    
    _bottomView.frame = alertViewFrame.bottomViewFrame;
    
    _bottomView.alertViewFrame = alertViewFrame;

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _mengc.frame = self.bounds;
    
    _repairDetail.frame = CGRectMake(0, 0, 250, 45);
    
    
}

#pragma mark - alert bottom view delegate
-(void)clickAlertViewSureBtn
{
    if ([_delegate respondsToSelector:@selector(clickAlertViewSureBtn:)]) {
        [_delegate clickAlertViewSureBtn:self.alertViewFrame];
    }
}

-(void)clickAlertViewCancelBtn
{
    [self hiddenAnimation:YES];
}

-(void)clicMengc
{
    [self hiddenAnimation:YES];
}

-(void)showInView:(UIView *)view
{
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha ++;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)hiddenAnimation:(BOOL)animation
{
    if (animation) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.alpha --;
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            
        }];
    }else{
        [self removeFromSuperview];
    }
    
    
}


@end
