//
//  JDLoginVC.m
//  eTaxi-iOS
//
//  Created by jeader on 15/12/31.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import "JDLoginVC.h"
#import "MyData.h"
#import "MyTool.h"
#import "ViewController.h"
#import "JDFindPasswordVC.h"
#import "UIViewController+CustomModelView.h"
#import "HeadFile.pch"
#import "ChangePersonInfoVC.h"
#import "PersonalVC.h"
#import "GetData.h"

@interface JDLoginVC ()<UITextFieldDelegate>

@end

@implementation JDLoginVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setViewContent];
    
}
- (void)setViewContent
{
    self.headImg.clipsToBounds=YES;
    self.headImg.layer.cornerRadius=35;
    
    //设置键盘的弹出方式是只有数字键盘
    self.phoneNo.keyboardType=UIKeyboardTypeNumberPad;
    self.password.keyboardType=UIKeyboardTypeNumberPad;
    self.password.secureTextEntry=YES;
    self.hud=[[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:self.hud];
    
    self.deleteBtn1.hidden=YES;
    self.deleteBtn2.hidden=YES;
    self.phoneNo.delegate=self;
    self.password.delegate=self;
    
    [self.phoneNo addTarget:self action:@selector(changPhoneNo:) forControlEvents:UIControlEventEditingChanged];
    [self.password addTarget:self action:@selector(changPassword:) forControlEvents:UIControlEventEditingChanged];
}
- (void)changPhoneNo:(UITextField *)text
{
    if (text.text.length>=1)
    {
        self.deleteBtn1.hidden=NO;
        self.deleteBtn1.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        self.deleteBtn1.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    }
}
- (void)changPassword:(UITextField *)text
{
    if (text.text.length>=1)
    {
        self.deleteBtn2.hidden=NO;
        self.deleteBtn2.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        self.deleteBtn2.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==self.phoneNo)
    {
        if (self.phoneNo.text.length>=1)
        {
            self.deleteBtn1.hidden=NO;
            self.deleteBtn1.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
            self.deleteBtn1.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        }
    }
    else
    {
        if (self.password.text.length>=1)
        {
            self.deleteBtn2.hidden=NO;
            self.deleteBtn2.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
            self.deleteBtn2.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==self.phoneNo)
    {
        self.deleteBtn1.hidden=YES;
    }
    else
    {
        self.deleteBtn2.hidden=YES;
    }
}

//限制文本框输入的字数长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.phoneNo)
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
//账号删除小按钮
- (IBAction)deleteBtn1:(UIButton *)sender
{
    self.phoneNo.text=@"";
}
//密码删除小按钮
- (IBAction)deleteBtn2:(UIButton *)sender
{
    self.password.text=@"";
}
//登录按钮
- (IBAction)loginBtn:(id)sender
{
    ViewController *VC = [[ViewController alloc] init];
    
    [self.view endEditing:YES];
    
    //获得用户输入的手机号和密码 存入本地
    if ([self.phoneNo.text isEqualToString:@""]||[self.password.text isEqualToString:@""])
    {
        NSString * str =[NSString stringWithFormat:@"请输入用户名或密码"];
        UIAlertController * alert =[UIAlertController alertControllerWithTitle:str message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"好的,我再看看" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    NSString * phoneNo =self.phoneNo.text;
    NSString * password =self.password.text;
    
    //判断手机号和密码的合法性
    if ([MyTool validatePhone:phoneNo]&&[MyTool validatePassword:password])
    {
        [GetData addMBProgressWithView:self.view style:0];
        [GetData showMBWithTitle:@"正在登陆..."];
        //发送登陆请求
        MyData * data = [MyData new];
        [data goLoginWithloginWithPhoneNo:phoneNo WithPsw:password withPostType:@"0" withManual:@"1" withMiles:nil withCompletion:^(NSString *returnCode, NSString *msg, NSString *checkFlg) {
            if ([returnCode intValue]==0)
            {
                NSUserDefaults * us = [NSUserDefaults standardUserDefaults];
                [us setValue:phoneNo forKey:@"phone"];
                [us setValue:password forKey:@"password"];
                [us synchronize];
                [GetData hiddenMB];
                
                [MyData getPersonInfoWithCompletion:^(NSString *returnCode, NSString *msg, NSMutableDictionary *dic) {
                    
                }];
                NSLog(@"%@=====>",checkFlg);
                switch ([checkFlg intValue])
                {
                    case 0:
                    {
                        /**
                         *  还从来没有提交过审核
                         */
                        MyTool * tool =[MyTool new];
                        [self presentViewController:[tool showAlertControllerWithTitle:@"温馨提示" WithMessages:@"请尽快提交您的信息,会有更多积分优惠等着你~" WithCancelTitle:@"确定"] animated:YES completion:nil];
                        //                        UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请尽快提交您的信息,会有更多积分优惠等着你~" preferredStyle:UIAlertControllerStyleAlert];
                        //                        UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"稍后再说" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        //                            return ;
                        //                        }];
                        //                        UIAlertAction * other =[UIAlertAction actionWithTitle:@"马上就去 >" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                        //                            ChangePersonInfoVC * vc =[[ChangePersonInfoVC alloc] init];
                        //                            [self.navigationController pushViewController:vc animated:YES];
                        //                            [vc addNavigationBar:@"上传个人信息"];
                        //                        }];
                        //                        [alert addAction:cancel];
                        //                        [alert addAction:other];
                        //                        [self presentViewController:alert animated:YES completion:nil];
                        
                        [VC goMain];
                    }
                        break;
                    case 1:
                    {
                        /**
                         *  提交了审核,但是还在审核中...
                         */
                        //                        MyTool * tool =[MyTool new];
                        //                        [self presentViewController:[tool showAlertControllerWithTitle:@"温馨提示" WithMessages:@"您提交的信息还在审核中,请等待通过审核" WithCancelTitle:@"确定"] animated:YES completion:nil];
                        [VC goMain];
                    }
                        break;
                    case 2:
                    {
                        /**
                         *  提交过审核,但是审核没用通过,审核失败
                         */
                        MyTool * tool =[MyTool new];
                        [self presentViewController:[tool showAlertControllerWithTitle:@"温馨提示" WithMessages:@"您的信息审核有误了,请再重新提交一次吧~" WithCancelTitle:@"确定"] animated:YES completion:nil];
                        [VC goMain];
                    }
                        break;
                    case 3:
                    {
                        /**
                         *  审核通过
                         */
                        [VC goMain];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
            else if ([returnCode intValue]==1)
            {
                [GetData hiddenMB];
                JDLog(@"%@",msg);
                [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                    
                }];
                
            }
            else if ([returnCode intValue]==2)
            {
                [GetData hiddenMB];
                JDLog(@"%@",msg);
                [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                    PersonalVC * vc =[[PersonalVC alloc] init];
                    [vc removeFileAndInfo];
                }];
            }
            else
            {
                [GetData hiddenMB];
                JDLog(@"%@",msg);
                [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络链接失败,请重试" count:0 doWhat:^{
                    
                }];
            }
        }];
    }
    else
    {
        [GetData addAlertViewInView:self title:@"温馨提示" message:@"您输入的用户名或密码不合法,请重新输入" count:0 doWhat:^{
            
        }];
    }
    
}

//忘记密码
- (IBAction)findPassword:(id)sender
{
    JDFindPasswordVC *  vc =[[JDFindPasswordVC alloc]init];
    self.password.text=@"";
    [self.navigationController pushViewController:vc animated:YES];
    [vc addNavigationBar:@"重置登陆密码"];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
