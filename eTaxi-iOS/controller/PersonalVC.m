//
//  PersonalVC.m
//  E+TAXI
//
//  Created by jeader on 15/12/29.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import "PersonalVC.h"
#import "MyCell.h"
#import "MyData.h"
#import "UIImageView+AFNetworking.h"
#import "JDChangePassword.h"
#import "ChangePersonInfoVC.h"
#import "JDFindPasswordVC.h"
#import "JDChangePhoneNoVC.h"
#import "ViewController.h"
#import "HeadFile.pch"
#import "UIViewController+CustomModelView.h"
#import "MyTool.h"
#import "GetData.h"
#import "JDCallCarListDataTool.h"

@interface PersonalVC ()
{
    NSMutableDictionary *getDic;
    MyData * data;
}
@property (nonatomic, strong) NSString * kmTF;
@end

@implementation PersonalVC
- (void)viewWillAppear:(BOOL)animated
{
    [self.personTableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    getDic=[[NSMutableDictionary alloc]initWithCapacity:0];
    [MyData getPersonInfoWithCompletion:^(NSString *returnCode, NSString *msg, NSMutableDictionary *dic) {
        
        if ([returnCode intValue]==0)
        {
            getDic=dic;
            data =[getDic objectForKey:@"info"];
            [self.personTableView reloadData];
        }
        else if ([returnCode intValue]==1)
        {
            [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                return ;
            }];
        }
        else if ([returnCode intValue]==2)
        {
            [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                PersonalVC *p = [[PersonalVC alloc] init];
                [p removeFileAndInfo];
                
            }];
        }
        else
        {
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络似乎有点问题,请确认网络通畅" count:0 doWhat:^{
                return ;
            }];
        }
    }];
    
    [self addNavigationBar:@"个人信息"];
    
}
//一共几个区
#pragma mark- UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
//一个区有几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 6;
        }
            break;
        case 1:
        {
            return 2;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
        
        default:
            break;
    }
    return 0;
}
//表填充内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * titles =[NSArray arrayWithObjects:@"",@"服务证号",@"出租车公司",@"车牌号",@"行驶里程",@"上传个人信息", nil];
    NSArray * titles1 =[NSArray arrayWithObjects:@"修改密码",@"更换手机", nil];
    static NSString * cellID1 =@"cell1";
    static NSString * cellID2 =@"cell2";
    MyCell * cell =nil;
    
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
            if (!cell)
            {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:nil options:nil]objectAtIndex:0];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            
            //头像切圆
            cell.headImage.layer.cornerRadius=36;
            cell.headImage.clipsToBounds=YES;
            [cell.headImage setImageWithURL:[NSURL URLWithString:data.avataraUrl] placeholderImage:[UIImage imageNamed:@"个人信息头像"]];
            
            //用户名和姓名
            cell.phoneLab.text=PHONENO;
            cell.nameLab.text=NAME;
            
        }
        else
        {
            cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
            if (!cell)
            {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:nil options:nil]objectAtIndex:1];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
            }
            cell.titleLab.font=[UIFont italicSystemFontOfSize:15];
            cell.titleLab.text=titles[indexPath.row];
            if (indexPath.row==1)
            {
                cell.contentLab.text=SERVICENO;
            }
            else if (indexPath.row==2)
            {
                cell.contentLab.text=TAXICOMPANY;
            }
            else if (indexPath.row==3)
            {
                cell.contentLab.text=PLATE;
            }
            else if (indexPath.row==4)
            {
                if (KM)
                {
                    NSString * mosaic =[NSString stringWithFormat:@"%@公里",KM];
                    cell.contentLab.text=mosaic;
                }
                else
                {
                    cell.contentLab.text=@"去设置 >";
                    
                }
            }
            else
            {
                NSString * checkFlg =[[NSUserDefaults standardUserDefaults]objectForKey:@"checkFlg"];
                
                switch ([checkFlg intValue])
                {
                    case 0:
                        cell.contentLab.text=@"上传 >";
                        break;
                    case 1:
                        cell.contentLab.text=@"上传 >";
                        break;
                    case 2:
                        cell.contentLab.text=@"上传 >";
                        break;
                    case 3:
                        cell.contentLab.text=@"已审核";
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
    else if (indexPath.section==1)
    {
        cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:nil options:nil]objectAtIndex:1];
        }
        cell.titleLab.text=titles1[indexPath.row];
        cell.titleLab.font=[UIFont italicSystemFontOfSize:15];
        cell.contentLab.text=@"";
    }
    else
    {
        cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:nil options:nil]objectAtIndex:1];
            
            UILabel * exitLab =[[UILabel alloc]init];
            exitLab.frame =CGRectMake(JDScreenSize.width/2-40, 12, 80, 20);
            exitLab.text=@"退出登录";
            exitLab.textColor=[UIColor redColor];
            exitLab.font=[UIFont boldSystemFontOfSize:18];
            [cell.contentView addSubview:exitLab];
            cell.titleLab.hidden=YES;
            cell.contentLab.hidden=YES;
        }
    }
    
    return cell;
}
//设置区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 19;
}
//设置一个区脚的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
//设置一下第一个单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            return 100;
        }
    }
    return 44;
}
-(void)viewDidLayoutSubviews
{
    if ([self.personTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.personTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.personTableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.personTableView setLayoutMargins:UIEdgeInsetsZero];
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
#pragma mark-UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0)
    {
        if (indexPath.row==5)
        {
            NSString * str =[[NSUserDefaults standardUserDefaults]objectForKey:@"checkFlg"];
            
            if ([str intValue]==3)
            {
                MyTool * t =[[MyTool alloc] init];
                [self presentViewController:[t showAlertControllerWithTitle:@"温馨提示" WithMessages:@"您已通过审核,不需要再上传" WithCancelTitle:@"确定"] animated:YES completion:nil];
            }
            else
            {
                ChangePersonInfoVC * vc =[[ChangePersonInfoVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                [vc addNavigationBar:@"上传个人信息"];
            }
        }
        else if (indexPath.row==4)
        {
            [self showOkayCancelAlert];
        }
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0)
        {
            JDChangePassword * vc =[[JDChangePassword alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc addNavigationBar:@"修改登录密码"];
        }
        else
        {
            JDChangePhoneNoVC * changePhone =[[JDChangePhoneNoVC alloc]init];
            [self.navigationController pushViewController:changePhone animated:YES];
            [changePhone addNavigationBar:@"更换手机号码"];
        }
    }
    else
    {
        UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您确定要退出吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        UIAlertAction * other =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self removeFileAndInfo];
        }];
        [alert addAction:cancel];
        [alert addAction:other];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)showOkayCancelAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温 馨 提 示" message:@"请设置您的公里数(单位:公里)" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
        return ;
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        MyData * da =[[MyData alloc] init];
//        if (!self.kmTF) return;
        [da goLoginWithloginWithPhoneNo:PHONENO WithPsw:PASSWORD withPostType:@"4" withManual:nil withMiles:self.kmTF withCompletion:^(NSString *returnCode, NSString *msg, NSString *checkFlg) {
            if ([returnCode intValue]==0)
            {
                NSLog(@"设置成功");
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
                [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络连接失败" count:0 doWhat:^{
                    
                }];
            }
        }];
            NSUserDefaults * us =[NSUserDefaults standardUserDefaults];
            [us setValue:self.kmTF forKey:@"KM"];
            [us synchronize];
            [self.personTableView reloadData];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:textField];
        textField.tag=666;
        textField.placeholder=@"公里数";
        textField.keyboardType=UIKeyboardTypeNumberPad;
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)handleTextFieldTextDidChangeNotification:(NSNotification *)notification
{
    UITextField *textField = notification.object;
    self.kmTF=textField.text;
    
}
//限制文本框输入的字数长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField * textF =(UITextField *)[self.personTableView viewWithTag:666];
    if (textField==textF)
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
    return NO;
}
- (void)removeFileAndInfo
{
    NSUserDefaults * us = [NSUserDefaults standardUserDefaults];
    [us removeObjectForKey:@"KM"];           //退出时删除存储的公里数
    [us removeObjectForKey:@"name"];         //退出时删除存储的姓名
    [us removeObjectForKey:@"phone"];        //退出时删除存储的手机号
    [us removeObjectForKey:@"pushno"];       //退出时删除存储的推荐码
    [us removeObjectForKey:@"plateNo"];      //退出时删除存储的车牌号
    [us removeObjectForKey:@"loginTime"];    //退出时删除存储的时间戳
    [us removeObjectForKey:@"checkFlg"];     //退出时删除存储的司机审核状态
    [us removeObjectForKey:@"password"];     //退出时删除存储的密码
    [us removeObjectForKey:@"engineNo"];     //退出时删除存储的发动机后六位
    [us removeObjectForKey:@"leftScore"];    //退出时删除存储的剩余积分
    [us removeObjectForKey:@"serviceNo"];    //退出时删除存储的服务证号
    [us removeObjectForKey:@"taxiCompany"];  //退出时删除存储的出租车公司
    [us removeObjectForKey:@"pushArr"];      //退出时删除存储的推送的通知
    [us synchronize];
    
    NSFileManager * fileManager = [[NSFileManager alloc]init];
    NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"pecc.plist"];
    [fileManager removeItemAtPath:filePath error:nil];
    
//    [JDCallCarListDataTool removeCallCarPlist];
    
    ViewController * vc =[[ViewController alloc] init];
    UIWindow * window =[[[UIApplication sharedApplication]delegate]window];
    window.rootViewController=vc;
}
@end
