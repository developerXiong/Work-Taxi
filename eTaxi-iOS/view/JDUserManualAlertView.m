//
//  JDUserManualAlertView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/5/19.
//  Copyright © 2016年 jeader. All rights reserved.
//  使用说明上的弹框

#import "JDUserManualAlertView.h"

#import "HeadFile.pch"
#import "JDUserManualViewModel.h"

@interface JDUserManualAlertView ()

/**
 *  蒙层
 */
@property (nonatomic, weak) UIControl *control;

@property (nonatomic, weak) UIView *mainView;

@property (nonatomic, weak) UIButton *sureBtn;

@property (nonatomic, weak) UIView *line;

@property (nonatomic, weak) UIImageView *imageV;

@end

@implementation JDUserManualAlertView

+(instancetype)userManualAlertView
{
    static id alertView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        alertView = [[self alloc] initWithFrame:CGRectMake(0, 64, JDScreenSize.width, JDScreenSize.height-64)];
        
    });
    
    return alertView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpChildViews];
        
    }
    return self;
}

-(void)setUpChildViews
{
    // 蒙层
    UIControl *control = [[UIControl alloc] init];
    [self addSubview:control];
    _control = control;
    control.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [control addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];

    // 主要界面
    UIView *mainView = [[UIView alloc] init];
    [self addSubview:mainView];
    _mainView = mainView;
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 5.0;
    mainView.layer.masksToBounds = YES;
    
    // 图片
    UIImageView *imageV = [[UIImageView alloc] init];
    [mainView addSubview:imageV];
    _imageV = imageV;
    
    // 按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mainView addSubview:sureBtn];
    _sureBtn = sureBtn;
    [sureBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [sureBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
    
    // 按钮上的线
    UIView *line = [[UIView alloc] init];
    [sureBtn addSubview:line];
    _line = line;
    line.backgroundColor = COLORWITHRGB(216, 216, 216, 1);

}

-(void)setViewModel:(JDUserManualViewModel *)viewModel
{
    _viewModel = viewModel;
    
    _mainView.frame = viewModel.mainFrame;
    
    _imageV.frame = viewModel.imageVFrame;
//    _imageV.image = [UIImage imageNamed:viewModel.imageName];

    _sureBtn.frame = viewModel.btnFrame;
    
    _line.frame = viewModel.lineFrame;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _control.frame = self.bounds;
    

    
}

// 隐藏蒙层
-(void)clickSureBtn
{
    [self hidden];
}

-(void)showWithBtn:(UIButton *)sender
{
    [self makeKeyAndVisible];
    self.hidden = NO;
    
    JDLog(@"%f",sender.frame.origin.y);
    // 将按钮在父视图的frame转换为在self上的frame
    CGRect rect = [self convertRect:sender.frame toView:self];
    //
    rect = CGRectMake(rect.origin.x, rect.origin.y+60+20, rect.size.width, rect.size.height);
    
    _mainView.frame = rect;
    
    JDLog(@"%f",rect.origin.y);
    
    [UIView animateWithDuration:0.3 animations:^{
       
        _mainView.frame = _viewModel.mainFrame;
        
    } completion:^(BOOL finished) {
        
        _imageV.image = [UIImage imageNamed:_viewModel.imageName];
        
    }];
    
    
}
-(void)hidden
{
    [self resignKeyWindow];
    self.hidden = YES;
    
    _imageV.image = [UIImage imageNamed:@""];
}

@end
