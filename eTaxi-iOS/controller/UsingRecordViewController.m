//
//  UsingRecordViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/2/15.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "UsingRecordViewController.h"
#import "PeccCell.h"
#import "MyData.h"
#import "PersonalVC.h"
#import "GetData.h"
#import "UIImageView+AFNetworking.h"

@interface UsingRecordViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray * getArr;

@end

@implementation UsingRecordViewController

- (instancetype)initWithArray:(NSArray *)outArr
{
    if (self=[super init])
    {
        self.getArr=outArr;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.img.hidden=YES;
    self.itemLab.hidden=YES;
    if (self.getArr.count==0)
    {
        self.tableVi.hidden=YES;
        self.img.hidden=NO;
        self.itemLab.hidden=NO;
    }
    self.tableVi.tableFooterView=[[UIView alloc] init];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self networkRequest];
}
- (void)networkRequest
{
    [MyData getScoreInfoWithBeginDate:@"" WithOverDate:@"" withType:@"1" Completion:^(NSString *returnCode, NSString *msg, NSMutableDictionary *dic) {
        if ([returnCode intValue]==0)
        {
            self.getArr=[dic objectForKey:@"out"];
            if (self.getArr.count != 0)
            {
                self.tableVi.hidden=NO;
                self.img.hidden=YES;
                self.itemLab.hidden=YES;
                [self.tableVi reloadData];
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
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络链接失败,请重试" count:0 doWhat:^{
                
            }];
        }
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.getArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID =@"cell2";
    PeccCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"PeccCell" owner:nil options:nil]objectAtIndex:1];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    MyData * data =[self.getArr objectAtIndex:indexPath.row];
    cell.goodsName.text=data.goods;
    cell.goodsTime.text=data.datetime;
    cell.goodsPoint.text=[NSString stringWithFormat:@"%@积分",data.score];
    //通过本地的存储找到 相对应的图片
    [cell.goodsImg setImageWithURL:[NSURL URLWithString:data.imageUrl] placeholderImage:[UIImage imageNamed:@"站位图80"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}
-(void)viewDidLayoutSubviews
{
    if ([self.tableVi respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableVi setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableVi respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableVi setLayoutMargins:UIEdgeInsetsZero];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
