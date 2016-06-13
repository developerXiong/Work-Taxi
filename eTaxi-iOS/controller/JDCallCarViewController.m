//
//  JDCallCarViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/21.
//  Copyright © 2016年 jeader. All rights reserved.
//  召车接单

#import "JDCallCarViewController.h"

#import "HeadFile.pch"

#import "JDNowAndFuturaCell.h"

#import "JDCallCarTool.h"
#import "JDCallCarData.h"

#import "JDOrderFailureView.h"

#import "JDCallCarMessageViewController.h"

#import "JDCallCarListViewController.h"

#import "MJRefresh.h"

#import "JDSoundPlayer.h"

#import "UIImageView+JDImageMove.h"

#import "JDNewAndFeatureImageView.h"

#import "JDCallCarAlertView.h"
#import "JDCallCarAlertViewFrame.h"

#import "JDCallCarListDataTool.h"

#import "JDNoMessageView.h"

#import "CYFloatingBallView.h"


#define NowUseImage [UIImage imageNamed:@"现在上车1"]
#define FuturaImage [UIImage imageNamed:@"预约用车1"]

@interface JDCallCarViewController ()<UITableViewDelegate,UITableViewDataSource,JDCallCarAlertViewDelaget,JDOrderFailureDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *topTotalView;

/**
 *  放 JDCallCarData 模型的数组
 */
@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) JDOrderFailureView *failure;
/**
 *  今日已接单数
 */
@property (weak, nonatomic) IBOutlet UILabel *todayOrder;
/**
 *  当前接单
 */
@property (weak, nonatomic) IBOutlet UIButton *currentBtn;

@property (weak, nonatomic) JDCallCarAlertView *alert;

@property (nonatomic, strong) NSIndexPath *indexPath;
/**
 *  我的订单数量
 */
@property (nonatomic, assign) NSInteger myOrderCount;

@end

static NSInteger _isCurrentVcIndex;

@implementation JDCallCarViewController



-(NSMutableArray *)modelArr
{
    if (_modelArr==nil) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"callCarReloadData" object:nil];
    
    // 设置tableview
    [self setUpTableView];
    
    // 设置导航栏
    [self setUpNavgationBar];
    
    _indexPath = [[NSIndexPath alloc] init];
    
    // 设置当前已接单
    [self setUpCurrentOrder];
    
    JDLog(@"%s---%p",__func__,self.tableView);
    
//    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(addObserver) userInfo:nil repeats:YES];
//    [timer fire];
//    [self performSelector:@selector(addObserver) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO modes:nil];
}

-(void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    // 根据_isCurrentVcIndex判断是否在当前界面
    _isCurrentVcIndex = 1;
    
    [super viewWillAppear:animated];
    
    // 刷新数据
    [self refresh];
    
    // 刷新悬浮窗数据
    [[CYFloatingBallView shareInstance] setUpNumber];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 根据_isCurrentVcIndex判断是否在当前界面
    _isCurrentVcIndex --;
    
}

#pragma mark public method
-(BOOL)isInCurrentViewController
{
    if (_isCurrentVcIndex==1) {
        return YES;
    }
    
    return NO;
}

// 刷新
-(void)refresh
{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [self.tableView.mj_header beginRefreshing];
//    [self getData];
    JDLog(@"%s---%p",__func__,self.tableView);
}

#pragma mark - 设置当前已接单
-(void)setUpCurrentOrder
{
    _currentBtn.layer.masksToBounds = YES;
    _currentBtn.layer.cornerRadius = 5.0;
}

- (IBAction)orderList:(id)sender {
    
    JDCallCarListViewController *list = [[JDCallCarListViewController alloc] init];
    [list addNavigationBar:@"接单列表"];
    [self.navigationController pushViewController:list animated:YES];
    
}


#pragma mark - 请求数据
-(void)getData
{
    // 浮动窗口数字改变
    [[CYFloatingBallView shareInstance] setUpNumber];
    
    // 移除没有消息s时的界面
    for (UIView *view in self.tableView.subviews) {
        if ([view isKindOfClass:[JDNoMessageView class]]) {
            
            [view removeFromSuperview];
        }
    }
    
    [self setUpOrderCount];
    
    // 请求单子列表
    [JDCallCarTool getCallCarInfoWithType:@"0" inVC:self Num:nil Success:^(NSMutableArray *modelArr, int status) {
            
        [self.tableView.mj_header endRefreshing];
        
        self.modelArr = modelArr;
        
        [self.tableView reloadData];
        
        // 没有召车信息
        if (modelArr.count==0) {
//            [GetData addMBProgressWithView:self.view style:1];
//            [GetData showMBWithTitle:@"当前没有召车信息！"];
//            [GetData hiddenMB];
            // 添加没有召车信息的界面
            JDNoMessageView *noMessView = [[JDNoMessageView alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, self.tableView.bounds.size.height*2/3)];
            noMessView.message = @"当前没有召车信息";
            [self.tableView addSubview:noMessView];
        }

        
    } failure:^(NSError *error) {
        
        if (error) {
            [self.tableView.mj_header endRefreshing];
        }
        
    }];
    
}

-(void)setUpOrderCount
{
    // 请求我的订单数量
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [JDCallCarTool getCallCarListWithType:@"2" inVC:self Success:^(NSMutableArray *modelArr, int orderCount) {
            
            self.myOrderCount = modelArr.count;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 今日已成功接单数，设置label数据
                self.todayOrder.text = [NSString stringWithFormat:@"今日已成功接单：%d",orderCount];
                // 当前接单数，设置button title
                [self.currentBtn setTitle:[NSString stringWithFormat:@"当前接单：%lu",(unsigned long)modelArr.count] forState:UIControlStateNormal];
                
            });
            
        } failure:^(NSError *error) {
            
        }];
        
    });
}

#pragma mark - 设置tableview 下拉刷新
-(void)setUpTableView
{
    self.tableView.rowHeight = [NowUseImage size].height + 2;
    self.tableView.separatorStyle = 0;
}

#pragma mark - 设置导航条
-(void)setUpNavgationBar
{
    [self addNavigationBar:@"预约召车"];
    [self addRightBtnWithImage:@"电召_消息" action:@selector(clickRightItem)];
    [self popToRootViewCntroller];
}

-(void)clickRightItem
{
    JDLog(@"click right item !");
    JDCallCarMessageViewController *message = [[JDCallCarMessageViewController alloc] init];
    [message addNavigationBar:@"消息中心"];
    [self.navigationController pushViewController:message animated:YES];
    
}

#pragma mark - tableView delegate & datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JDCallCarData *data = self.modelArr[indexPath.row];
    
    JDNowAndFuturaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[JDNowAndFuturaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = 0;
        
    }
    
    if ([data.useType intValue]==0) {
        
        cell.backImageView.image = NowUseImage;
        
    }else if([data.useType intValue]==1){
        
        cell.backImageView.image = FuturaImage;
        
    }else{
        
        cell.backImageView.image = NowUseImage;
        
    }
    
    cell.backImageView.phoneNo.text = [NSString stringWithFormat:@"乘客联系方式：%@",data.passengerPhoneNo];
    cell.backImageView.time.text = [NSString stringWithFormat:@"出发时间：%@",data.time];
    cell.backImageView.address.text = [NSString stringWithFormat:@"上车地点：%@",data.address];
    cell.backImageView.destination.text = [NSString stringWithFormat:@"目的地：%@",data.destination];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    
    // 显示提示框
    JDCallCarData *data = self.modelArr[indexPath.row];
    
    JDCallCarAlertViewFrame *viewModel = [[JDCallCarAlertViewFrame alloc] init];
    viewModel.callCarData = data;
    
    JDCallCarAlertView *alert = [[JDCallCarAlertView alloc] init];
    _alert = alert;
    alert.alertViewFrame = viewModel;
    [alert showInView:self.view];
    alert.delegate = self;
    
}

#pragma mark - call car alert view delegate
-(void)clickAlertViewSureBtn:(JDCallCarAlertViewFrame *)callCarAlertFrame
{
    
    [_alert hiddenAnimation:NO];
    

    if (self.myOrderCount<2) { // 还可以预约
    
       
        JDCallCarData *data = callCarAlertFrame.callCarData;
        
        [GetData addMBProgressWithView:self.view style:0];
        [GetData showMBWithTitle:@"正在接单......"];
        [GetData hiddenMB];
        
        [JDCallCarTool getCallCarInfoWithType:@"1" inVC:self Num:data.number Success:^(NSMutableArray *modelArr, int status) {
            
            if (status==0) { // 接单成功
                
                // 动画
                JDNowAndFuturaCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
                [cell.backImageView moveFromView:self.view];
                
                // 接单成功之后 移除单元格
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.modelArr removeObjectAtIndex:self.indexPath.row];
                    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    [self setUpOrderCount];
                    
//                    JDCallCarListViewController *list = [[JDCallCarListViewController alloc] init];
//                    [list addNavigationBar:@"接单列表"];
//                    [self.navigationController pushViewController:list animated:YES];
                });
                
                
                
            }else{ // 接单失败
                
                // 显示接单失败的界面
                JDOrderFailureView *orderView = [[JDOrderFailureView alloc] init];
                orderView.delegate = self;
                [orderView showInView:self.view];
                
            }
            
        } failure:^(NSError *error) {
            
            [GetData addAlertViewInView:self title:@"温馨提示！" message:@"服务器错误！请稍后重试！" count:0 doWhat:^{
                
            }];
            
        }];
    
    }else{ // 不能预约

        [GetData addAlertViewInView:self title:@"温馨提示！" message:@"您当前的单量已经满了！请先完成当前接单！" count:0 doWhat:^{
            
        }];

    }
    
}

#pragma mark - order failure view delegate
-(void)clickLookOtherBtn
{
    // 点击查看其他预约 刷新数据
    [self getData];
}

@end
