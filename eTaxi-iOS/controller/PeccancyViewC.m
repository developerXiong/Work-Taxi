//
//  PeccancyViewC.m
//  E+TAXI
//
//  Created by jeader on 15/12/29.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import "PeccancyViewC.h"
#import "PeccancyDetailViewC.h"
#import "MyData.h"
#import "MJRefresh.h"
#import "PeccCell.h"
#import "MyTool.h"
#import "MBProgressHUD.h"
#import "PeccancyDealViewC.h"
#import "HeadFile.pch"
#import "PersonalVC.h"
#import "GetData.h"

#define GrayColor COLORWITHRGB(90, 91, 92, 1)
#define RedPColor COLORWITHRGB(250, 40, 51, 1)
#define BlueColor COLORWITHRGB(21, 163, 255, 1)

@interface PeccancyViewC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * array;
}
@property (nonatomic, strong) MBProgressHUD * hud;

//设置一个数组用来装入已经点击的违章列表的项
@property (nonatomic, strong) NSMutableArray * peccArr;
@property (nonatomic, strong) NSMutableArray * pointArr;
@property (nonatomic, strong) NSMutableArray * dealArr;
@property (nonatomic, strong) NSMutableArray * idArr;
@property (nonatomic, strong) NSMutableArray * endArr;
@property (nonatomic, strong) NSString * moneyStr;

@end

@implementation PeccancyViewC

- (void)viewWillAppear:(BOOL)animated
{
    [MyTool checkNetWorkWithCompltion:^(NSInteger statusCode) {
        if (statusCode == 0)
        {
            NSLog(@"网络连接中断");
            [GetData addMBProgressWithView:self.view style:1];
            [GetData showMBWithTitle:@"网络链接中断,请查看您的网络链接"];
            [GetData hiddenMB];
        }
        else
        {
            NSLog(@"网路链接正常");
        }
    }];
    [self setupRefresh];
    [self._tableVi reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hud=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    //记录所有含有扣分项的数组
    self.pointArr=[[NSMutableArray alloc] initWithCapacity:0];
    //记录凡是被按钮点击过之后的数组
    self.peccArr =[[NSMutableArray alloc]initWithCapacity:0];
    //存储按钮点击之后记录的id的数组
    self.idArr =[[NSMutableArray alloc] initWithCapacity:0];
}

#pragma mark- 下拉数据刷新
- (void)setupRefresh
{
    MyData * data =[MyData new];
    [GetData addMBProgressWithView:self.view style:0];
    [GetData showMBWithTitle:@"正在刷新数据..."];
    [GetData hiddenMB];
    [data getPeccWithPhoneNo:PHONENO WithPassword:PASSWORD WithPlateNo:PLATE WithEngineNo:ENGINE WithCompletion:^(NSString *returnCode, NSString *msg, NSMutableDictionary *dic) {
        if ([returnCode intValue]==0)
        {
            array=[[NSMutableArray alloc]initWithCapacity:0];
            NSMutableArray * arr =dic[@"records"];
            array=[MyTool getAnalysisWithSmallArr:arr];
            
            if (array.count==0)
            {
                self._tableVi.separatorStyle=UITableViewCellSeparatorStyleNone;
                [GetData addMBProgressWithView:self.view style:1];
                [GetData showMBWithTitle:@"没有违章记录"];
                [GetData hiddenMB];
            }
            else
            {
                [GetData hiddenMB];
                //刷新表格
                [self._tableVi reloadData];
                
            }
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark- UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyTool * p =array[indexPath.row];
    static NSString * cellID =@"cell3";
    PeccCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"PeccCell" owner:nil options:nil]objectAtIndex:2];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (array.count==0)
        {
            cell.backgroundColor=[UIColor clearColor];
        }
    }
    [cell.stateBtn addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
    cell.stateBtn.tag=indexPath.row;
//    [cell.stateBtn setImage:[UIImage imageNamed:@"违章列表多选框"] forState:UIControlStateNormal];
    for (NSNumber * number in self.peccArr)
    {
        if (indexPath.row==[number integerValue])
        {
            [cell.stateBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
        }
        
    } 
    //区分已经处理的和没有处理的
    if ([p.pecc_result isEqualToString:@"未处理"]) {
        
        [cell.stateBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [cell.stateBtn setTitle:@"未处理" forState:UIControlStateNormal];
        [cell.stateBtn setBackgroundColor:RedPColor];
        cell.stateBtn.enabled = YES;
        
    }else{ // 处理中
        
        [cell.stateBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [cell.stateBtn setTitle:@"处理中" forState:UIControlStateNormal];
        [cell.stateBtn setBackgroundColor:BlueColor];
        cell.stateBtn.enabled = NO;
        
    }
//    if ([p.pecc_result isEqualToString:@"已处理"])
//    {
////        cell.dealStatus.text=@"已处理";
////        cell.dealStatus.textColor=[UIColor colorWithRed:0/255.0 green:157/255.0 blue:149/255.0 alpha:1.0];
////        //已经处理过的时候label扣分颜色不用变化
////        NSString * pointStr =[NSString stringWithFormat:@"扣%@分",p.pecc_point];
////        cell.scoreLabel.text=pointStr;
//        
//        
//    }
//    else if ([p.pecc_result isEqualToString:@"未处理"])
//    {
////        cell.dealStatus.text=@"未处理";
////        cell.dealStatus.textColor=[UIColor colorWithRed:209/255.0 green:10/255.0 blue:21/255.0 alpha:1.0];
//        
////        [cell.stateBtn setImage:[UIImage imageNamed:@"违章列表多选框"] forState:UIControlStateNormal];
////        
////        [cell setBackgroundColor:RedColor];
//    }
//    else if ([p.pecc_result isEqualToString:@"已受理"])
//    {
////        cell.dealStatus.text=@"已受理";
////        cell.dealStatus.textColor=[UIColor colorWithRed:13/255.0 green:103/255.0 blue:223/255.0 alpha:1.0];
//    }
//    else
//    {
////        cell.dealStatus.text=@"处理中";
////        cell.dealStatus.textColor=[UIColor colorWithRed:13/255.0 green:103/255.0 blue:223/255.0 alpha:1.0];
//        
////        cell.stateBtn.enabled = NO;
//        
//    }
    //扣分的项目颜色变化 无扣分和扣xx分
    if ([p.pecc_point intValue]==0)
    {
        cell.scoreLabel.text=@"无扣分";
    }
    else
    {
        cell.scoreLabel.text = @"有扣分";
        
        [cell.stateBtn setBackgroundColor:GrayColor];
        [cell.stateBtn setTitle:@"已扣分" forState:UIControlStateNormal];
        cell.stateBtn.enabled = NO;
        [cell.stateBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    //罚款
    NSString * fineStr =[NSString stringWithFormat:@"%@元",p.pecc_money];
    cell.fineLabel.textColor=[UIColor colorWithRed:209/255.0 green:10/255.0 blue:21/255.0 alpha:1.0];
    cell.fineLabel.text=fineStr;
    //违章内容
    cell.infoLabel.text=p.pecc_info;
    //日期时间
    NSRange range = NSMakeRange(0, 10);
    NSString * string =[p.pecc_date substringWithRange:range];
    NSDateFormatter * fmt =[[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy-MM-dd"];
    NSDate * date=[fmt dateFromString:string];
    NSString * dateStr =[fmt stringFromDate:date];
    cell.dateLabel.text=dateStr;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)changeState:(UIButton *)btn
{
    BOOL isSelected =NO;
    for (NSNumber * num in self.peccArr)
    {
        NSInteger i =[num integerValue];
        if (i==btn.tag)
        {
            isSelected=YES;
        }
        
    }
    NSIndexPath * indexPath=[NSIndexPath indexPathForRow:btn.tag inSection:0];
    PeccCell * cell =[self._tableVi cellForRowAtIndexPath:indexPath];
    if (isSelected)
    {
        NSNumber * number =[NSNumber numberWithInteger:indexPath.row];
        [self.peccArr removeObject:number];
        [cell.stateBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        MyTool * data =[array objectAtIndex:[number integerValue]];
        NSInteger count =[self.moneyStr integerValue];
        count=count-[data.pecc_money integerValue];
        self.moneyStr=[NSString stringWithFormat:@"%ld",(long)count];
        if ([data.pecc_point intValue] != 0)
        {
            [self.pointArr removeLastObject];
        }
    }
    else
    {
        NSNumber * number =[NSNumber numberWithInteger:indexPath.row];
        [self.peccArr addObject:number];
        [cell.stateBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
        MyTool * data =[array objectAtIndex:[number integerValue]];
        NSInteger count =0;
        if ([data.pecc_point intValue] != 0)
        {
            [self.pointArr addObject:@"1"];
        }
        else
        {
            for (NSNumber * num in self.peccArr)
            {
                MyTool * data =[array objectAtIndex:[num integerValue]];
                if ([data.pecc_point intValue]==0)
                {
                    count=count+[data.pecc_money integerValue];
                    self.moneyStr=[NSString stringWithFormat:@"%ld",(long)count];
                }
            }
        }
        
    }
    
    
}
- (void)dealPeccRecord
{
    [self.idArr removeAllObjects];
    for (NSNumber * num in self.peccArr)
    {
        MyTool * data =[array objectAtIndex:[num integerValue]];
        [self.idArr addObject:data.pecc_id];
    }
    [NSThread exit];
}
-(void)viewDidLayoutSubviews
{
    if ([self._tableVi respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self._tableVi setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self._tableVi respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self._tableVi setLayoutMargins:UIEdgeInsetsZero];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTool * data =[array objectAtIndex:indexPath.row];
    NSString * area=data.pecc_address;
    
    if ([data.pecc_point intValue]==0)
    {
        PeccancyDetailViewC * vc_ =[[PeccancyDetailViewC alloc]initWithArr:array WithCode:indexPath.row withAddress:area];
        vc_.moneyStr=data.pecc_money;
        [self.navigationController pushViewController:vc_ animated:YES];
        [vc_ addNavigationBar:@"违章详情"];
    }
    else
    {
        PeccancyDetailViewC * vc_ =[[PeccancyDetailViewC alloc]initWithArr:array WithCode:indexPath.row withAddress:area];
        vc_.moneyStr=@"0";
        [self.navigationController pushViewController:vc_ animated:YES];
        [vc_ addNavigationBar:@"违章详情"];
    }
    
}
- (IBAction)dealBtnClick:(UIButton *)sender
{
    //开启一个分线程处理for循环对id记录的存储
    NSThread * thread =[[NSThread alloc] initWithTarget:self selector:@selector(dealPeccRecord) object:nil];
    [thread start];
    //没有选择任何违章记录
    if (self.peccArr.count==0)
    {
        [GetData addAlertViewInView:self title:@"温馨提示" message:@"您还没有选择任何违章记录" count:0 doWhat:^{
            
        }];
        
    }
    //选择了违章记录
    else
    {
        //选择的违章记录全部含有扣分项
        if ([self.moneyStr intValue]<=0)
        {
            NSString * string =[NSString stringWithFormat:@"您选择处理的%lu项违章,全部含有扣分,无法处理.",(unsigned long)self.peccArr.count];
            [GetData addAlertViewInView:self title:@"温馨提示" message:string count:0 doWhat:^{
                
            }];
        }
        //选择的记录既有扣分项又有不扣分项
        else
        {
            for (NSNumber * num in self.peccArr)
            {
                MyTool * data =[array objectAtIndex:[num integerValue]];
                if ([data.pecc_point intValue] != 0)
                {
                    NSString * string =[NSString stringWithFormat:@"您总共选择处理%lu项违章,其中%lu项因含有扣分无法处理.",(unsigned long)self.peccArr.count,(unsigned long)self.pointArr.count];
                    [GetData addAlertViewInView:self title:@"温馨提示" message:string count:0 doWhat:^{
//                        PeccancyDealViewC * vc =[[PeccancyDealViewC alloc] initWithDataArr:self.idArr withMoneyStr:self.moneyStr withCode:nil];
//                        [self.navigationController pushViewController:vc animated:YES];
//                        [vc addNavigationBar:@"积分处理"];
                    }];
                    break;
                }
            }
            //违章处理选择状态变更过之后 往本地存储的违章记录编号
            PeccancyDealViewC * vc =[[PeccancyDealViewC alloc] initWithDataArr:self.idArr withMoneyStr:self.moneyStr withCode:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc addNavigationBar:@"积分处理"];
    }
    }
}
@end
