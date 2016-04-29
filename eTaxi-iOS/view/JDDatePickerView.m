//
//  JDDatePickerView.m
//  DatePickerView
//
//  Created by jeader on 16/1/21.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDDatePickerView.h"
#import "HeadFile.pch"

@interface JDDatePickerView ()

//月日周
@property (nonatomic, strong) NSMutableArray *dateArr;

//小时
@property (nonatomic, strong) NSMutableArray *hourArr;

@property (nonatomic, strong) NSMutableArray *secondHourArr;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, assign) NSInteger currentRow;

@property (nonatomic, assign) NSInteger nextRow;

@end

@interface JDDatePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@end

@implementation JDDatePickerView

-(NSMutableArray *)dateArr
{
    if (_dateArr == nil) {
        _dateArr = [NSMutableArray array];
    }
    return _dateArr;
}

-(NSMutableArray *)secondHourArr
{
    if (_secondHourArr == nil) {
        _secondHourArr = [NSMutableArray array];
    }
    return _secondHourArr;
}

-(NSMutableArray *)hourArr
{
    if (!_hourArr) {
        _hourArr = [NSMutableArray array];
    }
    return _hourArr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        //添加月日周到数组
        [self addNumber];
        
        //设置子控件
        [self setUpSubviews];
        
    }
    return self;
}

//设置子控件
-(void)setUpSubviews
{
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    [self addSubview:pickerView];
    _pickerView = pickerView;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    
    //选中当前日期
    [pickerView selectRow:0 inComponent:0 animated:NO];
    
    [pickerView selectRow:0 inComponent:1 animated:YES];
    
    //
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH";
    
    NSInteger dateRow = [[formatter stringFromDate:[NSDate date]] integerValue];
    
    self.currentRow = [pickerView selectedRowInComponent:1] + dateRow + 1;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _pickerView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

//添加月日周到数组
-(void)addNumber
{
        
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //年份
    [formatter setDateFormat:@"YYYY"];
    NSString *yearStr = [formatter stringFromDate:date];
    
    //月
    [formatter setDateFormat:@"MM"];
    NSString *monthStr = [formatter stringFromDate:date];
    int month = [monthStr intValue];
    
    //日
    [formatter setDateFormat:@"dd"];
    NSString *dayStr = [formatter stringFromDate:date];
    int day = [dayStr intValue];
    
    [formatter setDateFormat:@"YYYY/MM/dd"];
    NSDate *inputDate = [formatter dateFromString:[NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr]];
    
    NSString *weekStr = [self weekdayStringFromDate:inputDate];

    /**当前时间*/
    NSString *currentDate = @"";
    if (month < 10 && day >= 10) {
        currentDate = [NSString stringWithFormat:@"0%d/%d %@",month,day,weekStr];
    }else if(month < 10 && day < 10){
        currentDate = [NSString stringWithFormat:@"0%d/0%d %@",month,day,weekStr];
    }else if (month > 10 && day > 10){
        currentDate = [NSString stringWithFormat:@"%d/%d %@",month,day,weekStr];
    }else{
        currentDate = [NSString stringWithFormat:@"%d/0%d %@",month,day,weekStr];
    }
    
//    day += 1;
    
    if ((([yearStr intValue]%4==0)&&([yearStr intValue]%100!=0))||([yearStr intValue]%400==0)) { //闰年
        
        if (month == 2 && day == 29) {
            
            month = 3;
            day = 0;
            
        }
        
    }else{ //平年
        
        if (month == 2 && day == 28) {
            
            month = 3;
            day = 0;
            
        }
        
    }
    
    if (month==1||month==3||month==5||month==7||month==8||month==10||month==12) {
        
        if (day == 31) {
            day = 0;
            month += 1;
        }
        
    }else if(month != 2){
        
        if (day == 30) {
            day = 0;
            month += 1;
        }
        
    }
    
//    NSLog(@"%d----%d",month,day+1);
    
    inputDate = [formatter dateFromString:[NSString stringWithFormat:@"%@-%d-%d",yearStr,month,day+1]];
    weekStr = [self weekdayStringFromDate:inputDate];
    
    /**下一个格子的时间*/
    NSString *nextDate = @"";
    if (month < 10 && day+1 >= 10) {
        nextDate = [NSString stringWithFormat:@"0%d/%d %@",month,day+1,weekStr];
    }else if(month < 10 && day+1 < 10){
        nextDate = [NSString stringWithFormat:@"0%d/0%d %@",month,day+1,weekStr];
    }else if (month > 10 && day+1 > 10){
        nextDate = [NSString stringWithFormat:@"%d/%d %@",month,day+1,weekStr];
    }else{
        nextDate = [NSString stringWithFormat:@"%d/0%d %@",month,day+1,weekStr];
    }
    
    [self.dateArr addObject:currentDate];
    [self.dateArr addObject:nextDate];
  
    [formatter setDateFormat:@"HH"];
    NSString *currentHour = [formatter stringFromDate:date];
    int currentH = [currentHour intValue];
//    NSLog(@"%d",currentH);
    
    for (int i = currentH+1; i < 24; i ++) {
        
        if (i < 10) {
            
            currentHour = [NSString stringWithFormat:@"0%d:00",i];
            
        }else{
            
            currentHour = [NSString stringWithFormat:@"%d:00",i];
            
        }
        
        [self.hourArr addObject:currentHour];
        
    }

}

//根据日期获得是周几
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate
{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//NSGregorianCalendar
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;//NSWeekdayCalendarUnit
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

#pragma mark - pickerView delegate & datesource
//栏目数量
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

//每一栏的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
            
            return self.dateArr.count;
            
            break;
        case 1:
            
            return self.hourArr.count;
            
            break;
        default:
            break;
            
    }
        
    return 10;
}

//修改行高
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}

//修改栏目的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
        
    switch (component) {
        case 0:
            
            return [UIScreen mainScreen].bounds.size.width * 2 / 3;
            
            break;
        case 1:
            
            return [UIScreen mainScreen].bounds.size.width / 3;
            
            break;
        default:
            break;
    }
        
       return 10;
}

//选中某一栏之后调用
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
//    NSLog(@"----->%lu",(long)[pickerView selectedRowInComponent:1]);
    
    if (row == 1&& component==0) {
        
        
        [self.hourArr removeAllObjects];
        
        for (int i = 0; i < 24; i ++) {
            
            NSString *hourStr = @"";
            if (i < 10) {
    
                hourStr = [NSString stringWithFormat:@"0%d:00",i];
    
            }else{
    
                hourStr = [NSString stringWithFormat:@"%d:00",i];
                
            }
            
            [self.hourArr addObject:hourStr];
            
            [pickerView reloadComponent:1];
        }
        
        [pickerView reloadComponent:1];
        
        [pickerView selectRow:self.currentRow inComponent:1 animated:NO];
        
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        formatter1.dateFormat = @"HH";
        
        NSInteger dateRow2 = [[formatter1 stringFromDate:[NSDate date]] integerValue];
        
        self.nextRow = [pickerView selectedRowInComponent:1]-dateRow2-2;
        
        
    }else if (row == 0 && component==0){
        
        [self.dateArr removeAllObjects];
        [self.hourArr removeAllObjects];
        
        [self addNumber];
        
        [pickerView reloadComponent:1];
        
        if (self.hourArr.count >= self.nextRow) {
            
            [pickerView selectRow:self.nextRow+1 inComponent:1 animated:NO];
            
        }else{
            [pickerView selectRow:0 inComponent:1 animated:NO];
        }
        
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        formatter1.dateFormat = @"HH";
        
        NSInteger dateRow1 = [[formatter1 stringFromDate:[NSDate date]] integerValue];
        
        self.currentRow = [pickerView selectedRowInComponent:1] + dateRow1 + 1;
        
    }
    
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"HH";
    
    NSInteger dateRow2 = [[formatter1 stringFromDate:[NSDate date]] integerValue];
    
    self.nextRow = [pickerView selectedRowInComponent:1]-dateRow2-2;
    
    NSInteger dateRow1 = [[formatter1 stringFromDate:[NSDate date]] integerValue];
    
    self.currentRow = [pickerView selectedRowInComponent:1] + dateRow1 + 1;

    
//    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
//    formatter1.dateFormat = @"HH";
//    
//    NSInteger dateRow1 = [[formatter1 stringFromDate:[NSDate date]] integerValue];
//    
//    self.nextRow = [pickerView selectedRowInComponent:1]-dateRow1-1;
    
//    NSLog(@"current--->%lu next---->%lu",(long)self.currentRow,(long)self.nextRow);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY"];
    NSString *yearStr = [NSString stringWithFormat:@"%@/",[formatter stringFromDate:[NSDate date]]];
    
    NSInteger dateRow = [pickerView selectedRowInComponent:0];
    NSInteger halfRow = [pickerView selectedRowInComponent:1];
    

    NSString *str4 = self.hourArr[halfRow];

    self.selectTimeStr = (NSMutableString *)[yearStr stringByAppendingString:[NSString stringWithFormat:@"%@  %@",self.dateArr[dateRow],str4]];
    
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *dateLabel = (UILabel *)view;
    
    if (!dateLabel) {
        dateLabel = [[UILabel alloc] init];
        _dateLabel = dateLabel;
        dateLabel.textAlignment = NSTextAlignmentLeft;
        dateLabel.tag = 1000;
        [dateLabel setFont:[UIFont systemFontOfSize:21]];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [dateLabel setTextColor:BLACKCOLOR];
        
    }
    
    switch (component) {
        case 0:
            
            dateLabel.text = [NSString stringWithFormat:@"      %@",self.dateArr[row]];
            
            break;
        case 1:
            dateLabel.tag = 1001;
            
            dateLabel.text = self.hourArr[row];
            
            break;
            
        default:
            break;
    }
    
    return dateLabel;
    
}

@end
