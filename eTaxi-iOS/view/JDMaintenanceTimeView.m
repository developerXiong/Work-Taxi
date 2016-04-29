//
//  JDMaintenanceTimeView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/27.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMaintenanceTimeView.h"

#import "HeadFile.pch"

#import "JDDatePickerView.h"

#define TimeViewH 216

@interface JDMaintenanceTimeView ()
/**
 *  确定取消按钮的视图
 */
@property (nonatomic, weak) UIView *btnView;

@property (nonatomic, weak) UILabel *line;
/**
 *  取消按钮
 */
@property (nonatomic, weak) UIButton *canBtn;
/**
 *  确定按钮
 */
@property (nonatomic, weak) UIButton *sureBtn;
/**
 *  自定义datepicker
 */
@property (nonatomic, weak) JDDatePickerView *datePicker;

@end

@implementation JDMaintenanceTimeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat proCX = 0;
        CGFloat proCY = JDScreenSize.height-64;
        CGFloat proCW = JDScreenSize.width;
        CGFloat proCH = TimeViewH;
        self.frame = CGRectMake(proCX, proCY, proCW, proCH);
        self.backgroundColor = [UIColor whiteColor];
        [self setUpAllChildViews];
        self.hidden = YES;
        
    }
    return self;
}

-(void)setUpAllChildViews
{
    
    //确定取消按钮的视图
    UIView *btnView = [[UIView alloc] init];
    [self addSubview:btnView];
    _btnView = btnView;
    
    /**确定取消按钮的下方的线条*/
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [btnView addSubview:line];
    _line = line;
    
    //取消按钮
    UIButton *canBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [canBtn setTitle:@"取消" forState:UIControlStateNormal];
    [canBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    canBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft; //文字向左对齐
    canBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0); //距离左边的间距
    [canBtn addTarget:self action:@selector(clickTimeCancel) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:canBtn];
    _canBtn = canBtn;
    
    //确定按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight; //文字向左对齐
    sureBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20); //距离左边的间距
    [sureBtn addTarget:self action:@selector(clickTimeSure) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:sureBtn];
    _sureBtn = sureBtn;
    
    //自定义datepicker
    JDDatePickerView *datePicker = [[JDDatePickerView alloc] init];
    [self addSubview:datePicker];
    _datePicker = datePicker;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width, height = self.bounds.size.height;
    CGFloat rowH = 50; //按钮的高度
    
    JDLog(@"succccccc%f---%f",width,height);
    
    _btnView.frame = CGRectMake(0, 0, width, rowH);
    
    _line.frame = CGRectMake(0, rowH - 0.5, width, 0.5);
    
    [_canBtn setFrame:CGRectMake(0, 0, 100, rowH)];
    
    [_sureBtn setFrame:CGRectMake(width - 100, 0, 100, rowH)];
    
    _datePicker.frame = CGRectMake(0, rowH, width, height - rowH);
    
}

-(void)show
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.hidden = NO;
        self.transform = CGAffineTransformMakeTranslation(0, -TimeViewH);
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}

-(void)hidden
{
    [UIView animateWithDuration:0.3 animations:^{

        self.transform = CGAffineTransformIdentity;

    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

// 点击取消
-(void)clickTimeCancel{
    
    if (_cancel) {
        _cancel();
    }
    
}
// 点击确定
-(void)clickTimeSure{
    
    if (_sure) {
        _sure(_datePicker.selectTimeStr);
    }
    
}

-(void)ClickCancel:(Cancel)cancel Sure:(Sure)sure
{
    if (cancel) {
        _cancel = cancel;
    }
    
    if (sure) {
        _sure = sure;
    }
}

@end
