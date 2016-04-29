//
//  SetView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/1/23.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "SetView.h"
#import "HeadFile.pch"

@implementation SetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self.frame=CGRectMake(0, JDScreenSize.height, JDScreenSize.width, 300);
        self.backgroundColor=[UIColor whiteColor];
        [self addBtnsAddPicker];
     
        self.pickerVi =[[UIPickerView alloc]init];
        self.pickerVi.showsSelectionIndicator=YES;
        self.pickerVi.delegate=self;
        self.pickerVi.dataSource=self;
        self.pickerVi.frame=CGRectMake(0, 40, JDScreenSize.width, self.frame.size.height-40);
        self.pickerVi.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.pickerVi];
        
        self.str1=@"00";
        self.str2=@"00";
        [self.pickerVi selectRow:12 inComponent:0 animated:NO];
    }
    return self;
}
- (NSMutableArray *)myArr
{
    if (_myArr==nil)
    {
        _myArr=[NSMutableArray array];
        for (int i = 0; i < 24; i++)
        {
            if (i<10)
            {
                NSString * str1 =[NSString stringWithFormat:@"0%d",i];
                [self.myArr addObject:str1];
            }
            else
            {
                NSString * str1 =[NSString stringWithFormat:@"%d",i];
                [self.myArr addObject:str1];
            }
        
        }
    }
    return _myArr;
}
- (void)addBtnsAddPicker
{
    UIButton * cancel =[UIButton buttonWithType:UIButtonTypeSystem];
    cancel.frame=CGRectMake(10, 5, 60, 30);
    [cancel setTitle:@"取 消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(goDown) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel];
    
    UIButton * contain =[UIButton buttonWithType:UIButtonTypeSystem];
    contain.frame=CGRectMake(JDScreenSize.width-70, 5, 60, 30);
    [contain setTitle:@"确 定" forState:UIControlStateNormal];
    [contain setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [contain addTarget:self action:@selector(makeSure) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:contain];

    
}

//取消按钮绑定方法
- (void)goDown
{
    if ([_delegate respondsToSelector:@selector(cancelBtnClick)])
    {
        [_delegate cancelBtnClick];
    }
}
//确定按钮绑定方法
- (void)makeSure
{
    if ([_delegate respondsToSelector:@selector(containBtnClick)])
    {
        [_delegate containBtnClick];
    }
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0)
    {
        return 24;
    }
    else if (component==1)
    {
        return 1;
    }
    else
    {
        return 2;
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray * arr =[NSArray arrayWithObjects:@"00",@"30", nil];
    if (component==0)
    {
        NSString *strDateWeek = [self.myArr objectAtIndex:row];
        
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:strDateWeek];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, strDateWeek.length)];
        return attrString;
    }
    else if (component==1)
    {
        NSString *strDateWeek =@":";
        
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:strDateWeek];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, strDateWeek.length)];
        return attrString;
    }
    else
    {
        NSString *strDateWeek =arr[row];
        
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:strDateWeek];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, strDateWeek.length)];
        return attrString;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSArray * arr =[NSArray arrayWithObjects:@"00",@"30", nil];
    
    if (component==0)
    {
        self.str1=self.myArr[row];
    }
    else
    {
        self.str2=arr[row];
    }
    if ([_delegate respondsToSelector:@selector(datePickerValueChange:)])
    {
        NSString * timeStr =[NSString stringWithFormat:@"%@:%@",self.str1,self.str2];
        NSString * clearStr =[timeStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        [_delegate datePickerValueChange:clearStr];
    }
    else
    {
        NSString * timeStr =@"12:00";
        [_delegate datePickerValueChange:timeStr];
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 100;
}



@end
