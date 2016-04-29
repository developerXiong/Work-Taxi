//
//  JDChangePassword.m
//  eTaxi-iOS
//
//  Created by jeader on 15/12/31.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import "JDChangePassword.h"
#import "MyData.h"
#import "MyTool.h"
#import "ScoreCell.h"
#import "HeadFile.pch"
#import "MBProgressHUD.h"
#import "ViewController.h"
#import "GetData.h"
#import "PersonalVC.h"

@interface JDChangePassword ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) MBProgressHUD * hud;

@end

@implementation JDChangePassword

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hud =[[MBProgressHUD alloc]init];
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
    [btn addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [vi addSubview:btn];
    self.tableVi.tableFooterView=vi;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1)
    {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID =@"cell4";
    ScoreCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    switch (indexPath.section)
    {
        case 0:
        {
            if (!cell)
            {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"ScoreCell" owner:nil options:nil]objectAtIndex:3];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.inputTF1.placeholder=@"原密码...";
            cell.inputTF1.keyboardType=UIKeyboardTypeNumberPad;
            cell.inputTF1.secureTextEntry=YES;
            cell.inputTF1.tag=111;
            cell.inputTF1.delegate=self;
            [cell.inputTF1 addTarget:self action:@selector(phoneClick:) forControlEvents:UIControlEventEditingChanged];
            cell.delete2.tag=100;
            cell.delete2.hidden=YES;
            [cell.delete2 addTarget:self action:@selector(deleteText:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 1:
        {
            if (!cell)
            {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"ScoreCell" owner:nil options:nil]objectAtIndex:3];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            
            if (indexPath.row==0)
            {
                cell.inputTF1.placeholder=@"新密码...";
                cell.inputTF1.tag=222;
                cell.inputTF1.delegate=self;
                [cell.inputTF1 addTarget:self action:@selector(oldClick:) forControlEvents:UIControlEventEditingChanged];
                cell.delete2.tag=200;
                cell.delete2.hidden=YES;
                [cell.delete2 addTarget:self action:@selector(deleteText:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                cell.inputTF1.placeholder=@"确认密码...";
                cell.inputTF1.tag=333;
                cell.inputTF1.delegate=self;
                [cell.inputTF1 addTarget:self action:@selector(newClick:) forControlEvents:UIControlEventEditingChanged];
                cell.delete2.tag=300;
                cell.delete2.hidden=YES;
                [cell.delete2 addTarget:self action:@selector(deleteText:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            cell.inputTF1.keyboardType=UIKeyboardTypeNumberPad;
            cell.inputTF1.secureTextEntry=YES;
            
        }
            break;
        default:
            break;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return @" 更换密码后,原密码将不可使用,请牢记您的新密码";
    }
    else
    {
        return nil;
    }
}
//设置区头区脚的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 30;
    }
    else
    {
        return 19;
    }
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
//文本框绑定的事件 可以监听文本框内输入的内容 然后判断是否让按钮显示
- (void)phoneClick:(UITextField *)textF
{
    if (textF.text.length>=1)
    {
        UIButton * btn =(UIButton *)[self.tableVi viewWithTag:100];
        btn.hidden=NO;
    }
}
- (void)oldClick:(UITextField *)textF
{
    if (textF.text.length>=1)
    {
        UIButton * btn =(UIButton *)[self.tableVi viewWithTag:200];
        btn.hidden=NO;
    }
}
- (void)newClick:(UITextField *)textF
{
    if (textF.text.length>=1)
    {
        UIButton * btn =(UIButton *)[self.tableVi viewWithTag:300];
        btn.hidden=NO;
    }
}
//开始编辑或者是停止编辑的时候删除按钮的消失状态
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UITextField * phoneNoTF =(UITextField *)[self.tableVi viewWithTag:111];
    UITextField * oldTF =(UITextField *)[self.tableVi viewWithTag:222];
    UITextField * newTF =(UITextField *)[self.tableVi viewWithTag:333];
    if (textField==phoneNoTF)
    {
        if (phoneNoTF.text.length>=1)
        {
            UIButton * btn =(UIButton *)[self.tableVi viewWithTag:100];
            btn.hidden=NO;
        }
        
    }
    else if (textField==oldTF)
    {
        if (oldTF.text.length>=1)
        {
            UIButton * btn =(UIButton *)[self.tableVi viewWithTag:200];
            btn.hidden=NO;
        }
        
    }
    else
    {
        if (newTF.text.length>=1)
        {
            UIButton * btn =(UIButton *)[self.tableVi viewWithTag:300];
            btn.hidden=NO;
        }
        
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UITextField * phoneNoTF =(UITextField *)[self.tableVi viewWithTag:111];
    UITextField * oldTF =(UITextField *)[self.tableVi viewWithTag:222];
    if (textField==phoneNoTF)
    {
        UIButton * btn =(UIButton *)[self.tableVi viewWithTag:100];
        btn.hidden=YES;
    }
    else if (textField==oldTF)
    {
        UIButton * btn =(UIButton *)[self.tableVi viewWithTag:200];
        btn.hidden=YES;
    }
    else
    {
        UIButton * btn =(UIButton *)[self.tableVi viewWithTag:300];
        btn.hidden=YES;
    }
}
//小删除按钮
- (void)deleteText:(UIButton *)btn
{
    if (btn.tag==100)
    {
        UITextField * phoneNo =(UITextField *)[self.tableVi viewWithTag:111];
        phoneNo.text=@"";
    }
    else if (btn.tag==200)
    {
        UITextField * password =(UITextField *)[self.tableVi viewWithTag:222];
        password.text=@"";
    }
    else
    {
        UITextField * nPass =(UITextField *)[self.tableVi viewWithTag:333];
        nPass.text=@"";
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField * phoneNoTF =(UITextField *)[self.tableVi viewWithTag:111];
    UITextField * confirmTF =(UITextField *)[self.tableVi viewWithTag:222];
    //    UITextField * newTF =(UITextField *)[self.tableView viewWithTag:300];
    if (textField==phoneNoTF)
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
    else if (textField==confirmTF)
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
//提交按钮点击事件
- (void)commit:(id)sender
{
    UITextField * phoneNo =(UITextField *)[self.tableVi viewWithTag:111];
    UITextField * password =(UITextField *)[self.tableVi viewWithTag:222];
    UITextField * nPass =(UITextField *)[self.tableVi viewWithTag:333];
    
    if ([MyTool validatePassword:phoneNo.text]&&[MyTool validatePassword:password.text]&&[MyTool validatePassword:nPass.text])
    {
        if (![password.text isEqualToString:nPass.text])
        {
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"请确认密码保持一致" count:0 doWhat:^{
                
            }];
        }
        else
        {
            MyData * data =[MyData new];
            
            [data getChangeNewPasswordWithPhoneNo:PHONENO WithPassword:phoneNo.text WithNewPassword:password.text WithCompletion:^(NSString *returnCode,NSString * msg) {
                //发送过请求之后 清除文本框上的文字
                password.text=@"";
                nPass.text=@"";
                if ([returnCode intValue]==0)
                {
                    
                    NSUserDefaults * us = [NSUserDefaults standardUserDefaults];
                    [us setValue:nPass.text forKey:@"password"];
                    [us synchronize];
                    [GetData addAlertViewInView:self title:@"温馨提示" message:@"修改密码成功!\n原有密码将不能使用,安全起见请重新登录账户" count:0 doWhat:^{
                        PersonalVC * vc =[[PersonalVC alloc] init];
                        [vc removeFileAndInfo];
                    }];
                }
                else if ([returnCode intValue]==1)
                {
                    [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                        
                    }];
                }
                else if ([returnCode intValue]==2)
                {
                    [GetData addAlertViewInView:self title:@"温馨提示" message:@"原始密码不正确,请重新输入!" count:0 doWhat:^{
//                        PersonalVC * vc =[[PersonalVC alloc] init];
//                        [vc removeFileAndInfo];
                        phoneNo.text = @"";
                        
                    }];
                }
                else
                {
                    [GetData addAlertViewInView:self title:@"温馨提示" message:@"当前网络状况不太良好,请在网络良好的状况下重试" count:0 doWhat:^{
                        
                    }];
                }
                [password becomeFirstResponder];
            }];
        }
        
    }
    else
    {
        if (![phoneNo.text length]){
            
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"请输入原密码!" count:0 doWhat:^{
                
            }];
            
        }
        
        if (![password.text length]) {
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"请输入新密码!" count:0 doWhat:^{
                
            }];
        }
        
        if (![nPass.text length]) {
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"请输入确认密码!" count:0 doWhat:^{
                
            }];
        }
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
