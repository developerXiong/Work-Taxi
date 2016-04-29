//
//  InviteViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/1/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "InviteViewController.h"
#import "MyTool.h"
#import "MyData.h"
#import "MBProgressHUD.h"
#import "GetData.h"
#import "PersonalVC.h"
#import "HeadFile.pch"

@interface InviteViewController ()<UITextFieldDelegate>


@end

@implementation InviteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithRed:238/255.0 green:239/255.0 blue:240/255.0 alpha:1.0];
    
    self.deleteBtn.hidden=YES;
}
- (void)viewDidAppear:(BOOL)animated
{
    [self.myTF becomeFirstResponder];
}
- (IBAction)inviteBtn:(id)sender
{
    NSString * str =[[NSUserDefaults standardUserDefaults]objectForKey:@"msg"];
    if ([MyTool validatePhone:self.myTF.text])
    {
        if (str)
        {
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"您已邀请过副驾,或一天后重试" count:0 doWhat:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else
        {
            //实现邀请二驾功能 
            MyData * data =[MyData new];
            [data getconfirmCodeWithPhoneNo:self.myTF.text WithType:@"1" WithCompletion:^(NSString * returnCode,NSString * number,NSString * msg){
                if ([returnCode intValue]==0)
                {
                    self.myTF.text=@"";
//                    NSLog(@"验证码是%@",number);
                    [GetData addAlertViewInView:self title:@"温馨提示" message:@"邀请成功!请通知副驾驶注意接收短信" count:0 doWhat:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    NSUserDefaults * success =[NSUserDefaults standardUserDefaults];
                    [success setObject:@"success" forKey:@"msg"];
                    [success synchronize];
                }
                else
                {
                    [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                        
                    }];
                }
            }];
        }
        
    }
    else
    {
        [GetData addAlertViewInView:self title:@"温馨提示" message:@"请输入正确的手机号" count:0 doWhat:^{
            
        }];
    }
    
}
- (IBAction)deleteBtn:(id)sender
{
    self.myTF.text=@"";
}
- (IBAction)inviteTF:(UITextField *)sender
{
    if (sender.text.length>=1)
    {
        self.deleteBtn.hidden=NO;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.text.length>=1)
    {
        self.deleteBtn.hidden=NO;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.deleteBtn.hidden=YES;
}
//限制文本框输入的字数长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.myTF)
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
    return NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
