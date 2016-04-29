//
//  SetVC.m
//  E+TAXI
//
//  Created by jeader on 15/12/29.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import "SetVC.h"
#import "MyData.h"
#import "SetView.h"
#import "HeadFile.pch"
#import "MBProgressHUD.h"
#import "SetKMViewController.h"
#import "GetData.h"
#import "PersonalVC.h"

@interface SetVC ()<SetViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) SetView * myView;

@property (nonatomic, strong) NSString * statusIn;
@property (nonatomic, strong) NSString * statusBr;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) MBProgressHUD * hud;

@property (nonatomic, strong) NSString * dateStr;

@end

@implementation SetVC
- (void)viewWillAppear:(BOOL)animated
{
    [self.tableVi reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myView=[[SetView alloc]init];
    self.myView.delegate=self;
    [self.view addSubview:self.myView];
    
    self.hud=[[MBProgressHUD alloc]init];
    [self.view addSubview:self.hud];
    self.tableVi.scrollEnabled=NO;
    
    
}

#pragma mark- UITable View DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) return 2;
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID =@"cellID";
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    switch (indexPath.section)
    {
        case 0:
        {
            if (!cell)
            {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                if (indexPath.row==0)
                {
                    cell.textLabel.text=@"通知开关";
                    cell.textLabel.textColor=[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];
                    //添加开关控件
                    UISwitch * swi1 =[[UISwitch alloc]initWithFrame:CGRectMake(JDScreenSize.width-60, 10, 51, 31)];
                    swi1.onTintColor=[UIColor colorWithRed:72/255.0 green:123/255.0  blue:184/255.0  alpha:1.0];
                    swi1.on=[[NSUserDefaults standardUserDefaults]boolForKey:@"inState"];
                    swi1.tag=111;
                    [swi1 addTarget:self action:@selector(inSwi:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:swi1];
                    
                }
                else
                {
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                    cell.textLabel.text=@"每日发送时间";
                    cell.textLabel.textColor=[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];
                    //添加时间显示标签
                    UILabel*timeLab =[[UILabel alloc]initWithFrame:CGRectMake(JDScreenSize.width-90, 5, 60, 31)];
                    timeLab.textAlignment=NSTextAlignmentRight;
                    timeLab.textColor=[UIColor colorWithRed:107/255.0 green:107/255.0  blue:107/255.0  alpha:1.0];
                    _label=timeLab;
                    timeLab.text=@"12:00";
                    NSString * time =[[NSUserDefaults standardUserDefaults]objectForKey:@"choice"];
                    NSString * timeStr =[NSString stringWithFormat:@"%@",time];
                    if (time)
                    {
                        self.label.text=timeStr;
                    }
                    
                    
                    [cell.contentView addSubview:timeLab];
                    
                }
            }
        }
            break;
        case 1:
        {
            if (!cell)
            {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                //添加控件开关
                UISwitch * swi2 =[[UISwitch alloc]initWithFrame:CGRectMake(JDScreenSize.width-60, 10, 51, 31)];
                swi2.onTintColor=[UIColor colorWithRed:72/255.0 green:123/255.0  blue:184/255.0  alpha:1.0];
                swi2.on=[[NSUserDefaults standardUserDefaults]boolForKey:@"brState"];
                swi2.tag=222;
                [swi2 addTarget:self action:@selector(breakSwi:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:swi2];
            }
            cell.textLabel.text=@"通知开关";
            cell.textLabel.textColor=[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 29;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) return @"营收统计";
    else if (section==1) return @"违章";
    return @"";
}
#pragma mark- UITable View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==1)
        {
            [UIView animateWithDuration:.3 animations:^
             {
                 self.myView.frame=CGRectMake(0, JDScreenSize.height-300, JDScreenSize.width, 300);
             }];
        }
    }
}
//取消按钮点击
- (void)cancelBtnClick
{
    [UIView animateWithDuration:.3 animations:^{
        self.myView.frame=CGRectMake(0, JDScreenSize.height, JDScreenSize.width, 300);
    }];
}
//确定按钮点击
- (void)containBtnClick
{
    NSLog(@"%@",self.dateStr);
    if (self.dateStr == nil)
    {
        self.label.text=@"12:00";
    }
    else
    {
        self.label.text=self.dateStr;
    }
    [UIView animateWithDuration:.3 animations:^{
        self.myView.frame=CGRectMake(0, JDScreenSize.height, JDScreenSize.width, 300);
    }];
    MyData * data =[MyData new];
    UISwitch * incomeS =(UISwitch *)[self.tableVi viewWithTag:111];
    UISwitch * breakR =(UISwitch *)[self.tableVi viewWithTag:222];
    if (incomeS.isOn)
    {
        self.statusIn= @"开";
    }
    else
    {
        self.statusIn =@"关";
    }
    if (breakR.isOn)
    {
        self.statusBr= @"开";
    }
    else
    {
        self.statusBr =@"关";
    }
    NSUserDefaults * us =[NSUserDefaults standardUserDefaults];
    [us setBool:incomeS.isOn forKey:@"inState"];
    [us setBool:breakR.isOn forKey:@"brState"];
    [us setValue:self.dateStr forKey:@"choice"];
    [us synchronize];
    [data getSetWithIncomeSwitch:self.statusIn WithBreakRulesSwitch:self.statusBr WithIncomeTime:self.label.text WithCompletion:^(NSString *str,NSString * msg)
    {
        if ([str intValue]==0)
        {
            //设置成功
        }
        else if ([str intValue]==1)
        {
            [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                
            }];
        }
        else if ([str intValue]==2)
        {
            [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                PersonalVC * vc =[[PersonalVC alloc] init];
                [vc removeFileAndInfo];
            }];
        }
        else
        {
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络连接失败,请重新尝试" count:0 doWhat:^{
                
            }];
        }
    }];
}
//选择器发生变化的时候调
- (void)datePickerValueChange:(NSString *)date
{
    if ([date isEqualToString:@""])
    {
        self.dateStr = @"12:00";
    }
    else
    {
        self.dateStr = date;
    }
}
//营收开关发生变化
- (void)inSwi:(UISwitch *)incomeS
{
    //找控件
    UISwitch * breakR =(UISwitch *)[self.tableVi viewWithTag:222];
    MyData * data =[MyData new];
    if (incomeS.isOn)
    {
        self.statusIn= @"开";
    }
    else
    {
        self.statusIn =@"关";
    }
    if (breakR.isOn)
    {
        self.statusBr= @"开";
    }
    else
    {
        self.statusBr =@"关";
    }
    NSUserDefaults * us =[NSUserDefaults standardUserDefaults];
    [us setBool:incomeS.isOn forKey:@"inState"];
    [us setBool:breakR.isOn forKey:@"brState"];
    [us synchronize];
    [data getSetWithIncomeSwitch:self.statusIn WithBreakRulesSwitch:self.statusBr WithIncomeTime:self.label.text WithCompletion:^(NSString *str,NSString * msg)
     {
         if ([str intValue]==0)
         {
             
         }
         else if ([str intValue]==1)
         {
             [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                 
             }];
         }
         else if ([str intValue]==2)
         {
             [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                 PersonalVC * vc =[[PersonalVC alloc] init];
                 [vc removeFileAndInfo];
             }];
         }
         else
         {
             [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络连接失败请重试尝试" count:0 doWhat:^{
                 
             }];
         }
     }];
}
//违章开关发生变化
- (void)breakSwi:(UISwitch *)breakS
{
    //找控件
    UISwitch * incomeS =(UISwitch *)[self.tableVi viewWithTag:111];
    MyData * data =[MyData new];
    if (incomeS.isOn)
    {
        self.statusIn= @"开";
    }
    else
    {
        self.statusIn =@"关";
    }
    if (breakS.isOn)
    {
        self.statusBr= @"开";
    }
    else
    {
        self.statusBr =@"关";
    }
    NSUserDefaults * us =[NSUserDefaults standardUserDefaults];
    [us setBool:incomeS.isOn forKey:@"inState"];
    [us setBool:breakS.isOn forKey:@"brState"];
    [us synchronize];
    [data getSetWithIncomeSwitch:self.statusIn WithBreakRulesSwitch:self.statusBr WithIncomeTime:self.label.text WithCompletion:^(NSString *str,NSString * msg)
     {
         if ([str intValue]==0)
         {
             
         }
         else if ([str intValue]==1)
         {
             [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                 
             }];
         }
         else if ([str intValue]==2)
         {
             [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                 PersonalVC * vc =[[PersonalVC alloc] init];
                 [vc removeFileAndInfo];
             }];
         }
         else
         {
             [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络连接失败请重试尝试" count:0 doWhat:^{
                 
             }];
         }
     }];
}




@end
