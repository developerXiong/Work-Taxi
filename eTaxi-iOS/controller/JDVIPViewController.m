//
//  JDVIPViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/3/21.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDVIPViewController.h"
#import "HeadFile.pch"
#import "UIView+UIView_CYChangeFrame.h"
#import "JDVipView.h"
#import "JDVipRulesViewController.h"
#import "JDVipPowerViewController.h"
#import "GetData.h"
#import "NSString+StringForUrl.h"
#import "JDGetVipinfoTools.h"
#import "JDVipInfoData.h"

#import "JDVipAnimationView.h"

#import "UIImage+GIF.h"

@interface JDVIPViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

/**
 *  顶部的背景
 */
@property (weak, nonatomic) IBOutlet UIImageView *topMainView;
/**
 *  会员名字
 */
@property (weak, nonatomic) IBOutlet UILabel *vipName;
/**
 *  会员等级
 */
@property (weak, nonatomic) IBOutlet UILabel *vipLevel;
/**
 *  当前的信用积分
 */
@property (weak, nonatomic) IBOutlet UILabel *currentScroe;
/**
 *  已推荐人数
 */
@property (weak, nonatomic) IBOutlet UILabel *reRecommendCount;
/**
 *  会员等级对应的图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *levelImage;

@end

//static NSTimer *timer;
//static int peopleCount; //推荐的人数

@implementation JDVIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    _index = 0;
//    _animationIndex = 0;
    
    self.view.backgroundColor = ViewBackgroundColor;
    
    [self setUpSubviews]; 
    
}
- (IBAction)clickBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)setUpSubviews
{
    [JDGetVipinfoTools GetVipInfoSuccess:^(NSMutableDictionary *dictArr) {
        
        JDVipInfoData *vipData = dictArr[@"vipInfo"];
        
        //设置vipName
        if (NAME) {
            _vipName.text = NAME;
            
        }else{
            _vipName.text = @"未审核";
        }
        
        //设置信用积分数
        _currentScroe.text = vipData.creditScore;
        
        //设置会员等级
        NSString *grade = vipData.grade;
        _vipLevel.text = grade;
        if ([grade isEqualToString:@"普通会员"]) {

            _levelImage.image = [UIImage imageNamed:@"普通会员1"];
            _topMainView.image = [UIImage imageNamed:@"普通会员高亮"];
        }else if ([grade isEqualToString:@"白金会员"]){

            _levelImage.image = [UIImage imageNamed:@"白金会员1"];
            _topMainView.image = [UIImage imageNamed:@"白金会员高亮"];
        }else if ([grade isEqualToString:@"钻石会员"]){

            _levelImage.image = [UIImage imageNamed:@"钻石会员1"];
            _topMainView.image = [UIImage imageNamed:@"钻石会员高亮"];
        }else {
            _levelImage.image = [UIImage imageNamed:@"普通会员1"];
            _topMainView.image = [UIImage imageNamed:@"普通会员高亮"];
        }
        
        //人数
        _reRecommendCount.text = [NSString stringWithFormat:@"%@",vipData.referrals];
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    /**
      *  tableview
      */
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, JDScreenSize.height*476/667, JDScreenSize.width, 100) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;

}

#pragma mark - tableView delegate & datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSArray *textArr = @[@"会员规则",@"会员特权"];
    
    cell.textLabel.text = textArr[indexPath.row];
    cell.textLabel.textColor = BLACKCOLOR;
    
    //添加一条线
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, JDScreenSize.width, 0.5)];
    line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [cell.contentView addSubview:line];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//选中一行之后
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        JDVipRulesViewController *rulesVC = [[JDVipRulesViewController alloc] init];
        [self.navigationController pushViewController:rulesVC animated:YES];
    }else{
        JDVipPowerViewController *powerVC = [[JDVipPowerViewController alloc] init];
        [self.navigationController pushViewController:powerVC animated:YES];
    }
    
}



//-(void)setUpSubviews
//{
//    /**
//     *  vipView
//     */
//    JDVipView *vipView = [[JDVipView alloc] init];
//    _vipView = vipView;
//    [self.view addSubview:vipView];
//    
//    UIImage *image = [UIImage imageNamed:@"返回"];
//    CGSize imageS = [image size];
//    /**
//     *  返回按钮
//     */
//    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_backBtn setFrame:CGRectMake(8, 28, imageS.width, imageS.height)];
//    [_backBtn setImage:image forState:UIControlStateNormal];
//    [_backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
//    [vipView addSubview:_backBtn];
//    
//    /**
//     *  tableview
//     */
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(vipView.frame), JDScreenSize.width, 100) style:UITableViewStylePlain];
//    [self.view addSubview:_tableView];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.scrollEnabled = NO;
//    if (JDScreenSize.width==320&&JDScreenSize.height==480) {
//        _tableView.scrollEnabled = YES;
//        _tableView.height = 75;
//    }
//
//}
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//       
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        params[@"phoneNo"] = PHONENO;
//        params[@"password"] = PASSWORD;
//        params[@"loginTime"] = LOGINTIME;
//        
//        [GetData getDataWithUrl:[NSString urlWithApiName:@"getVipInfo.json"] params:params success:^(id response) {
//            
//            NSLog(@"%@",response);
//            int returnCode = [response[@"returnCode"] intValue];
//            if (returnCode == 0) {
//                
//                NSMutableDictionary *data = [NSMutableDictionary dictionary];
//                data[@"creditScore"] = response[@"creditScore"]; //信用积分
//                data[@"grade"] = response[@"grade"]; //会员等级
//                data[@"referrals"] = response[@"referrals"]; //推荐人数
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                   
//                    [self addVipBackground:data];
//                    
//                });
//                
//            }
//            
//        } failure:^(NSError *error) {
//            
//            NSLog(@"%@",error);
//            
//        }];
//        
//    });
//    
//}
//
//#pragma mark - 添加Vip背景图及animation
//-(void)addVipBackground:(NSMutableDictionary *)data
//{
//    
//    /**
//     *  动画animation
//     */
//    int margin = [data[@"referrals"] intValue]; //推荐几个人
//    peopleCount = margin;
//    CGFloat startPoint = M_PI*4/5;// 动画起点
//    
//    if (margin==0) {
//        margin = 1;
//    }
//    if (margin>=70) {
//        margin=70;
//    }
//    
//    _vipAnimationView = [[JDVipAnimationView alloc] initWithFrame:_vipView.bounds];
//    [_vipAnimationView createAnimation:startPoint andEndAngle:startPoint+M_PI/75*margin*2/3];
//    startPoint = M_PI*9/10;
//    [_vipAnimationView createTextAnimation:startPoint andEndAngle:startPoint+M_PI/100*margin*2/3];
//    [_vipView.mainView addSubview:_vipAnimationView];
//    
//    timer = [NSTimer scheduledTimerWithTimeInterval:2/(peopleCount+1) target:self selector:@selector(numberChange) userInfo:nil repeats:YES];
//    [timer fire];
//    
//    //推荐乘客次数
//    _vipView.commendCount.text = [NSString stringWithFormat:@"%d次",peopleCount];
//    //信用积分
//    _vipView.creditCount.text = [NSString stringWithFormat:@"%@",data[@"creditScore"]];
//    //
//    _vipView.nameLabel.text = NAME;
//    //
//    _vipView.memberLevel.text = [NSString stringWithFormat:@"%@",data[@"grade"]];
//    
//}
//
//-(void)numberChange
//{
//    _vipAnimationView.commendText.text = [NSString stringWithFormat:@"%d次推荐",_index];
//    if (_index==peopleCount) {
//        [timer invalidate];
//    }
//    _index ++;
//}
//
//-(void)clickBack
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

@end
