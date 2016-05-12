//
//  MyOrderViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/1/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "MyOrderViewController.h"
#import "OrderCell.h"
#import "MyTool.h"
#import "MJRefresh.h"
#import "MyData.h"
#import "MBProgressHUD.h"
#import "HeadFile.pch"
#import "JDMaintenanceViewController.h"
#import "GetData.h"
#import "PersonalVC.h"

@interface MyOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * completeArr;
@property (nonatomic, strong) NSMutableArray * cancelArr;
@property (nonatomic, strong) MBProgressHUD * hud;

@end

@implementation MyOrderViewController

- (void)viewWillAppear:(BOOL)animated
{
    [MyTool checkNetWorkWithCompltion:^(NSInteger statusCode) {
        if (statusCode == 0)
        {
            NSLog(@"网络连接中断");
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
    [self addNavigationBar:@"我的预约"];
    self.view.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
    self.imageG.hidden=YES;
    self.tipsLab.hidden=YES;
    self.tableVi.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableVi.showsVerticalScrollIndicator=NO;
    //初始化一个数组来装解析之后的数据
    self.dataArr=[NSMutableArray array];
    self.completeArr=[NSMutableArray array];
    self.cancelArr=[NSMutableArray array];
    
    //刷新表格 获取最新数据
    self.tableVi.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setupRefresh)];
    [self.tableVi.mj_header beginRefreshing];
    
    self.hud=[[MBProgressHUD alloc] initWithView:self.view];
    [self.tableVi addSubview:self.hud];
    [self theLittleViewAnimationWithButtonCenter:self.btn1.center withButtonTag:1];
}
- (void)setupRefresh
{
    MyData * data =[MyData new];
    [data getOrderTableWithType:@"1" withCompletionBlock:^(NSMutableDictionary *dict, NSString *returnCode, NSString *msg) {
        if ([returnCode intValue]==0)
        {
            self.dataArr=dict[@"ording"];
            self.completeArr=dict[@"complete"];
            self.cancelArr=dict[@"cancel"];
            if (self.dataArr.count != 0)
            {
                NSLog(@"dic is %@",dict);
                self.tableVi.hidden = NO;
                [self.tableVi reloadData];
                [self.tableVi.mj_header endRefreshing];
            }
            else
            {
                self.tableVi.hidden = YES;
                self.imageG.hidden=NO;
                self.tipsLab.hidden=NO;
                [self.tableVi.mj_header endRefreshing];
            }
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
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络链接失败" count:0 doWhat:^{
                
            }];
        }
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.btn1.selected==YES)
    {
        return self.dataArr.count;
    }
    else if (self.btn2.selected==YES)
    {
        return self.completeArr.count;
    }
    else
    {
        return self.cancelArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //正在预约中的记录
    if (self.btn1.selected==YES)
    {
        static NSString * cellID1 =@"cell1";
        OrderCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID1];
        MyData * d =self.dataArr[indexPath.row];
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:nil options:nil]objectAtIndex:0];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.titleLab.text=d.addressName;
        cell.timeLab.text=d.wholeTime;
        cell.itemLab.text=d.optionName;
        cell.telLab.text=d.optioinTel;
        cell.cancelBtn.hidden=NO;
        cell.deleteImg.hidden=NO;
        cell.deleteImg.image=[UIImage imageNamed:@"取消预约"];
        cell.cancelBtn.tag=indexPath.row;
//        cell.orderStatus.image = [UIImage imageNamed:@"预约中_预约"];
        [cell.cancelBtn setTitle:@"取消预约" forState:UIControlStateNormal];
        [cell.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    //已经完成的记录
    else if (self.btn2.selected==YES)
    {
        static NSString * cellID2 =@"cell2";
        OrderCell * cell1 =[tableView dequeueReusableCellWithIdentifier:cellID2];
        MyData * d =self.completeArr[indexPath.row];
        if (!cell1)
        {
            cell1=[[[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:nil options:nil]objectAtIndex:0];
            cell1.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell1.titleLab.text=d.addressName;
        cell1.timeLab.text=d.wholeTime;
        cell1.itemLab.text=d.optionName;
        cell1.telLab.text=d.optioinTel;
        cell1.cancelBtn.tag=indexPath.row;
        [cell1.cancelBtn setTitle:@"删   除" forState:UIControlStateNormal];
        [cell1.cancelBtn addTarget:self action:@selector(removeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell1.deleteImg.image=[UIImage imageNamed:@"删除"];
//        cell1.orderStatus.image = [UIImage imageNamed:@"已完成"];
        return cell1;
    }
    //已经取消的记录
    else if (self.btn3.selected==YES)
    {
        static NSString * cellID3 =@"cell3";
        OrderCell * cell2 =[tableView dequeueReusableCellWithIdentifier:cellID3];
        MyData * d =self.cancelArr[indexPath.row];
        if (!cell2)
        {
            cell2=[[[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:nil options:nil]objectAtIndex:0];
            cell2.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell2.titleLab.text=d.addressName;
        cell2.timeLab.text=d.wholeTime;
        cell2.itemLab.text=d.optionName;
        cell2.telLab.text=d.optioinTel;
        cell2.cancelBtn.tag=indexPath.row;
        [cell2.cancelBtn setTitle:@"删   除" forState:UIControlStateNormal];
        [cell2.cancelBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell2.deleteImg.image=[UIImage imageNamed:@"删除"];
//        cell2.orderStatus.image = [UIImage imageNamed:@"已取消"];
        
        return cell2;
    }
    else
    {
        return nil;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
//预约中的记录取消
- (void)cancelBtnClick:(UIButton *)btn
{
    [GetData addAlertViewInView:self title:@"温馨提示" message:@"您确定要取消吗?" count:1 doWhat:^{
        MyData * data =self.dataArr[btn.tag];
        [data getCancelOrderWithOptionID:data.addressId withType:@"3" withCompletionBlock:^(NSString *returnCode, NSString *msg) {
            if ([returnCode intValue]==0)
            {
            
                self.tableVi.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setupRefresh)];
                [self.tableVi.mj_header beginRefreshing];
                [GetData addAlertViewInView:self title:@"温馨提示" message:@"取消成功" count:0 doWhat:^{
                }];
            }
            else if ([returnCode intValue]==1)
            {
                [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:1 doWhat:^{
                    
                }];
            }
            else if ([returnCode intValue]==2)
            {
                [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:1 doWhat:^{
                    PersonalVC * vc =[[PersonalVC alloc] init];
                    [vc removeFileAndInfo];
                }];
            }
            else
            {
                [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络链接失败" count:1 doWhat:^{
                    
                }];
            }
        }];
    }];
    
}
//已经完成的记录删除
- (void)removeBtnClick:(UIButton *)btn
{
    [GetData addAlertViewInView:self title:@"温馨提示" message:@"您确定要删除吗?" count:1 doWhat:^{
        MyData * data =self.completeArr[btn.tag];
        [data getCancelOrderWithOptionID:data.addressId withType:@"4" withCompletionBlock:^(NSString *returnCode, NSString *msg) {
            if ([returnCode intValue]==0)
            {
                self.tableVi.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setupRefresh)];
                [self.tableVi.mj_header beginRefreshing];
                [GetData addAlertViewInView:self title:@"温馨提示" message:@"删除成功" count:0 doWhat:^{
                }];
            }
            else if ([returnCode intValue]==1)
            {
                [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:1 doWhat:^{
                    
                }];
            }
            else if ([returnCode intValue]==2)
            {
                [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:1 doWhat:^{
                    PersonalVC * vc =[[PersonalVC alloc] init];
                    [vc removeFileAndInfo];
                }];
            }
            else
            {
                [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络链接失败" count:1 doWhat:^{
                    
                }];
            }
        }];
    }];
}
//已经取消的记录删除
- (void)deleteBtnClick:(UIButton *)btn
{
    [GetData addAlertViewInView:self title:@"温馨提示" message:@"您确定要删除吗?" count:1 doWhat:^{
        MyData * data =self.cancelArr[btn.tag];
        [data getCancelOrderWithOptionID:data.addressId withType:@"4" withCompletionBlock:^(NSString *returnCode, NSString *msg) {
            if ([returnCode intValue]==0)
            {
                self.tableVi.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setupRefresh)];
                [self.tableVi.mj_header beginRefreshing];
                [GetData addAlertViewInView:self title:@"温馨提示" message:@"删除成功" count:0 doWhat:^{
                    
                }];
            }
            else if ([returnCode intValue]==1)
            {
                [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:1 doWhat:^{
                    
                }];
            }
            else if ([returnCode intValue]==2)
            {
                [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:1 doWhat:^{
                    PersonalVC * vc =[[PersonalVC alloc] init];
                    [vc removeFileAndInfo];
                }];
            }
            else
            {
                [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络链接失败" count:1 doWhat:^{
                    
                }];
            }
        }];
    }];
    
}
- (IBAction)addNew:(id)sender
{
    JDMaintenanceViewController * vc =[[JDMaintenanceViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
//三个按钮的点击事件
- (IBAction)btn1Click:(id)sender
{
    
    [self theLittleViewAnimationWithButtonCenter:self.btn1.center withButtonTag:1];
}

- (IBAction)btn2Click:(id)sender
{
    [self theLittleViewAnimationWithButtonCenter:self.btn2.center withButtonTag:2];
}

- (IBAction)btn3Click:(id)sender
{
    [self theLittleViewAnimationWithButtonCenter:self.btn3.center withButtonTag:3];
}
//button底层动画方法
- (void)theLittleViewAnimationWithButtonCenter:(CGPoint)center withButtonTag:(NSInteger)tag
{
    switch (tag)
    {
        case 1:
            self.btn1.selected = YES;
            self.btn2.selected = NO;
            self.btn3.selected = NO;
            [self.btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [self.btn2 setBackgroundColor:[UIColor whiteColor]];
            [self.btn3 setBackgroundColor:[UIColor whiteColor]];
            [self.btn1 setBackgroundColor:[UIColor colorWithRed:13/225.0 green:103/255.0 blue:203/255.0 alpha:1.0]];
            break;
        case 2:
            self.btn1.selected = NO;
            self.btn2.selected = YES;
            self.btn3.selected = NO;
            [self.btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [self.btn1 setBackgroundColor:[UIColor whiteColor]];
            [self.btn3 setBackgroundColor:[UIColor whiteColor]];
            [self.btn2 setBackgroundColor:[UIColor colorWithRed:13/225.0 green:103/255.0 blue:203/255.0 alpha:1.0]];
            break;
        case 3:
            self.btn1.selected = NO;
            self.btn2.selected = NO;
            self.btn3.selected = YES;
            [self.btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [self.btn1 setBackgroundColor:[UIColor whiteColor]];
            [self.btn2 setBackgroundColor:[UIColor whiteColor]];
            [self.btn3 setBackgroundColor:[UIColor colorWithRed:13/255.0 green:103/255.0 blue:203/255.0 alpha:1.0]];
            break;
            
        default:
            break;
    }
    [self.tableVi reloadData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
