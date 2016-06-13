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

#import "JDGoodsHttpTool.h"
#import "JDGoodsData.h"

@interface JDMyPointViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray * arr;
@property (nonatomic, strong) MBProgressHUD * hud;
/**
 *  图片名称array
 */
@property (nonatomic, strong) NSMutableArray *imageArr;
/**
 *  存放cell高度的数组
 */
@property (nonatomic, strong) NSMutableArray *heightArr;

@end

@implementation JDMyPointViewController

-(NSMutableArray *)imageArr
{
    if (_imageArr==nil) {
        _imageArr = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            NSString *imageStr = [NSString stringWithFormat:@"score0_%d",i];
            [_imageArr addObject:imageStr];
        }
    }
    return _imageArr;
}

-(NSMutableArray *)heightArr
{
    if (_heightArr==nil) {
        _heightArr = [NSMutableArray array];
        
        for (int i = 0; i < 5; i++) {
            
            NSString *imageStr = self.imageArr[i];
            
            CGSize imageS = [[UIImage imageNamed:imageStr] size];
            
            CGFloat height = (JDScreenSize.width-20)*imageS.height/imageS.width;
            
            NSString *heightStr = [NSString stringWithFormat:@"%f",height];
            
            [_heightArr addObject:heightStr];
        }
        
    }
    return _heightArr;
}

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
    self.tableVi.estimatedRowHeight = 100;
//    self.arr=[NSArray arrayWithObjects:@"登陆E+TAXI",@"推荐乘客扫描车载PAD,安装并完成注册\n每推荐1位乘客安装客户端可获取100积分,\n每日推荐满5位再获300积分.",@"推荐副驾安装并完成注册\n每推荐1位乘客安装客户端可获取100积分,\n每日推荐满5位再获300积分.",@"通过E+TAXI失物认领功能提交乘客物品.",@"通过E+TAXI路况申报功能申报路况并核实.", nil];
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
//    NSArray * arrr1 =[NSArray arrayWithObjects:@"每日登陆送积分",@"推荐乘客",@"推荐副驾",@"提交失物", @"申报路况送积分",nil];
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
        
        cell.marketBtn.layer.masksToBounds = YES;
        cell.marketBtn.layer.cornerRadius = 5.0;
        
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
        
        NSArray *imageArr = self.imageArr;
        cell.backImage.image = [UIImage imageNamed:imageArr[indexPath.row]];
        
//        //定义一个内容的label
//        UILabel * contentLabel =[[UILabel alloc] init];
//        contentLabel.frame=CGRectMake(24, 38, 225, [self getHeightWithString:self.arr[indexPath.row]]+20);
//        contentLabel.numberOfLines=0;
//        contentLabel.font=[UIFont systemFontOfSize:12];
//        contentLabel.textColor=[UIColor whiteColor];
//        //设置内容label的行间距
//        NSString * string =self.arr[indexPath.row];
//        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:string];
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle setLineSpacing:4];
//        [att addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
//        contentLabel.attributedText = att;
//        
//        [cell addSubview:contentLabel];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //领取奖励按钮点击事件
    if (indexPath.section==1) {
        if (indexPath.row==2) {
            InviteViewController * vc =[[InviteViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc addNavigationBar:@"邀请副驾"];
        }else if(indexPath.row==3){
            JDFourLostViewController * vc =[[JDFourLostViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if(indexPath.row==4){
            JDFourRoadViewController * vc =[[JDFourRoadViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, 30)];
    view.backgroundColor=[UIColor clearColor];
    if (section==0)
    {
        UILabel * titleLab =[[UILabel alloc] init];
        titleLab.frame=CGRectMake(JDScreenSize.width/2-40, 0, 80, 30);
        titleLab.text=@"积分任务";
        titleLab.textAlignment=NSTextAlignmentCenter;
        titleLab.font=[UIFont systemFontOfSize:15];
        titleLab.textColor=[UIColor whiteColor];
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
        CGFloat height = [[NSString stringWithFormat:@"%@",self.heightArr[indexPath.row]] floatValue];
        
        return height;
    }
    
}
- (void)marketBtnClick
{
    JDGoodsShopViewController *vc = [[JDGoodsShopViewController alloc] init];
//    JDIntegrateViewController * vc =[[JDIntegrateViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
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
