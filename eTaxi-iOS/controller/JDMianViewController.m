//
//  JDMianViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/19.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMianViewController.h"
#import "HeadFile.pch"
#import "JDMainView.h"
#import "JDMainButton.h"
#import "JDMainBtnView.h"
#import "JDMainButton.h"
#import "JDMainBar.h"
#import "JDIndependentBtn.h"
#import "JDMyPointViewController.h"
#import "JDFourRoadViewController.h"
#import "JDFourLostViewController.h"
#import "PeccancyViewC.h"
#import "JDMoreViewController.h"
#import "LeftTransparentView.h"
#import "MyPointViewController.h"
#import "MyOrderViewController.h"
#import "JDVIPViewController.h"
#import "MyTool.h"
#import "SetVC.h"
#import "InviteViewController.h"
#import "JDCallCarViewController.h"

#import "JDGetMainViewDataTool.h"
#import "JDMainViewData.h"

#import "JDMaintenanceViewController.h"

#import "JDMorethanViewController.h"

#import "JDAboutUsViewController.h"

@interface JDMianViewController ()<JDMainButtonDelegate,LeftViewDelegate,JDMainBarDelegate>

@property (nonatomic, strong) JDMainView *mainView;

@property (nonatomic, strong) LeftTransparentView *myView;

//蒙层
@property (strong, nonatomic) UIControl * controll;

//定时器
//@property (nonatomic, strong) NSTimer *timer;

@end

@implementation JDMianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    //状态栏字体颜色改为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加主页
    [self addMainView];
    // 添加个人信息视图
    [self addLayerAndLeftView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (PLATE&&ENGINE) {
        
        [self getPeccnumber];
    }
    
}

-(void)getPeccnumber
{
    
    [JDGetMainViewDataTool GetVipInfoWithVc:self plate:PLATE engine:ENGINE success:^(NSMutableDictionary *dictArr) {
        
    } failure:^(NSError *error) {
        
    }];
   
}


#pragma mark - 主页视图
-(void)addMainView
{
    _mainView = [[JDMainView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_mainView];
    
    // 主按钮视图的delegate
    _mainView.mainBtn.mainButton.delegate = self;
    
    // 个人信息的代理
    _mainView.mainBar.delegate = self;
}

#pragma mark - JDMainButton的delegate
-(void)mainButtonDidAnimation:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 0: // 预约维修
        {
            JDMaintenanceViewController *pvc = [[JDMaintenanceViewController alloc] init];
//            JDCarRepairViewController *pvc = [[JDCarRepairViewController alloc] init];
            [self.navigationController pushViewController:pvc animated:NO];
        }
            break;
        case 1: // 召车接单
        {
            JDCallCarViewController *car = [[JDCallCarViewController alloc] init];
            [car addNavigationBar:@"预约召车"];
            [self.navigationController pushViewController:car animated:NO];
        }
            break;
        case 2: // 路况申报
        {
            JDFourRoadViewController *roadVC = [[JDFourRoadViewController alloc] init];
            [self.navigationController pushViewController:roadVC animated:NO];
        }
            break;
        case 3: // 违章查询
        {
            PeccancyViewC *ievc = [[PeccancyViewC alloc] init];
            [ievc addNavigationBar:@"违章查询"];
            [self.navigationController pushViewController:ievc animated:NO];
        }
            break;
        case 4: // 失物招领
        {
            JDFourLostViewController *losVC = [[JDFourLostViewController alloc] init];
            [self.navigationController pushViewController:losVC animated:NO];
        }
            break;
        case 5: // 我的积分
        {
            JDMyPointViewController *score = [[JDMyPointViewController alloc] init];
            
            [self.navigationController pushViewController:score animated:NO];
        }
            break;
        case 6: // 更多
        {
//            JDMoreViewController *moreVC = [[JDMoreViewController alloc] init];
            JDMorethanViewController *moreVC = [[JDMorethanViewController alloc] init];
            
            [self.navigationController pushViewController:moreVC animated:NO];
        }
            break;
            
        default:
            break;
    }
}

// 动画将要开始
-(void)mainButtonWillAnimation:(UIButton *)sender
{
    _mainView.mainBar.personInfoBtn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _mainView.mainBar.personInfoBtn.enabled = YES;
    });
}

#pragma mark - 点击个人信息的代理
-(void)clickPersonInfo
{
    [self goLeft];
}

#pragma mark - 左边的个人信息
- (void)addLayerAndLeftView
{
    
    //蒙层
    self.controll =[[UIControl alloc]initWithFrame:CGRectMake(-500, 0, 500, JDScreenSize.height)];
    self.controll.backgroundColor=[UIColor blackColor];
    self.controll.alpha=0.6;
    [self.controll addTarget:self action:@selector(goHide) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.controll];
    //添加从左边滑入的视图
    CGFloat selfW =JDScreenSize.width/3*2;
    self.myView =[[LeftTransparentView alloc]initWithFrame:CGRectMake(-1*selfW, 0, selfW, JDScreenSize.height)];
    self.myView.delegate = self;
    [self.view addSubview:self.myView];
}

#pragma mark - 左边视图的delegate
- (void)selectRow:(NSInteger)row
{
    [UIView animateWithDuration:.01 animations:^{
        self.myView.transform=CGAffineTransformIdentity;
        self.controll.transform=CGAffineTransformIdentity;
    }];
    switch (row)
    {
        case 0:
        {
            PersonalVC * vc =[[PersonalVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc addNavigationBar:@"个人中心"];
        }
            break;
        case 1:
        {
            MyPointViewController * vc =[[MyPointViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc addNavigationBar:@"积分明细"];
        }
            break;
        case 2:
        {
            //            VIPViewController * vc =[[VIPViewController alloc] init];
            JDVIPViewController *vc = [[JDVIPViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            //            [vc addNavigationBar:@"会员中心"];
        }
            break;
        case 3:
        {
            MyOrderViewController * vc =[[MyOrderViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc addNavigationBar:@"我的预约"];
            
        }
            break;
        case 4:
        {
            MyTool * t =[MyTool new];
            [self presentViewController:[t showAlertControllerWithTitle:@"温馨提示" WithMessages:@"正在开发中,敬请期待..." WithCancelTitle:@"确定"] animated:YES completion:nil];
        }
            break;
        case 5:
        {
            InviteViewController * vc =[[InviteViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc addNavigationBar:@"邀请副驾注册"];
        }
            break;
        case 6:
        {
            SetVC *vc = [[SetVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc addNavigationBar:@"设\t置"];
        }
            break;
        case 7:
        {
            
            JDAboutUsViewController *abVc = [[JDAboutUsViewController alloc] init];
            
            [self.navigationController pushViewController:abVc animated:YES];
            
        }
            break;
        default:
            break;
    }
}

//导航左边菜单点击事件
- (void)goLeft
{
    CGFloat myViewW=JDScreenSize.width/3*2;
    [UIView animateWithDuration:.01 animations:^{
        self.controll.transform=CGAffineTransformMakeTranslation(500, 0);
    }];
    
    [UIView animateWithDuration:.4 animations:^{
        self.myView.transform = CGAffineTransformMakeTranslation(myViewW, 0);
    }];
    
}

//点击右侧隐藏 抽屉
- (void)goHide
{
    [UIView animateWithDuration:0.04 animations:^
     {
         self.controll.transform=CGAffineTransformIdentity;
     }];
    
    [UIView animateWithDuration:0.4 animations:^
     {
         self.myView.transform=CGAffineTransformIdentity;
     }];
}

@end
