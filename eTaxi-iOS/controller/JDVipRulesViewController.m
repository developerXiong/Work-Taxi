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
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDVipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"vipCell"];
    cell = [[NSBundle mainBundle]loadNibNamed:@"JDVipCell" owner:nil options:nil][0];
    cell.selectionStyle = 0;
    
    NSArray *titleArr = @[@"什么是会员？",@"如何提升会员等级？",@"会员等级有什么区别？"];
    
    NSArray *textArr = @[@"为了和客户建立的长期回馈体系，从您使用易加的士的这一刻开始，您就拥有了专属个人账户、尊贵的会员特权，我们竭尽全力，让您享受更优质的服务。",@"推荐下载易品APP，并完成注册。按推荐人数提升相应的会员等级。",@"会员拥有3个等级，分别为普通会员、白金会员、钻石会员。每个等级对应拥有相应的会员特权。"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, JDScreenSize.width-40, 88-30)];
    label.textColor = BLACKCOLOR;
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    [cell.boView addSubview:label];
    label.text = textArr[indexPath.row];
    
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
