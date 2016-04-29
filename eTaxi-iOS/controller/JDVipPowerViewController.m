//
//  JDVipPowerViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/3/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDVipPowerViewController.h"
#import "HeadFile.pch"
#import "JDVipCell.h"

@interface JDVipPowerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation JDVipPowerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addNavigationBar:@"会员特权"];
    self.tableView.separatorStyle = 0;
    self.tableView.backgroundColor = ViewBackgroundColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate&datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDVipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"vipCell"];
    cell = [[NSBundle mainBundle]loadNibNamed:@"JDVipCell" owner:nil options:nil][0];
    cell.selectionStyle = 0;
    
    NSArray *titleArr = @[@"普通会员",@"白金会员",@"钻石会员"];
    
    
    /**
     *  线
     */
    cell.topLabel.text = titleArr[indexPath.row];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}


@end
