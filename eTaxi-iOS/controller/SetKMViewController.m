//
//  SetKMViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/2/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "SetKMViewController.h"
#import "SetVC.h"
#import "HeadFile.pch"
#import "MyData.h"
#import "MyTool.h"

@interface SetKMViewController ()

@end

@implementation SetKMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
}
- (IBAction)contain:(UIButton *)sender
{
    
    MyData * data =[MyData new];
    [data goLoginWithloginWithPhoneNo:PHONENO WithPsw:PASSWORD withPostType:@"4" withManual:nil withMiles:self.kmTF.text withCompletion:^(NSString *returnCode, NSString *msg, NSString *checkFlg, NSInteger role) {
        
        if ([returnCode intValue]==0)
        {
            NSUserDefaults * us =[NSUserDefaults standardUserDefaults];
            [us setValue:self.kmTF.text forKey:@"KM"];
            [us synchronize];
            [self.navigationController popViewControllerAnimated:YES];
            MyTool * tool =[[MyTool alloc] init];
            [self presentViewController:[tool showAlertControllerWithTitle:@"温馨提示" WithMessages:@"公里数设置成功" WithCancelTitle:@"确定"] animated:YES completion:nil];
        }
        else if ([returnCode intValue]==1)
        {
            
            MyTool * tool =[[MyTool alloc] init];
            [self presentViewController:[tool showAlertControllerWithTitle:@"温馨提示" WithMessages:msg WithCancelTitle:@"确定"] animated:YES completion:nil];
        }
        else
        {
            MyTool * tool =[[MyTool alloc] init];
            [self presentViewController:[tool showAlertControllerWithTitle:@"温馨提示" WithMessages:@"网络状况不太好,请重试" WithCancelTitle:@"确定"] animated:YES completion:nil];
        }
    }];
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
