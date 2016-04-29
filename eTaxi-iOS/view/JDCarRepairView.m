//
//  JDCarRepairView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/1/20.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDCarRepairView.h"
#import "HeadFile.pch"
#import "JDDatePickerView.h"

//底部选择框的背景色
#define BottomBackgroundColor [UIColor colorWithRed:33/255.0 green:33/255.0 blue:34/255.0 alpha:1.0]

//选择框上的确定取消颜色
#define CancelBackgroundColor [UIColor colorWithRed:44/255.0 green:45/255.0 blue:46/255.0 alpha:1.0]

//维修预约的label的字体大小
#define TextLabelFont [UIFont systemFontOfSize:16]

//维修预约的label的字体颜色
#define TextLabelColor [UIColor colorWithRed:132/255.0 green:133/255.0 blue:134/255.0 alpha:1.0]

#define TopLabelH 30  //顶部的label的高度
#define TopTextFont [UIFont systemFontOfSize:14] //顶部label的文字大小

@interface JDCarRepairView ()

//datepickerView
@property (nonatomic, strong) JDDatePickerView *datePickerView;

@end

@implementation JDCarRepairView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //设置背景颜色
        self.backgroundColor = ViewBackgroundColor;
        
        //设置界面
        [self setUpChildView];
        
        //顶部空白label
        [self addTopViewAndBtnView];
        
    }
    return self;
}

-(void)addTopViewAndBtnView
{
    //顶部空白label
    UILabel *full = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, JDScreenSize.width, TopLabelH)];
    full.text = @"维修项目";
    full.textColor = TextLightColor;
    full.font = [UIFont systemFontOfSize:15];
    
    [self addSubview:full];
    
}

//设置界面
-(void)setUpChildView
{
    //整体的按钮view
    CGFloat viewW = (JDScreenSize.width-2)/3;
    CGFloat btnH = viewW * 0.8;
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, JDScreenSize.width, btnH*3)];
    _mainView = mainView;
    [self addSubview:mainView];
    
    NSArray *imageArr = @[@"更换机油",@"常规检修",@"电路检修",@"变速箱检修",@"电瓶检修",@"发动机修理",@"钣金做漆",@"机械修理",@"胎压"];
    for (int i = 0; i < 9; i ++) {
        UIButton *btn = [self createBtnWithIndex:i imageName:imageArr[i] title:imageArr[i]];
        
        [self.mainView addSubview:btn];
    }
    
    //添加底部的整体视图
    [self addBottomViewWithView:mainView];
}

-(UIButton *)createBtnWithIndex:(int)index imageName:(NSString *)image title:(NSString *)title
{
    
    CGSize imageS = [[UIImage imageNamed:image] size];
    
    CGFloat btnW = (JDScreenSize.width-2)/3;
    CGFloat btnH = btnW * 0.8;
    int colon = index % 3; //列
    int row = index / 3; //行
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _statusBtn = btn;
    btn.tag = index + 1000;
    [btn setBackgroundColor:[UIColor whiteColor]]; //按钮的背景颜色
    btn.highlighted = NO;
    [btn setFrame:CGRectMake(colon * (btnW+1) , row * (btnH+1), btnW, btnH)];
    
    /**
     *  图片到边框的距离
     */
    CGFloat toBoMargin = 5;
//    if (JDScreenSize.width == 320) {
//        toBoMargin = 8;
//    }
//    if (JDScreenSize.width==414&&JDScreenSize.height==736) {
//        toBoMargin = 8;
//    }
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake((btnW - imageS.width)/2, (btnH-imageS.height)/5, imageS.width, imageS.height)];
    imageV.center = CGPointMake(btn.bounds.size.width/2, btn.bounds.size.height/2-toBoMargin);
    imageV.image = [UIImage imageNamed:image];
    [btn addSubview:imageV];
    
    if (index==8) {
        title = @"更多";
    }
    CGFloat labelW = [self getStringWidthWithOriginalString:title WithStringFontOfSize:15];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((btnW-labelW)/2, CGRectGetMaxY(imageV.frame)+2, labelW, 20)];
    label.text = title;
    label.textColor = BLACKCOLOR;
    label.font = [UIFont systemFontOfSize:15];
    [btn addSubview:label];
    
    return btn;
}

//添加底部的整体视图
-(void)addBottomViewWithView:(UIView *)midView
{
    CGFloat bottomX = 0;
    CGFloat bootomY = CGRectGetMaxY(midView.frame);
    CGFloat bottomW = JDScreenSize.width;
    CGFloat bottomH = TopLabelH+30+50+30+50+104;
    //整体的底部的视图
    UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(bottomX, bootomY, bottomW, bottomH)];
    _bottomV = bottomV;
    [self addSubview:bottomV];
    bottomV.backgroundColor = ViewBackgroundColor;
    
    CGFloat timeX = 20;
    CGFloat timeY = 0;
    CGFloat timeW = JDScreenSize.width;
    CGFloat timeH = 30;
    /**维修预约时间的label*/
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(timeX, timeY, timeW, timeH)];
    time.text = @"预约时间";
    time.font = TextLabelFont;
    time.textColor = TextLabelColor;
    [bottomV addSubview:time];
    
    CGFloat tX = 0;
    CGFloat tY = CGRectGetMaxY(time.frame);
    CGFloat tW = timeW;
    CGFloat tH = 50;
    
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
    
    /**维修预约时间的button*/
    UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _timeBtn = timeBtn;
    timeBtn.selected = YES;
    //    timeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [timeBtn setFrame:CGRectMake(tX, tY, tW, tH)];
    [timeBtn setTitle:timeBtnTitle forState:UIControlStateNormal];
    timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //设置字距离边框的距离
    timeBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [timeBtn setBackgroundColor:[UIColor whiteColor]];
    [bottomV addSubview:timeBtn];
    
    CGSize bottoS = [[UIImage imageNamed:@"排列顺序下"] size];
    /**
     *  预约时间下面的向下的图标
     */
    UIImageView *bottoI = [[UIImageView alloc] initWithFrame:CGRectMake(JDScreenSize.width-20-bottoS.width, (tH-bottoS.height)/2, bottoS.width, bottoS.height)];
    bottoI.userInteractionEnabled = NO;
    bottoI.image = [UIImage imageNamed:@"排列顺序下"];
    [timeBtn addSubview:bottoI];
    
    
    CGFloat reX = timeX;
    CGFloat reY = CGRectGetMaxY(timeBtn.frame);
    CGFloat reW = JDScreenSize.width;
    CGFloat reH = timeH;
    /**维修点label*/
    UILabel *reLabel = [[UILabel alloc] initWithFrame:CGRectMake(reX, reY, reW, reH)];
    reLabel.text = @"维修点";
    reLabel.font = TextLabelFont;
    reLabel.textColor = TextLabelColor;
    [bottomV addSubview:reLabel];
    
    CGFloat rbX = 0;
    CGFloat rbY = CGRectGetMaxY(reLabel.frame);
    CGFloat rbW = JDScreenSize.width;
    CGFloat rbH = 50;
    /**维修点button*/
    UIButton *reBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _repairBtn = reBtn;
    [reBtn setFrame:CGRectMake(rbX, rbY, rbW, rbH)];
    [reBtn setTitle:@"请点击选择维修点" forState:UIControlStateNormal];
    //按钮的字向左对齐
    //    [timeBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    reBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //设置字距离边框的距离
    reBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [reBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [reBtn setBackgroundColor:[UIColor whiteColor]];
    [bottomV addSubview:reBtn];
    
    /**
     *  维修点下面的向下的图标
     */
    UIImageView *bottoII = [[UIImageView alloc] initWithFrame:CGRectMake(JDScreenSize.width-20-bottoS.width, (tH-bottoS.height)/2, bottoS.width, bottoS.height)];
    bottoII.userInteractionEnabled = NO;
    bottoII.image = [UIImage imageNamed:@"排列顺序下"];
    [reBtn addSubview:bottoII];
    
    /**上传按钮*/
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitBtn = commitBtn;
    [commitBtn setFrame:CGRectMake(20, CGRectGetMaxY(reBtn.frame) + TopLabelH, JDScreenSize.width - 40, 44)];
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"长按钮正常"] forState:UIControlStateNormal];
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"长按钮高亮"] forState:UIControlStateHighlighted];
    [bottomV addSubview:commitBtn];
    [commitBtn setTitle:@"立刻上传" forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    
}

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

//根据输入的字符串来获取label的宽度
- (NSInteger)getStringWidthWithOriginalString:(NSString *)str WithStringFontOfSize:(CGFloat)size
{
    CGRect rect =[str boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]} context:nil];
    CGFloat width=ceilf(rect.size.width);
    return width;
}

- (NSInteger)getStringHeightWithOriginalString:(NSString *)str WithStringFontOfSize:(CGFloat)size
{
    CGRect rect =[str boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]} context:nil];
    CGFloat height=ceilf(rect.size.height);
    return height;
}


@end
