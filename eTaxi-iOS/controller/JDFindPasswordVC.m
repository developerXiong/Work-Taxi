//
//  JDFindPasswordVC.m
//  eTaxi-iOS
//
//  Created by jeader on 15/12/31.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import "JDFindPasswordVC.h"
#import "MyData.h"
#import "MyTool.h"
#import "HeadFile.pch"
#import "ScoreCell.h"
#import "JKCountDownButton.h"
#import "GetData.h"

@interface JDFindPasswordVC ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSString * str;



@end

@implementation JDFindPasswordVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.view.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self.tableView addGestureRecognizer:tap];
//    self.tableView.scrollEnabled=NO;
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
    [btn addTarget:self action:@selector(commitBtn) forControlEvents:UIControlEventTouchUpInside];
    [vi addSubview:btn];
    self.tableView.tableFooterView=vi;
}
//监听键盘的输入状况
- (void)phoneClick:(UITextField *)textF
{
    if (textF.text.length>=1)
    {
        UIButton * btn =(UIButton *)[self.tableView viewWithTag:1111];
        btn.hidden=NO;
    }
}
- (void)confirmClick:(UITextField *)textF
{
    if (textF.text.length>=1)
    {
        UIButton * btn =(UIButton *)[self.tableView viewWithTag:2222];
        btn.hidden=NO;
    }
}
- (void)nPasswordClick:(UITextField *)textF
{
    if (textF.text.length>=1)
    {
        UIButton * btn =(UIButton *)[self.tableView viewWithTag:3333];
        btn.hidden=NO;
    }
}
//开始编辑让删除小按钮出现
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UITextField * phoneNoTF =(UITextField *)[self.tableView viewWithTag:100];
    UITextField * confirmTF =(UITextField *)[self.tableView viewWithTag:200];
    UITextField * newTF =(UITextField *)[self.tableView viewWithTag:300];
    if (textField==phoneNoTF)
    {
        if (phoneNoTF.text.length>=1)
        {
            UIButton * btn =(UIButton *)[self.tableView viewWithTag:1111];
            btn.hidden=NO;
        }
    }
    else if (textField==confirmTF)
    {
        if (confirmTF.text.length>=1)
        {
            UIButton * btn =(UIButton *)[self.tableView viewWithTag:2222];
            btn.hidden=NO;
        }
    }
    else
    {
        if (newTF.text.length>=1)
        {
            UIButton * btn =(UIButton *)[self.tableView viewWithTag:3333];
            btn.hidden=NO;
        }
    }
}
//结束编辑让删除小按钮消失
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UITextField * phoneNoTF =(UITextField *)[self.tableView viewWithTag:100];
    UITextField * confirmTF =(UITextField *)[self.tableView viewWithTag:200];
    if (textField==phoneNoTF)
    {
        UIButton * btn =(UIButton *)[self.tableView viewWithTag:1111];
        btn.hidden=YES;
    }
    else if (textField==confirmTF)
    {
        UIButton * btn =(UIButton *)[self.tableView viewWithTag:2222];
        btn.hidden=YES;
    }
    else
    {
        UIButton * btn =(UIButton *)[self.tableView viewWithTag:3333];
        btn.hidden=YES;
    }
}

//限制文本框输入的字数长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField * phoneNoTF =(UITextField *)[self.tableView viewWithTag:100];
    UITextField * confirmTF =(UITextField *)[self.tableView viewWithTag:200];
//    UITextField * newTF =(UITextField *)[self.tableView viewWithTag:300];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) return 1;
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID1 =@"cell3";
    static NSString * cellID2 =@"cell4";
    ScoreCell * cell =nil;
    switch (indexPath.section)
    {
        case 0:
        {
            cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
            if (!cell)
            {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"ScoreCell" owner:nil options:nil]objectAtIndex:3];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.inputTF1.placeholder=@"手机号码...";
            cell.inputTF1.keyboardType=UIKeyboardTypeNumberPad;
            cell.inputTF1.tag=100;
            cell.inputTF1.delegate=self;
            [cell.inputTF1 addTarget:self action:@selector(phoneClick:) forControlEvents:UIControlEventEditingChanged];
            cell.delete2.tag=1111;
            cell.delete2.hidden=YES;
            [cell.delete2 addTarget:self action:@selector(newClick:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 1:
        {
            if (indexPath.row==0)
            {
                cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
                if (!cell)
                {
                    cell=[[[NSBundle mainBundle]loadNibNamed:@"ScoreCell" owner:nil options:nil]objectAtIndex:2];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                }
                cell.inputTF.placeholder=@"验证码...";
                [cell.inputTF addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventEditingChanged];
                cell.inputTF.tag=200;
                cell.inputTF.keyboardType=UIKeyboardTypeNumberPad;
                cell.inputTF.delegate=self;
                [cell.confirmBtn addTarget:self action:@selector(countDownXibTouched:) forControlEvents:UIControlEventTouchUpInside];
                cell.confirmBtn.tag=888;
                cell.delete1.tag=2222;
                cell.delete1.hidden=YES;
                [cell.delete1 addTarget:self action:@selector(newClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
                if (!cell)
                {
                    cell=[[[NSBundle mainBundle]loadNibNamed:@"ScoreCell" owner:nil options:nil]objectAtIndex:3];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                }
                cell.inputTF1.placeholder=@"新密码...";
                cell.inputTF1.secureTextEntry=YES;
                [cell.inputTF1 addTarget:self action:@selector(nPasswordClick:) forControlEvents:UIControlEventEditingChanged];
                cell.inputTF1.tag=300;
                cell.inputTF1.keyboardType=UIKeyboardTypeNumberPad;
                cell.inputTF1.delegate=self;
                cell.delete2.tag=3333;
                cell.delete2.hidden=YES;
                [cell.delete2 addTarget:self action:@selector(newClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            
        }
            break;
        default:
            break;
    }
    return cell;
}
//删除小按钮的点击事件
- (void)newClick:(UIButton *)sender
{
    UITextField * phoneNoTF =(UITextField *)[self.tableView viewWithTag:100];
    UITextField * confirmTF =(UITextField *)[self.tableView viewWithTag:200];
    UITextField * nPasswordTF =(UITextField *)[self.tableView viewWithTag:300];
    if (sender.tag==1111)
    {
        phoneNoTF.text=@"";
    }
    else if (sender.tag==2222)
    {
        confirmTF.text=@"";
    }
    else
    {
        nPasswordTF.text=@"";
    }
}
//定义每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
//定义区头的文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return @"为保证您的数据安全,重置密码前会发送验证码至您的手机中,请注意查看";
    }
    else
    {
        return nil;
    }
}
//定义每一个区区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 50;
    }
    else
    {
        return 19;
    }
}
//定义每一个区区脚的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
#pragma mark- 获取验证码单击事件
- (void)countDownXibTouched:(JKCountDownButton*)sender
{
    UITextField * phoneNo =(UITextField *)[self.tableView viewWithTag:100];
    //先判断输入的手机号是否合法
    if ([MyTool validatePhone:phoneNo.text])
    {
        //用解析类的对象去调用实例方法
        MyData * data =[MyData new];
        
        
        //实现找回密码功能
        [data getconfirmCodeWithPhoneNo:phoneNo.text WithType:@"0" WithCompletion:^(NSString * returnCode,NSString *number,NSString * msg){
            if ([returnCode intValue]==0)
            {
                _str=number;
//                NSLog(@"%@",_str);
                
                //开始倒计时期间不可以被点击
                [sender startWithSecond:30];
                [sender didChange:^NSString *(JKCountDownButton *countDownButton, int second)
                 {
                     NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
                     sender.enabled=NO;
                     return title;
                 }];
                [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                    sender.enabled=YES;
                    return @"重新获取";
                }];
            }
            else
            {
                [GetData addMBProgressWithView:self.view style:1];
                [GetData showMBWithTitle:msg];
                [GetData hiddenMB];
            }
        }];
    }
    else
    {
        [GetData addAlertViewInView:self title:@"温馨提示" message:@"请输入正确的手机号" count:0 doWhat:^{
            
        }];
    }
   
}
#pragma mark- 提交按钮点击事件
- (void)commitBtn
{
    //通过tag 找到对应的控件
    UITextField * phoneNoTF =(UITextField *)[self.tableView viewWithTag:100];
    UITextField * confirmTF =(UITextField *)[self.tableView viewWithTag:200];
    UITextField * nPasswordTF =(UITextField *)[self.tableView viewWithTag:300];
    JKCountDownButton * confirmBtn =(JKCountDownButton *)[self.tableView viewWithTag:888];
    
    //首先验证输入是否合法
    MyTool * tool =[MyTool new];
    if ([MyTool validatePhone:phoneNoTF.text]&&[MyTool validatePhone:phoneNoTF.text]&&[MyTool validatePassword:nPasswordTF.text])
    {
        if ([confirmTF.text isEqualToString:self.str])
        {
            //首先判断用户输入的验证码是否是过期
            NSDate * date =[[NSUserDefaults standardUserDefaults]objectForKey:@"time"];
            NSDate * newDate =[NSDate date];
            if ([newDate compare:date]==NSOrderedDescending)
            {
                
                //输入验证码的时间已经超过3分钟 验证码已经失效 提醒用户需要重新发送验证码
                [GetData addMBProgressWithView:self.view style:1];
                [GetData showMBWithTitle:@"验证码似乎已经失效,请您重新获取验证码"];
                [GetData hiddenMB];
            }
            else
            {
                //验证码比对成功 又没有过期  发送请求
                MyData * data =[[MyData alloc]init];
                [data getFindNewPasswordWithPhoneNo:phoneNoTF.text WithNewPassword:nPasswordTF.text WithCompletion:^(NSString * returnCode,NSString * msg) {
                    if ([returnCode intValue]==0)
                    {
                        //把密码写入到本地 以便于以后发送请求的时候 宏定义数值的准确性
                        NSUserDefaults * us =[NSUserDefaults standardUserDefaults];
                        [us setObject:nPasswordTF.text forKey:@"password"];
                        [us synchronize];
                        
                        confirmTF.text=@"";
                        nPasswordTF.text=@"";
                        
                        [GetData addAlertViewInView:self title:@"温馨提示" message:@"密码更改成功!" count:0 doWhat:^{
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                    }
                    else if ([returnCode intValue]==1)
                    {
                        [self presentViewController:[tool showAlertControllerWithTitle:@"错误" WithMessages:msg WithCancelTitle:@"确定"] animated:YES completion:nil];
                    }
                    else
                    {
                        [GetData addMBProgressWithView:self.view style:1];
                        [GetData showMBWithTitle:@"网络不太好,请重试一下吧"];
                        [GetData hiddenMB];
                        
                    }
                }];
        }
                [confirmBtn stop];
            
        }
        else
        {
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"验证码好像不对,重新试一下吧" count:0 doWhat:^{
            }];
        }
    }
    else
    {
        [GetData addAlertViewInView:self title:@"温馨提示" message:@"再确定一下您输入的信息吧" count:0 doWhat:^{
        }];
    }
}
- (void)tapClick:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
