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

#define ImageArr @[@"普通会员_hytq",@"白金会员_hytq",@"钻石会员_hytq"]

@interface JDVipPowerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) CGFloat imageW; // 图片的宽度

@end

@implementation JDVipPowerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addNavigationBar:@"会员特权"];
    self.tableView.separatorStyle = 0;
    self.tableView.backgroundColor = ViewBackgroundColor;
    
    // 图片的宽度
    self.imageW = JDScreenSize.width-20;
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
    
    CGFloat w = self.imageW;
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, w, w*[self scaleWithIndex:indexPath.row])];
    [cell.backView addSubview:imageV];
    imageV.image = [UIImage imageNamed:ImageArr[indexPath.row]];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDLog(@"%f",self.imageW*[self scaleWithIndex:indexPath.row]+20);
    return (self.imageW*[self scaleWithIndex:indexPath.row])+20;
}

-(CGFloat)scaleWithIndex:(NSInteger)row
{
    NSArray *imageArr = ImageArr;
    
    UIImage *image = [UIImage imageNamed:imageArr[row]];
    CGSize size = [image size];
    CGFloat scaleHW = size.height/size.width;
    return scaleHW;
}


@end
