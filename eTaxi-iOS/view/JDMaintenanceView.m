//
//  JDMaintenanceView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMaintenanceView.h"

#import "JDMaintenanceBtnView.h"

#import "HeadFile.pch"

#import "JDMaintenanceTimeView.h"
#import "JDMaintenanceButton.h"

#define TopLabelH 30  // 顶部的label的高度
#define TextLabelFont [UIFont systemFontOfSize:14] // 维修预约的label的字体大小
#define ToBoImage [UIImage imageNamed:@"排列顺序下"] // 向下的图标

@interface JDMaintenanceView ()

/**
 *  维修项目label
 */
@property (nonatomic, weak) UILabel *repairPro;
/**
 *  维修项目按钮视图
 */
@property (nonatomic, weak) JDMaintenanceBtnView *btnView;
/**
 *  预约时间label
 */
@property (nonatomic, weak) UILabel *repairTimeLabel;
/**
 *  预约时间的按钮
 */
@property (nonatomic, weak) UIButton *repairTime;
/**
 *  维修点label
 */
@property (nonatomic, weak) UILabel *repairPointLabel;
/**
 *  立刻上传
 */
@property (nonatomic, weak) UIButton *commitBtn;
/**
 *  预约时间的选择框
 */
@property (nonatomic, weak) JDMaintenanceTimeView *timeView;
/**
 *  蒙层
 */
@property (nonatomic, weak) UIControl *mengc;

@end

@implementation JDMaintenanceView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        [self setUpAllChildViews];
        
        //设置背景颜色
//        self.backgroundColor = ViewBackgroundColor;
        
        self.frame = CGRectMake(0, 64, JDScreenSize.width, JDScreenSize.height-64);
        
    }
    return self;
}

-(void)setUpAllChildViews
{
    
    // 维修项目label
    UILabel *repairPro = [[UILabel alloc] init];
    [self addSubview:repairPro];
    _repairPro = repairPro;
    repairPro.text = @"请选择维修项目";
    repairPro.textColor = [UIColor whiteColor];
    repairPro.font = TextLabelFont;
    repairPro.textAlignment = NSTextAlignmentCenter;
    
    // 维修项目按钮视图
    JDMaintenanceBtnView *btnView = [[JDMaintenanceBtnView alloc] init];
    [self addSubview:btnView];
    _btnView = btnView;
    [btnView clickRepairPro:^(UIButton *sender) {
        if ([_delegate_main respondsToSelector:@selector(maintenanceClickRepairPro:)]) {
            [_delegate_main maintenanceClickRepairPro:sender];
        }
    }];
    
    // 预约时间label
    UILabel *repairTimeLabel = [[UILabel alloc] init];
    [self addSubview:repairTimeLabel];
    _repairTimeLabel = repairTimeLabel;
    repairTimeLabel.text = @"预约时间";
    repairTimeLabel.textColor = [UIColor whiteColor];
    repairTimeLabel.font = TextLabelFont;
    
    // 预约时间的按钮
    UIButton *repairTime = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:repairTime];
    _repairTime = repairTime;
    [repairTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [repairTime addTarget:self action:@selector(clickRepairTime) forControlEvents:UIControlEventTouchUpInside];
    [repairTime setTitle:@"请选择" forState:UIControlStateNormal];
    repairTime.titleLabel.font = TextLabelFont;
    
    // 维修点label
    UILabel *repairPointLabel = [[UILabel alloc] init];
    [self addSubview:repairPointLabel];
    _repairPointLabel = repairPointLabel;
    repairPointLabel.text = @"预约地点";
    repairPointLabel.textColor = [UIColor whiteColor];
    repairPointLabel.font = TextLabelFont;
    
    // 维修点按钮
    UIButton *repairPoint = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:repairPoint];
    _repairPoint = repairPoint;
    [repairPoint setTitle:@"请选择" forState:UIControlStateNormal];
    [repairPoint setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [repairPoint addTarget:self action:@selector(clickRepairPoint) forControlEvents:UIControlEventTouchUpInside];
    repairPoint.titleLabel.font = TextLabelFont;
    
    // 立刻上传
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:commitBtn];
    _commitBtn = commitBtn;
    [commitBtn setBackgroundColor:COLORWITHRGB(0, 155, 255, 1)];
    [commitBtn setTitle:@"确  定" forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [commitBtn addTarget:self action:@selector(clickCommit) forControlEvents:UIControlEventTouchUpInside];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    commitBtn.layer.cornerRadius = 5.0;
    commitBtn.layer.masksToBounds = YES;
    
    // 蒙层
    UIControl *mengc = [[UIControl alloc] init];
    [self addSubview:mengc];
    _mengc = mengc;
    mengc.hidden = YES;
    [mengc addTarget:self action:@selector(clickMengc) forControlEvents:UIControlEventTouchUpInside];
    
    // 预约时间选择框
    JDMaintenanceTimeView *timeView = [[JDMaintenanceTimeView alloc] init];
    [self addSubview:timeView];
    _timeView = timeView;
    [timeView ClickCancel:^{ // 点击取消按钮
        
        [self hiddenTimeAndMengc];
        
        if ([_delegate_main respondsToSelector:@selector(maintenanceClickTimeViewCancel)]) {
            [_delegate_main maintenanceClickTimeViewCancel];
        }
        
    } Sure:^(NSString *timeStr) {
        
        [self hiddenTimeAndMengc];
        
        if (!timeStr) {
            timeStr = [self currentTimeStr];
        }
        [_repairTime setTitle:timeStr forState:UIControlStateNormal];
        
        if ([_delegate_main respondsToSelector:@selector(maintenanceClickTimeViewSure:)]) {
            [_delegate_main maintenanceClickTimeViewSure:timeStr];
        }
    }];
    
}

-(void)hiddenTimeAndMengc
{
    [_timeView hidden];
    [self hiddenMengc];
}


-(void)showMengc
{
    _mengc.hidden = NO;
}

-(void)hiddenMengc
{
    _mengc.hidden = YES;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 维修项目label
    CGFloat px = 0, py = 0, pw = JDScreenSize.width-px, ph = TopLabelH;
    _repairPro.frame = CGRectMake(px, py, pw, ph);
    
    // 维修项目按钮视图
    CGFloat bh = (JDScreenSize.width-2)/3 * 0.8 * 3;
    _btnView.frame = CGRectMake(0, CGRectGetMaxY(_repairPro.frame), JDScreenSize.width, bh);
    
    // 预约时间的label
    _repairTimeLabel.frame = CGRectMake(20, CGRectGetMaxY(_btnView.frame)+30, pw, ph);
    
    // 预约时间的按钮
    [_repairTime setFrame:CGRectMake(0, CGRectGetMaxY(_btnView.frame)+30, JDScreenSize.width, ph)];
    
    
    // 维修点label
    _repairPointLabel.frame = CGRectMake(20, CGRectGetMaxY(_repairTime.frame)+30, pw, ph);
    
    // 维修点按钮
    [_repairPoint setFrame:CGRectMake(0, CGRectGetMaxY(_repairTime.frame)+30, JDScreenSize.width, ph)];
    
    // 立刻上传
    [_commitBtn setFrame:CGRectMake((JDScreenSize.width-150)/2, CGRectGetMaxY(_repairPoint.frame)+TopLabelH, 150, 30)];
    
    _mengc.frame = self.bounds;
    
    
}

// 点击预约时间
-(void)clickRepairTime
{
    if ([_delegate_main respondsToSelector:@selector(maintenanceClickRepairTime)]) {
        [_delegate_main maintenanceClickRepairTime];
    }
//    [self showTimeView];
    [_timeView show];
    [self showMengc];
}

// 点击维修点
-(void)clickRepairPoint
{
    if ([_delegate_main respondsToSelector:@selector(maintenanceClickRepairPoint)]) {
        [_delegate_main maintenanceClickRepairPoint];
    }
}

// 点击提交
-(void)clickCommit
{
    if ([_delegate_main respondsToSelector:@selector(maintenanceClickRepairCommit)]) {
        [_delegate_main maintenanceClickRepairCommit];
    }
}

// 点击蒙层
-(void)clickMengc
{
    [self hiddenTimeAndMengc];
}

-(NSString *)currentTimeStr
{
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSArray *weekdays1 = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    NSString *week = [self getCurrentWeek];
    
    for (int i = 0; i < 7; i ++) {
        
        if ([week isEqualToString:weekdays1[i]]) {
            
            week = weekdays[i];
            
        }
        
    }
    //年份
    [formatter setDateFormat:@"YYYY"];
    NSString *yearStr = [formatter stringFromDate:date];
    //月份
    [formatter setDateFormat:@"MM"];
    NSString *monthStr = [formatter stringFromDate:date];
    //day
    [formatter setDateFormat:@"dd"];
    NSString *dayStr = [formatter stringFromDate:date];
    
    //选中当前小时
    [formatter setDateFormat:@"HH"];
    NSString *hourStr = [formatter stringFromDate:date];
    NSInteger timeRow = [hourStr integerValue];
    
    hourStr = [NSString stringWithFormat:@"%ld:00",(long)timeRow+1];
    
    NSString *timeBtnTitle = [NSString stringWithFormat:@"%@/%@/%@ %@  %@",yearStr,monthStr,dayStr,week,hourStr];
    
    return timeBtnTitle;
}
// 获取当前是周几
-(NSString *)getCurrentWeek
{
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//NSGregorianCalendar
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;//NSWeekdayCalendarUnit
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:[NSDate date]];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}

@end
