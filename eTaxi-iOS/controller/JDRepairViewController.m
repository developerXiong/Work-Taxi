//
//  JDRepairViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 15/12/29.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import "JDRepairViewController.h"
#import "JDRepairPointCell.h"
#import "UIImageView+WebCache.h"
#import "RepairData.h"
#import "HeadFile.pch"
#import "GetData.h"
#import "JDIsNetwork.h"
#import "MJRefresh.h"
#import "NSString+StringForUrl.h"

#import "JDRepairNetTool.h"

@interface JDRepairViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;


@end

@implementation JDRepairViewController

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNetData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.backgroundColor = ViewBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addNavigationBar:@"维修点"];
    
}

//获取数据
-(void)getNetData
{
    
    [JDRepairNetTool getRepairInfoInVc:self Success:^(NSMutableArray *modelArr) {
       
        self.dataArr = modelArr;
        [self.tableView reloadData];
        // 结束下拉刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

#pragma mark - tableView delegate & datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RepairData *repair = self.dataArr[indexPath.row];
    
    JDRepairPointCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selected = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell = [[NSBundle mainBundle]loadNibNamed:@"JDRepairPointCell" owner:nil options:nil][0];
    
    cell.repairName.text = repair.name;
    
    cell.repairAddress.text = repair.address;
    
    [cell.repairImage sd_setImageWithURL:[NSURL URLWithString:repair.imgAddress]];
    
    cell.repairTime.text = @"24小时营业";
    
    cell.repairPhone.text = repair.tel;
    
    [cell.repairSureBtn addTarget:self action:@selector(clickStarBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
    
}

//点击预约按钮调用
-(void)clickStarBtn:(UIButton *)sender
{
    
    UIButton *btn = (UIButton *)sender;
    
    [btn setTitleColor:ViewBackgroundColor forState:UIControlStateNormal];
    
//    btn.layer.borderColor = [BLUECOLOR CGColor];
    
    dispatch_time_t popTime1 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0*NSEC_PER_SEC));
    
    dispatch_after(popTime1, dispatch_get_main_queue(), ^{
        
        RepairData *repair = self.dataArr[sender.tag];
        
        if ([_delegate respondsToSelector:@selector(setRepairName:repairID:)]) {
            [_delegate setRepairName:repair.name repairID:repair.id];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    });
    
    
}

//点击cell调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//返回cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 188;
}

@end
