//
//  JDVipRulesViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/3/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDVipRulesViewController.h"
#import "HeadFile.pch"
#import "JDVipCell.h"


#define ScaleHW 120/339 // 图片的高宽比例

@interface JDVipRulesViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation JDVipRulesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addNavigationBar:@"会员规则"];
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
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDVipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"vipCell"];
    cell = [[NSBundle mainBundle]loadNibNamed:@"JDVipCell" owner:nil options:nil][0];
    cell.selectionStyle = 0;
    
    NSArray *imageArr = @[@"Q1",@"Q2"];
    
    CGFloat w = JDScreenSize.width-20;
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, w, w*ScaleHW)];
    [cell.backView addSubview:imageV];
    imageV.image = [UIImage imageNamed:imageArr[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (JDScreenSize.width-20)*ScaleHW+20;
}

@end
