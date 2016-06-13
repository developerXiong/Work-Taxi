//
//  JDPeccancyViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/5/19.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDPeccancyViewController.h"

#import "HeadFile.pch"
#import "JDPeccancyTopView.h"
#import "JDPeccancyShowCell.h"

#import "JDPeccancyHttpTool.h"
#import "JDPeccancyData.h"
#import "CYFMDBuse.h"

#import "PeccancyDealViewC.h"
#import "PeccancyDetailViewC.h"

#import "JDNoMessageView.h"

#define SelectImageString @"wzcx_选中2"
#define NoSelectImageString @"wzcx_未选中1"

@interface JDPeccancyViewController ()<UITableViewDelegate,UITableViewDataSource>

/**
 *  接收模型的数组
 */
@property (nonatomic, strong) NSMutableArray *modelArr;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *topView;
/**
 *  放 要处理的违章信息id的数组
 */
@property (nonatomic, strong) NSMutableArray *idArr;
/**
 *  存放已经选中过的按钮，
 */
@property (nonatomic, strong) NSMutableArray *btnArr;
/**
 *  选中的违章的总金额
 */
@property (nonatomic, assign) CGFloat moneys;
/**
 *  没有消息的界面
 */
@property (nonatomic, strong) JDNoMessageView *nomessV;

@end

@implementation JDPeccancyViewController

-(NSMutableArray *)btnArr
{
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

-(NSMutableArray *)idArr
{
    if (_idArr == nil) {
        _idArr = [NSMutableArray array];
    }
    return _idArr;
}

-(NSMutableArray *)modelArr
{
    if (_modelArr==nil) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _moneys = 0;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [JDPeccancyHttpTool peccancyGetDataInVc:self Success:^{
            
            NSArray *modelArr = [JDPeccancyHttpTool peccancyDataType:JDPeccancyDataTypeTotal];
            
            [self.modelArr addObjectsFromArray:modelArr];
            
            [self chooseTableViewOrNoMessView:modelArr.count];
            
        } failure:^(NSError *error) {
            
        }];
        
    });
    
    [self setUpTopView];
    
}

// 显示table view 还是显示 no message view
-(void)chooseTableViewOrNoMessView:(NSInteger)count
{
    if (count==0) {
        self.tableView.hidden = YES;
        self.nomessV.hidden = NO;
    }else{
        self.nomessV.hidden = YES;
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }
}

-(void)setUpTopView
{
    
    // 设置没有数据的界面
    self.nomessV = [[JDNoMessageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), JDScreenSize.width, JDScreenSize.height-64-60-60)];
    self.nomessV.hidden = YES;
    self.nomessV.message = @"当前没有违章信息";
    [self.view addSubview:self.nomessV];
    
    //
    JDPeccancyTopView *topView = [[JDPeccancyTopView alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, 60)];
    topView.nameArr = @[@"全部违章",@"正在处理",@"处理完成"];
    [topView selectBtnIndex:0];
    
    JDLog(@"%f==%f",_topView.bounds.size.width,_topView.bounds.size.height);
    
    [topView peccancyBtnClick:^(NSInteger index) {
        
        // 移除原数组的所有模型
        [self.modelArr removeAllObjects];
        
        if (index == 0) { // 全部的违章
            [self.modelArr addObjectsFromArray:[JDPeccancyHttpTool peccancyDataType:JDPeccancyDataTypeTotal]];
        }else if (index == 1) { // 正在处理中的违章
            [self.modelArr addObjectsFromArray:[JDPeccancyHttpTool peccancyDataType:JDPeccancyDataTypeProcessing]];
        }else { // 处理完成的违章
            [self.modelArr addObjectsFromArray:[JDPeccancyHttpTool peccancyDataType:JDPeccancyDataTypeComplete]];
        }
        
        [self chooseTableViewOrNoMessView:self.modelArr.count];
        
    }];
    
    [_topView addSubview:topView];
}

// 点击处理
- (IBAction)clickDealwith:(id)sender {
    
    JDLog(@"%@--%f",self.idArr,_moneys);
    
    if (!self.idArr.count) { // 未选择违章
        [GetData addAlertViewInView:self title:@"温馨提示" message:@"您还没有选择任何违章记录" count:0 doWhat:nil];
    }else{
        
        PeccancyDealViewC *dealVc = [[PeccancyDealViewC alloc] initWithDataArr:self.idArr withMoneyStr:[NSString stringWithFormat:@"%f",_moneys] withCode:nil];
        
        [self.navigationController pushViewController:dealVc animated:YES];
        
    }
    
    
}

#pragma mark - table view datasource & delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JDPeccancyData *peccData = self.modelArr[indexPath.row];
    
    JDPeccancyShowCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"JDPeccancyShowCell" owner:nil options:nil][0];
        cell.selectionStyle = 0;
        
        cell.peccName.text = peccData.info;
        cell.peccMoney.text = peccData.money;
        cell.peccScore.text = [NSString stringWithFormat:@"扣%@分",peccData.fen];
        cell.peccTime
        .text = peccData.occur_date;
        
    }
    
    if ([peccData.fen intValue]) { // 有扣分
        
        [self setBtn:cell.peccStatus AndImageV:cell.peccImage titleColor:COLORWITHRGB(128, 128, 128, 1) hidden:YES edgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) title:@"已扣分" imageName:nil];
        
    }else{
        if ([peccData.result isEqualToString:@"未处理"]) { // 未处理的记录
            
            [self setBtn:cell.peccStatus AndImageV:cell.peccImage titleColor:COLORWITHRGB(255, 65, 65, 1) hidden:NO edgeInsets:UIEdgeInsetsMake(0, 0, 20, 0) title:@"未处理" imageName:NoSelectImageString];
            cell.peccStatus.tag = indexPath.row;
            cell.peccStatus.selected = NO;
            [cell.peccStatus addTarget:self action:@selector(clickSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            // 遍历数组取出按钮，
            for (NSNumber *num in self.btnArr) {
                
                if (indexPath.row == [num integerValue]) {
                    
                    cell.peccImage.image = [UIImage imageNamed:SelectImageString];
                    cell.peccStatus.selected = YES;
                    
                }
                
            }
            
            
        }else if ([peccData.result isEqualToString:@"处理中"]) { // 处理中
            
            [self setBtn:cell.peccStatus AndImageV:cell.peccImage titleColor:COLORWITHRGB(37, 129, 233, 1) hidden:YES edgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) title:@"处理中" imageName:nil];
            
        }else { // 已完成
            
            [self setBtn:cell.peccStatus AndImageV:cell.peccImage titleColor:COLORWITHRGB(178, 178, 178, 1) hidden:YES edgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) title:@"已完成" imageName:nil];
            
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDPeccancyData *data =self.modelArr[indexPath.row];
    NSString *area=data.occur_area;
    
    PeccancyDetailViewC * vc_ =[[PeccancyDetailViewC alloc]initWithArr:self.modelArr WithCode:indexPath.row withAddress:area];
    if ([data.fen intValue]==0)
    {
        vc_.moneyStr=data.money;
        
    }
    else
    {
        vc_.moneyStr=@"0";
    }
    [self.navigationController pushViewController:vc_ animated:YES];
    [vc_ addNavigationBar:@"违章详情"];
}

#pragma mark - 处理状态按钮点击事件
-(void)clickSelectBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    JDPeccancyShowCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    JDPeccancyData *data = self.modelArr[sender.tag];
    NSNumber *num = [NSNumber numberWithInteger:indexPath.row];
    
    if (sender.selected) { // 选中的状态
        
        cell.peccImage.image = [UIImage imageNamed:SelectImageString];
        
        [self.idArr addObject:data.id];
        [self.btnArr addObject:num];
        
        _moneys += [data.money floatValue];
        
    }else{ // 未选中的状态
        
        cell.peccImage.image = [UIImage imageNamed:NoSelectImageString];
        
        [self.idArr removeObject:data.id];
        [self.btnArr removeObject:num];
        
        _moneys -= [data.money floatValue];
        
    }
    
    JDLog(@"idArr--->%@money---->%fbtnArr--->%@",self.idArr,_moneys,self.btnArr);
}

-(void)setBtn:(UIButton *)btn AndImageV:(UIImageView *)imageV titleColor:(UIColor *)color hidden:(BOOL)isHidden edgeInsets:(UIEdgeInsets)insets title:(NSString *)title imageName:(NSString *)imageName
{
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.contentEdgeInsets = insets;
    
    imageV.hidden = isHidden;
    imageV.image = [UIImage imageNamed:imageName];
}


@end
