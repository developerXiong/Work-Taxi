//
//  JDMaintenanceViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/26.
//  Copyright © 2016年 jeader. All rights reserved.
//  维修预约主界面

#import "JDMaintenanceViewController.h"

#import "JDMaintenanceView.h"

#import "HeadFile.pch"

#import "JDRepairViewController.h"

#import "JDRepairNetTool.h"
#import "RepairData.h"

#import "MyOrderViewController.h"


#define BackGroundImage [UIImage imageNamed:@"yywxbeijing"]
#define BackImageScale [BackGroundImage size].height/[BackGroundImage size].width //背景图片的高宽比例

@interface JDMaintenanceViewController ()<JDMaintenanceViewDelegate,JDRepairDelegate>

@property (nonatomic, weak) JDMaintenanceView *mainView;
/**
 *  维修点ID
 */
@property (nonatomic, copy) NSString *repairID;

/**
 *  预约时间
 */
@property (nonatomic, copy) NSString *timeStr;
/**
 *  维修项目的字符串数组
 */
@property (nonatomic, strong) NSMutableArray *proStrArr;

@end

@implementation JDMaintenanceViewController

-(NSMutableArray *)proStrArr
{
    if (_proStrArr==nil) {
        _proStrArr = [NSMutableArray array];
    }
    return _proStrArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加整体的视图
    [self addAllChildViews];
    
    [self addNavigationBar:@"预约维修"];
    
}

#pragma mark - 添加整体的视图
-(void)addAllChildViews
{
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:backgroundImageView];
    backgroundImageView.image = BackGroundImage;
    
    JDMaintenanceView *mainView = [[JDMaintenanceView alloc] init];
    [self.view addSubview:mainView];
    _mainView = mainView;
    mainView.delegate_main = self;
    mainView.contentSize = CGSizeMake(JDScreenSize.width, 30+10*4+LostAndRoadBtnViewH+55*3);
    
    // 添加时间选择框
    [mainView showChooseTimeViewInView:self.view ClickSure:^(NSString *timeStr) {
        
        _timeStr = timeStr;
        
    } cancel:^{
        
    }];
    
}

#pragma mark - maintenance view delegate
-(void)maintenanceClickRepairPro:(UIButton *)sender
{
    
    NSString *str = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    JDLog(@"--点击维修项目%ld",(long)sender.tag);
    
    if (sender.selected) {
        
        [self.proStrArr addObject:str];
    }else{
        [self.proStrArr removeObject:str];
    }
    
    
    JDLog(@"proStrArr--->%@",self.proStrArr);

}

-(void)maintenanceClickRepairTime
{
    JDLog(@"点击预约时间");
}

-(void)maintenanceClickRepairPoint
{
    JDLog(@"点击维修点");
    JDRepairViewController *repairVC = [[JDRepairViewController alloc] init];
    
    [self.navigationController pushViewController:repairVC animated:YES];
    
    repairVC.delegate = self;
}

-(void)maintenanceClickRepairCommit
{
    JDLog(@"点击立刻上传");
    
    /**
     *  维修项目string
     */
    NSMutableString *repairPro = [NSMutableString string];
    
    if (self.proStrArr.count==0) { // 如果没有选择维修项目
        [GetData addAlertViewInView:self title:@"温馨提示" message:@"请选择至少一项维修项目" count:0 doWhat:^{
            
        }];
    }else{
        
        for (int i = 0; i < self.proStrArr.count; i ++) {
            
            
            repairPro = (NSMutableString *)[repairPro stringByAppendingString:[NSString stringWithFormat:@"%@,",self.proStrArr[i]]];
            
        }
        repairPro = (NSMutableString *)[repairPro substringToIndex:self.proStrArr.count*2-1];
        
    }
    
    JDLog(@"commit--->%@",repairPro);
    
    if (!_timeStr) { // 如果没选择时间
        [GetData addAlertViewInView:self title:@"温馨提示" message:@"请选择预约时间" count:0 doWhat:^{
            
        }];
    }
    
    if (!_repairID) { // 如果没有选择维修点
        [GetData addAlertViewInView:self title:@"温馨提示" message:@"请选择维修点" count:0 doWhat:^{
            
        }];
    }
    
    [JDRepairNetTool sendRepairInfoWithPro:repairPro repairId:_repairID timeStr:_timeStr InVc:self Success:^{
       
        MyOrderViewController *orderVc = [[MyOrderViewController alloc] init];
        [self.navigationController pushViewController:orderVc animated:YES];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)maintenanceClickTimeViewSure:(NSString *)timeStr
{
    JDLog(@"点击确定%@",timeStr);
    _timeStr = timeStr;
    
}

-(void)maintenanceClickTimeViewCancel
{
    JDLog(@"点击取消");
}

#pragma mark - repairVC delegate
-(void)setRepairName:(NSString *)repairName repairID:(NSString *)repairID
{
    
    [_mainView.repairPoint setTitle:repairName forState:UIControlStateNormal];
    
    _repairID = repairID;
    
}

@end
