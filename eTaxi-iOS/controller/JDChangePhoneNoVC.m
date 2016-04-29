//
//  JDChangePhoneNoVC.m
//  eTaxi-iOS
//
//  Created by jeader on 16/1/14.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDChangePhoneNoVC.h"
#import "MyTool.h"
#import "MyData.h"
#import "ScoreCell.h"
#import "HeadFile.pch"
#import "MBProgressHUD.h"
#import "ViewController.h"
#import "GetData.h"
#import "PersonalVC.h"

@interface JDChangePhoneNoVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) NSString * str;
@property (strong, nonatomic) MBProgressHUD * hud;

@end

@implementation JDChangePhoneNoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hud=[[MBProgressHUD alloc]init];
    [self.tableVi addSubview:self.hud];
    self.tableVi.scrollEnabled=NO;
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self.tableVi addGestureRecognizer:tap];
    [self setUpFooterView];
}
- (void)setUpFooterView
{
    UIView * vi =[[UIView alloc] init];
    vi.userInteractionEnabled=YES;
    vi.frame=CGRectMake(0, 0, JDScreenSize.width, 100);
    vi.backgroundColor=[UIColor clearColor];
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(25, 20, JDScreenSize.width-50, 51);
    [btn setBackgroundImage:[UIImage imageNamed:@"长按钮正常"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"长按钮高亮"] forState:UIControlStateSelected];
    [btn setTitle:@"确\t\t认" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    btn.tag=666;
    [btn addTarget:self action:@selector(commitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [vi addSubview:btn];
    self.tableVi.tableFooterView=vi;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID1 =@"cell3";
    static NSString * cellID2 =@"cell4";
    ScoreCell * cell =nil;
    if (indexPath.row==0)
    {
        cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"ScoreCell" owner:nil options:nil]objectAtIndex:3];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.inputTF1.placeholder=@"手机号码...";
        cell.inputTF1.tag=111;
        cell.inputTF1.keyboardType=UIKeyboardTypeNumberPad;
        cell.inputTF1.delegate=self;
        [cell.inputTF1 addTarget:self action:@selector(newPhone:) forControlEvents:UIControlEventEditingChanged];
        cell.delete2.tag=100;
        cell.delete2.hidden=YES;
        [cell.delete2 addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"ScoreCell" owner:nil options:nil]objectAtIndex:2];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.inputTF.placeholder=@"验证码...";
        cell.inputTF.keyboardType=UIKeyboardTypeNumberPad;
        cell.inputTF.tag=222;
        cell.inputTF.delegate=self;
        [cell.inputTF addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventEditingChanged];
        cell.delete1.tag=200;
        cell.delete1.hidden=YES;
        [cell.delete1 addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.confirmBtn addTarget:self action:@selector(countDownXibTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(void)viewDidLayoutSubviews
{
    if ([self.tableVi respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableVi setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableVi respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableVi setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
//设置一下区头和区脚
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * str =[[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
    NSString * title =[NSString stringWithFormat:@" 更换手机号, 下次登录可使用新手机号登陆\n 当前的手机号为:  %@",str];
    return title;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
//监听文本框的状态 判断按钮是否显示
- (void)newPhone:(UITextField *)textF
{
    if (textF.text.length>=1)
    {
        UIButton * btn =(UIButton *)[self.tableVi viewWithTag:100];
        btn.hidden=NO;
    }
}
- (void)confirm:(UITextField *)textF
{
    if (textF.text.length>=1)
    {
        UIButton * btn =(UIButton *)[self.tableVi viewWithTag:200];
        btn.hidden=NO;
    }
}
//开始编辑或者是停止编辑判断删除小按钮的状态
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UITextField * newPhoneTF =(UITextField *)[self.tableVi viewWithTag:111];
    UITextField * confirmTF =(UITextField *)[self.tableVi viewWithTag:222];
    if (textField==newPhoneTF)
    {
        if (newPhoneTF.text.length>=1)
        {
            UIButton * btn =(UIButton *)[self.tableVi viewWithTag:100];
            btn.hidden=NO;
        }
    }
    else
    {
        if (confirmTF.text.length>=1)
        {
            UIButton * btn =(UIButton *)[self.tableVi viewWithTag:200];
            btn.hidden=NO;
        }
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UITextField * newPhoneTF =(UITextField *)[self.tableVi viewWithTag:111];
    if (textField==newPhoneTF)
    {
        UIButton * btn =(UIButton *)[self.tableVi viewWithTag:100];
        btn.hidden=YES;
    }
    else
    {
        UIButton * btn =(UIButton *)[self.tableVi viewWithTag:200];
        btn.hidden=YES;
    }
}
//小删除按钮的点击事件
- (void)deleteClick:(UIButton *)sender
{
    if (sender.tag==100)
    {
        UITextField * phoneNo =(UITextField *)[self.tableVi viewWithTag:111];
        phoneNo.text=@"";
    }
    else
    {
        UITextField * confirmNo =(UITextField *)[self.tableVi viewWithTag:222];
        confirmNo.text=@"";
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField * phoneNoTF =(UITextField *)[self.tableVi viewWithTag:111];
    if (textField==phoneNoTF)
    {
        NSInteger loc =range.location;
        if (loc < 11)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        NSInteger loc =range.location;
        if (loc < 6)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}
#pragma mark- 获取验证码单击事件
- (void)countDownXibTouched:(JKCountDownButton*)sender
{
    UITextField * phoneNo =(UITextField *)[self.tableVi viewWithTag:111];
    //先判断输入的手机号是否合法
    if ([MyTool validatePhone:phoneNo.text])
    {
        //用解析类的对象去调用实例方法
        MyData * data =[MyData new];
        //实现找回密码功能
        [data getconfirmCodeWithPhoneNo:phoneNo.text WithType:@"2" WithCompletion:^(NSString * returnCode,NSString *number,NSString * msg){
            if ([returnCode intValue]==0)
            {
                _str=number;
//                NSLog(@"%@",_str);
                
                //开始倒计时期间不可以被点击
                [sender startWithSecond:30];
                [sender didChange:^NSString *(JKCountDownButton *countDownButton, int second)
                 {
                     NSString *title = [NSString stringWithFormat:@"%d秒后重试",second];
                     sender.enabled=NO;
                     return title;
                 }];
                [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                    sender.enabled=YES;
                    return @"重新获取";
                }];
            }
            else if ([returnCode intValue]==1)
            {
                [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                    
                }];
            }
            else if ([returnCode intValue]==2)
            {
                [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                    PersonalVC * vc =[[PersonalVC alloc] init];
                    [vc removeFileAndInfo];
                }];
            }
            else
            {
                [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络链接失败,请重试" count:0 doWhat:^{
                    
                }];
            }
        }];
    }
    else
    {
        [GetData addAlertViewInView:self title:@"温馨提示" message:@"请输入正确的手机号" count:0 doWhat:^{
            
        }];
    }
    
}
//提交修改信息
- (void)commitBtn:(id)sender
{
    UITextField * newPhoneTF = (UITextField *)[self.tableVi viewWithTag:111];
    UITextField * confirmTF =(UITextField *)[self.tableVi viewWithTag:222];
    if ([MyTool validatePhone:newPhoneTF.text] && [MyTool validatePassword:confirmTF.text])
    {
            if (confirmTF.text==self.str)
            {
                MyData * data =[MyData new];
                [data getChangeNewPhoneWithPhoneNo:PHONENO WithNewPhoneNo:newPhoneTF.text WithType:@"1" WithCompletionBlock:^(NSString *returnCode,NSString * msg) {
                    if ([returnCode intValue]==0)
                    {
                        NSUserDefaults * us = [NSUserDefaults standardUserDefaults];
                        [us setValue:newPhoneTF.text forKey:@"phone"];
                        [us synchronize];
                        UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"手机已重新绑定!\n原有手机号将不能使用,安全起见请重新登录账户" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction * other =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                            NSUserDefaults * us = [NSUserDefaults standardUserDefaults];
                            [us removeObjectForKey:@"phone"];
                            [us removeObjectForKey:@"password"];
                            [us synchronize];
                            ViewController * vc =[[ViewController alloc] init];
                            UIWindow * window =[[[UIApplication sharedApplication]delegate]window];
                            window.rootViewController=vc;
                        }];
                        [alert addAction:other];
                        [self presentViewController:alert animated:YES completion:nil];
                        
                    }
                    else if ([returnCode intValue]==1)
                    {
                        [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                            
                        }];
                    }
                    else if ([returnCode intValue]==2)
                    {
                        [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                            PersonalVC * vc =[[PersonalVC alloc] init];
                            [vc removeFileAndInfo];
                        }];
                    }
                    else
                    {
                        [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络链接失败,请重试" count:0 doWhat:^{
                            
                        }];
                    }
                }];
            }
            else
            {
                [GetData addAlertViewInView:self title:@"温馨提示" message:@"验证码不正确" count:0 doWhat:^{
                    
                }];
            }
        }
        else
        {
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"请确认输入完整" count:0 doWhat:^{
                
            }];
        }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (void)tapClick:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}


@end
