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
#define TextBtnFont [UIFont systemFontOfSize:13] // 维修预约的Btn的字体大小

#define CommitImage [UIImage imageNamed:@"tijiaoyuyue"] // 提交按钮的图片
#define TimeImage [UIImage imageNamed:@"yuyueshijian"] // 预约时间图片
#define AddressImage [UIImage imageNamed:@"yuyuedidian"] // 预约地点图片

#define CommitHighlightImage [UIImage imageNamed:@"tijiaoyuyuegaoliang"] // 提交按钮高亮图片
#define TimeHighlightImage [UIImage imageNamed:@"yuyueshijiangaoliang"] // 预约时间高亮图片
#define AddressHighlightImage [UIImage imageNamed:@"yuyuedidiangaoliang"] // 预约地点高亮图片

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

#pragma mark - 添加所有子视图
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
    
    // 预约时间的按钮
    UIButton *repairTime = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:repairTime];
    _repairTime = repairTime;
    [repairTime addTarget:self action:@selector(clickRepairTime) forControlEvents:UIControlEventTouchUpInside];
    [repairTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    repairTime.titleLabel.font = TextBtnFont; // 设置选择时间之后的按钮上的字体
    repairTime.titleLabel.textAlignment = NSTextAlignmentCenter;
    repairTime.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 5, 0);
    [repairTime setBackgroundImage:TimeImage forState:UIControlStateNormal];// 设置按钮的正常背景图片
    [repairTime setBackgroundImage:TimeHighlightImage forState:UIControlStateHighlighted]; //设置按钮的高亮背景图片
    
    // 维修点按钮
    UIButton *repairPoint = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:repairPoint];
    _repairPoint = repairPoint;
    [repairPoint addTarget:self action:@selector(clickRepairPoint) forControlEvents:UIControlEventTouchUpInside];
    [repairPoint setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    repairPoint.titleLabel.font = TextBtnFont;
    repairPoint.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 5, 0);
    [repairPoint setBackgroundImage:AddressImage forState:UIControlStateNormal]; //设置正常的背景图片
    [repairPoint setBackgroundImage:AddressHighlightImage forState:UIControlStateHighlighted];// 设置高亮的背景图片
    
    // 立刻上传
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:commitBtn];
    _commitBtn = commitBtn;
    [commitBtn setImage:CommitImage forState:UIControlStateNormal]; //设置正常的背景图片
    [commitBtn setImage:CommitHighlightImage forState:UIControlStateHighlighted];
    [commitBtn addTarget:self action:@selector(clickCommit) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 添加时间选择框
-(void)showChooseTimeViewInView:(UIView *)view ClickSure:(void (^)(NSString *))sure cancel:(void (^)())cancel
{
    // 蒙层
    UIControl *mengc = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [view addSubview:mengc];
    _mengc = mengc;
    mengc.hidden = YES;
    [mengc addTarget:self action:@selector(clickMengc) forControlEvents:UIControlEventTouchUpInside];
    
    // 预约时间选择框
    JDMaintenanceTimeView *timeView = [[JDMaintenanceTimeView alloc] init];
    [view addSubview:timeView];
    _timeView = timeView;
    [timeView ClickCancel:^{ // 点击取消按钮
        
        [self hiddenTimeAndMengc];
        
        if (cancel) {
            cancel();
        }
        
    } Sure:^(NSString *timeStr) {
        
        [self hiddenTimeAndMengc];
        
        if (!timeStr) {
            timeStr = [self currentTimeStr];
        }
        [_repairTime setTitle:timeStr forState:UIControlStateNormal];
        
        sure(timeStr);
    }];
}

#pragma mark - 对时间框和蒙层 隐藏 显示
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

#pragma mark - 设置所有子控件的frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 维修项目label
    CGFloat px = 0, py = 0, pw = JDScreenSize.width-px, ph = TopLabelH;
    _repairPro.frame = CGRectMake(px, py, pw, ph);
    
    // 维修项目按钮视图
    CGFloat bh = LostAndRoadBtnViewH;
    _btnView.frame = CGRectMake(0, CGRectGetMaxY(_repairPro.frame), JDScreenSize.width, bh);
    
    // 预约时间的label
//    _repairTimeLabel.frame = CGRectMake(20, CGRectGetMaxY(_btnView.frame)+30, pw, ph);
    
    // 预约时间的按钮
    [_repairTime setFrame:CGRectMake(14, CGRectGetMaxY(_btnView.frame)+10, JDScreenSize.width-28, [TimeImage size].height)];
    
    
    // 维修点label
//    _repairPointLabel.frame = CGRectMake(20, CGRectGetMaxY(_repairTime.frame)+30, pw, ph);
    
    // 维修点按钮
    [_repairPoint setFrame:CGRectMake(14, CGRectGetMaxY(_repairTime.frame)+10, JDScreenSize.width-28, [AddressImage size].height)];
    
    // 立刻上传
    CGSize commS = [CommitImage size];
    CGFloat cx = (JDScreenSize.width-commS.width)/2, cy = CGRectGetMaxY(_repairPoint.frame)+10,cw = commS.width, ch = commS.height;
    [_commitBtn setFrame:CGRectMake(cx, cy, cw, ch)];
    
    
}

#pragma mark - 点击按钮触发事件
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

#pragma mark - 计算当前时间 2016/05/10 星期几 17:00
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
