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
#import "JDUsingRecordHttpTool.h"
#import "JDUsingRecordData.h"
#import "HeadFile.pch"

#import "JDUsingRecordDetailViewController.h"

#import "JDPeccancyTopView.h"

@interface UsingRecordViewController ()<UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic, strong) NSArray * getArr;
/**
 *  装模型的数组
 */
@property (nonatomic, strong) NSMutableArray *modelArr;

@property (weak, nonatomic) IBOutlet UIView *topView;


@end

@implementation UsingRecordViewController

-(NSMutableArray *)modelArr
{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

- (instancetype)initWithArray:(NSArray *)outArr
{
    if (self=[super init])
    {
//        self.getArr=outArr;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.img.hidden=YES;
    self.itemLab.hidden=YES;
    self.tableVi.tableFooterView=[[UIView alloc] init];
    [self setUpTopView];
}
// 设置顶部视图 借用违章的JDPeccancyTopView
-(void)setUpTopView
{
    JDPeccancyTopView *topView = [[JDPeccancyTopView alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, 60)];
    topView.nameArr = @[@"兑换商品",@"处理违章"];
    [topView selectBtnIndex:0];
    
    [topView peccancyBtnClick:^(NSInteger index) {
        
        // 移除原数组的所有模型
        [self.modelArr removeAllObjects];
        
        if (index == 0) { // 兑换商品
            [self networkRequestWithType:0];
        }else if (index == 1) { // 处理违章
            [self networkRequestWithType:1];
        }
        
        [self.tableVi reloadData];
        
    }];
    
    [_topView addSubview:topView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self networkRequestWithType:0];
}
// 请求数据  type为0：兑换商品，1：处理违章
- (void)networkRequestWithType:(int)type
{
    [JDUsingRecordHttpTool getUsingRecordDataInVC:self success:^(NSArray *modelArr) {
        
        // 如果没有记录
        if (modelArr.count==0)
        {
            self.tableVi.hidden=YES;
            self.img.hidden=NO;
            self.itemLab.hidden=NO;
        }else{
            
            [self.modelArr removeAllObjects];
            if (type==0) { // 兑换商品
                // 把模型数组添加到---》self.modelArr
                for (JDUsingRecordData *data in modelArr) {
                    if (data.orderNo) {
                        [self.modelArr addObject:data];
                    }
                }
                
                self.modelArr = [JDUsingRecordData dataArrWithArray:self.modelArr];
                
            }else{ //处理违章
                for (JDUsingRecordData *data in modelArr) {
                    if (!data.orderNo) {
                        [self.modelArr addObject:data];
                    }
                }
            }
            
            [self.tableVi reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - table view delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
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
    JDUsingRecordData *data = self.modelArr[indexPath.row];
    
    if ([data.useStatus intValue]) { // 已经兑换过的物品栏显示灰色
        cell.goodsName.textColor = [UIColor grayColor];
        cell.goodsTime.textColor = [UIColor grayColor];
        cell.goodsPoint.textColor = [UIColor grayColor];
    }else{
        cell.goodsName.textColor = [UIColor blackColor];
        cell.goodsTime.textColor = [UIColor blackColor];
        cell.goodsPoint.textColor = [UIColor blackColor];
    }
    cell.goodsName.text=data.costName;
    cell.goodsTime.text=data.updateDate;
    cell.goodsPoint.text=[NSString stringWithFormat:@"%@积分",data.cost];
    //通过本地的存储找到 相对应的图片
    [cell.goodsImg setImageWithURL:[NSURL URLWithString:data.imageUrl] placeholderImage:[UIImage imageNamed:@"站位图80"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}

// 选中一栏单元格调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDUsingRecordData *data = self.modelArr[indexPath.row];
    
    if (data.orderNo) {
        
        JDUsingRecordDetailViewController *detailVc = [[JDUsingRecordDetailViewController alloc] initWithRecordData:data];
        [self.navigationController pushViewController:detailVc animated:YES];
        
    }
    
}


#pragma mark - WFK
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
