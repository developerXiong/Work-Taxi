
//
//  MyPointViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/1/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "MyPointViewController.h"
#import "OrderCell.h"
#import "UsingRecordViewController.h"
#import "HeadFile.pch"
#import "MyData.h"
#import "MyTool.h"
#import "UIViewController+CustomModelView.h"
#import "JDMyPointViewController.h"
#import "GetData.h"
#import "PersonalVC.h"

#import "JDGoodsShopViewController.h"

@interface MyPointViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray * itemArr;
@property (strong, nonatomic) NSMutableArray * getArr;
@property (strong, nonatomic) NSMutableArray * outArr;
@property (strong, nonatomic) NSString * leftScore;

@end

@implementation MyPointViewController

- (void)viewWillAppear:(BOOL)animated
{
    [MyTool checkNetWorkWithCompltion:^(NSInteger statusCode) {
        if (statusCode == 0)
        {
            NSLog(@"网络连接中断");
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络链接中断,请查看您的网络链接" count:0 doWhat:^{
                
            }];
        }
        else
        {
            NSLog(@"网路链接正常");
        }
    }];
    [self setupRefresh];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableVi.hidden=YES;
}
#pragma mark- 下拉数据刷新
- (void)setupRefresh
{
    [GetData addMBProgressWithView:self.view style:0];
    [GetData showMBWithTitle:@"正在刷新数据..."];
    
    self.getArr=[NSMutableArray array];
    [MyData getScoreInfoWithBeginDate:@"" WithOverDate:@"" withType:@"666" Completion:^(NSString *returnCode, NSString *msg, NSMutableDictionary *dic) {
        
        if ([returnCode intValue]==0)
        {
            self.getArr=dic[@"in"];
            self.outArr=dic[@"out"];
            self.leftScore=dic[@"scoreLeft"];
            [self.tableVi reloadData];
            self.tableVi.hidden=NO;
            [GetData hiddenMB];
        }
        else if ([returnCode intValue]==1)
        {
            [GetData hiddenMB];
            [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                
            }];
        }
        else if ([returnCode intValue]==2)
        {
            [GetData hiddenMB];
            [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                PersonalVC * vc =[[PersonalVC alloc] init];
                [vc removeFileAndInfo];
            }];
        }
        else
        {
            [GetData hiddenMB];
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络链接失败,请重试" count:0 doWhat:^{
                
            }];
        }
    }];
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
        return self.getArr.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID1 =@"cell3";
    static NSString * cellID2 =@"cell4";
    OrderCell * cell = nil;
    if (indexPath.section==0)
    {
        cell=[tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:nil options:nil]objectAtIndex:2];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.scoreLab.font=[UIFont systemFontOfSize:50];
        NSString * trans =self.leftScore;
        NSString * pointStr =[NSString stringWithFormat:@"%@积分",trans];
        NSMutableAttributedString * noteStr =[[NSMutableAttributedString alloc]initWithString:pointStr];
        NSRange fontRange =NSMakeRange([[noteStr string]rangeOfString:@"积分"].location, [[noteStr string]rangeOfString:@"积分"].length);
        NSDictionary * attributeDic =[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
        [noteStr addAttributes:attributeDic range:fontRange];
        [cell.scoreLab setAttributedText:noteStr];
        
        [cell.marketBtn addTarget:self action:@selector(marketBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.recordBtn addTarget:self action:@selector(recordBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.earnScore addTarget:self action:@selector(earnScoreClick) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        cell=[tableView dequeueReusableCellWithIdentifier:cellID2];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:nil   options:nil]objectAtIndex:3];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        MyData * data =self.getArr[indexPath.row];
        cell.spendItemLab.text=data.goods;
        cell.spendItemLab.numberOfLines=0;
        cell.spendDateLab.text=data.datetime;
        cell.spendPointLab.text=[NSString stringWithFormat:@"+%@",data.score];
        cell.spendPointLab.textColor=[UIColor colorWithRed:209/255.0 green:10/255.0 blue:21/255.0 alpha:1.0];
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
        titleLab.text=@"收入明细";
        titleLab.textAlignment=NSTextAlignmentCenter;
        titleLab.font=[UIFont systemFontOfSize:13];
        titleLab.textColor=[UIColor lightGrayColor];
        [view addSubview:titleLab];
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 110;
    }
    else
    {
        return 85;
    }
}
- (void)marketBtnClick
{
    JDGoodsShopViewController *vc = [[JDGoodsShopViewController alloc] init];
//    JDIntegrateViewController * vc =[[JDIntegrateViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)recordBtnClick
{
    UsingRecordViewController * vc =[[UsingRecordViewController alloc] initWithArray:self.outArr];
    [self.navigationController pushViewController:vc animated:YES];
    [vc addNavigationBar:@"使用记录"];
}
- (void)earnScoreClick
{
    JDMyPointViewController * vc =[[JDMyPointViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc addNavigationBar:@"我的积分"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
