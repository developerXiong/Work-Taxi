//
//  JDMyPointViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/2/15.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMyPointViewController.h"
#import "PeccCell.h"
#import "HeadFile.pch"
#import "InviteViewController.h"
#import "JDFourRoadViewController.h"
#import "MBProgressHUD.h"
#import "MyTool.h"
#import "UIViewController+CustomModelView.h"
#import "GetData.h"
#import "PersonalVC.h"
#import "MyData.h"
#import "JDFourLostViewController.h"

#import "JDGoodsShopViewController.h"

@interface JDMyPointViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray * arr;
@property (nonatomic, strong) MBProgressHUD * hud;

@end

@implementation JDMyPointViewController

- (void)viewWillAppear:(BOOL)animated
{
    [MyTool checkNetWorkWithCompltion:^(NSInteger statusCode) {
        if (statusCode == 0)
        {
//            NSLog(@"网络连接中断");
            self.hud.labelText=@"网络链接中断,请查看您的网络链接";
            self.hud.mode=MBProgressHUDModeCustomView;
            [self.hud show:YES];
            [self.hud hide:YES afterDelay:2];
        }
        else
        {
//            NSLog(@"网路链接正常");
        }
    }];
    [self.tableVi reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableVi.backgroundColor=[UIColor clearColor];
    self.tableVi.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.arr=[NSArray arrayWithObjects:@"登陆E+TAXI",@"推荐乘客扫描车载PAD,安装并完成注册\n每推荐1位乘客安装客户端可获取100积分,\n每日推荐满5位再获300积分.",@"推荐副驾安装并完成注册\n每推荐1位乘客安装客户端可获取100积分,\n每日推荐满5位再获300积分.",@"通过E+TAXI失物认领功能提交乘客物品.",@"通过E+TAXI路况申报功能申报路况并核实.", nil];
    self.hud =[[MBProgressHUD alloc] initWithView:self.view];
    [self.tableVi addSubview:self.hud];
    
    [self addNavigationBar:@"我的积分"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else
    {
        return 5;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * arrr1 =[NSArray arrayWithObjects:@"每日登陆送积分",@"推荐乘客",@"推荐副驾",@"提交失物", @"申报路况送积分",nil];
    static NSString * cellID1 =@"cell4";
    static NSString * cellID2 =@"cell5";
    PeccCell * cell =nil;
    if (indexPath.section==0)
    {
        cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"PeccCell" owner:nil options:nil]objectAtIndex:3];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        if (SCORE)
        {
            //1650积分label的字体设置
            cell.myPoint.font=[UIFont systemFontOfSize:50];
            cell.myPoint.tag=10086;
            NSString * trans =[NSString stringWithFormat:@"%@",SCORE];
            NSString * pointStr =[NSString stringWithFormat:@"%@积分",trans];
            NSMutableAttributedString * noteStr =[[NSMutableAttributedString alloc]initWithString:pointStr];
            NSRange fontRange =NSMakeRange([[noteStr string]rangeOfString:@"积分"].location, [[noteStr string]rangeOfString:@"积分"].length);
            NSDictionary * attributeDic =[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
            [noteStr addAttributes:attributeDic range:fontRange];
            [cell.myPoint setAttributedText:noteStr];
        }
        else
        {
            //1650积分label的字体设置
            cell.myPoint.font=[UIFont systemFontOfSize:50];
            cell.myPoint.tag=10086;
            NSString * trans =@"0";
            NSString * pointStr =[NSString stringWithFormat:@"%@积分",trans];
            NSMutableAttributedString * noteStr =[[NSMutableAttributedString alloc]initWithString:pointStr];
            NSRange fontRange =NSMakeRange([[noteStr string]rangeOfString:@"积分"].location, [[noteStr string]rangeOfString:@"积分"].length);
            NSDictionary * attributeDic =[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
            [noteStr addAttributes:attributeDic range:fontRange];
            [cell.myPoint setAttributedText:noteStr];
        }
        //设置按钮的点击事件
        [cell.marketBtn addTarget:self action:@selector(marketBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"PeccCell" owner:nil options:nil]objectAtIndex:4];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        //设置标题内容
        cell.itemLabel.text=arrr1[indexPath.row];
        if (indexPath.row==0||indexPath.row==1)
        {
            cell.getBtn.hidden=YES;
        }
        cell.getBtn.tag=indexPath.row*1;
        [cell.getBtn addTarget:self action:@selector(getBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //定义一个内容的label
        UILabel * contentLabel =[[UILabel alloc] init];
        contentLabel.frame=CGRectMake(24, 38, 225, [self getHeightWithString:self.arr[indexPath.row]]+20);
        contentLabel.numberOfLines=0;
        contentLabel.font=[UIFont systemFontOfSize:12];
        contentLabel.textColor=[UIColor lightGrayColor];
        //设置内容label的行间距
        NSString * string =self.arr[indexPath.row];
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:string];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:4];
        [att addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
        contentLabel.attributedText = att;
        
        [cell addSubview:contentLabel];
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view =[[UIView alloc] init];
    view.backgroundColor=[UIColor clearColor];
    if (section==0)
    {
        UILabel * titleLab =[[UILabel alloc] init];
        titleLab.frame=CGRectMake(JDScreenSize.width/2-40, 5, 80, 20);
        titleLab.text=@"积分任务";
        titleLab.textAlignment=NSTextAlignmentCenter;
        titleLab.font=[UIFont systemFontOfSize:13];
        titleLab.textColor=[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
        [view addSubview:titleLab];
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 120;
    }
    else
    {
        CGFloat height =[self getHeightWithString:self.arr[indexPath.row]]+70;
            return height;
    }
    
}
- (void)marketBtnClick
{
    JDGoodsShopViewController *vc = [[JDGoodsShopViewController alloc] init];
//    JDIntegrateViewController * vc =[[JDIntegrateViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
//领取奖励按钮点击事件
- (void)getBtnClick:(UIButton *)btn
{
    switch (btn.tag)
    {
        case 2:
        {
            InviteViewController * vc =[[InviteViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc addNavigationBar:@"邀请副驾"];
            
        }
            break;
        case 3:
        {
            JDFourLostViewController * vc =[[JDFourLostViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc addNavigationBar:@"失物招领"];
        }
            break;
        case 4:
        {
            JDFourRoadViewController * vc =[[JDFourRoadViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc addNavigationBar:@"路况申报"];
        }
            break;
            
        default:
            break;
    }
}
- (CGFloat)getHeightWithString:(NSString *)str
{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(225, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    CGFloat height = ceilf(rect.size.height);
    return height;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
