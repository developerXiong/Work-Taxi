//
//  JDMorethanViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/29.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMorethanViewController.h"

#import "HeadFile.pch"

#import "JDMessgeViewController.h"
#import "JDGoodsShopViewController.h"

@interface JDMorethanViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation JDMorethanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNavigationBar:@"更多"];
    self.tableView.separatorStyle = 0;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - table view delegate &datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
        cell.selectionStyle = 0;
        
        
    }
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 59, JDScreenSize.width, 1)];
    line.backgroundColor = ViewBackgroundColor;
    [cell.contentView addSubview:line];
    
    
    NSArray *imageArr = @[@"more_消息",@"more_积分商城"];
    cell.imageView.image = [UIImage imageNamed:imageArr[indexPath.row]];
    cell.textLabel.text = @[@" 消息",@"积分商城"][indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: // 消息
        {
            JDMessgeViewController *messVc = [[JDMessgeViewController alloc] init];
            [self.navigationController pushViewController:messVc animated:YES];
        }
            break;
        case 1: // 积分商城
        {
            JDGoodsShopViewController *messVc = [[JDGoodsShopViewController alloc] init];
            [self.navigationController pushViewController:messVc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
