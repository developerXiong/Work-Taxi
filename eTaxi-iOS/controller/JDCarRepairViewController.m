//
//  JDCarRepairViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/1/20.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDCarRepairViewController.h"
#import "HeadFile.pch"
#import "JDCarRepairView.h"
#import "JDRepairViewController.h"
#import "GetData.h"
#import "NSString+StringForUrl.h"
#import "JDDatePickerView.h"
#import "UIViewController+CustomModelView.h"
#import "JDIsNetwork.h"
#import "MyOrderViewController.h"

@interface JDCarRepairViewController ()<JDRepairDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) JDCarRepairView *carView;

@property (nonatomic, strong) NSMutableArray *topStr; //接收维修项目string

 /**自定义datepicker*/
@property (nonatomic, strong) JDDatePickerView *datePickerView;

/**添加时间框*/
@property (nonatomic, strong) UIView *proView;

/**添加蒙层*/
@property (nonatomic, strong) UIButton *mengc;

/**
 *  维修点ID
 */
@property (nonatomic, copy) NSString *repairID;

@end

@implementation JDCarRepairViewController

-(NSMutableArray *)topStr
{
    if (_topStr == nil) {
        _topStr = [NSMutableArray array];
    }
    return _topStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置整个界面的视图
    [self setUpAllView];
    
    //添加蒙层
    [self addMengc];
    
    //添加时间选择框
    [self addRepairTime];
    
    
}

//添加蒙层
-(void)addMengc
{
    
    UIButton *mengc = [UIButton buttonWithType:UIButtonTypeCustom];
    _mengc = mengc;
    [mengc setFrame:CGRectMake(0, 0, JDScreenSize.width, JDScreenSize.height)];
    mengc.hidden = YES;
    [mengc addTarget:self action:@selector(clickMengc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mengc];
    
}

//显示蒙层
-(void)showMengc
{
    self.mengc.hidden = NO;
}

//隐藏蒙层
-(void)hiddenMengc
{
    
    self.mengc.hidden = YES;
}

/**点击蒙层调用*/
-(void)clickMengc
{
    [self hiddenTime];
    [self hiddenMengc];
}

//设置整个界面的视图
-(void)setUpAllView
{
    //整体的view
    JDCarRepairView *carView = [[JDCarRepairView alloc] initWithFrame:CGRectMake(0, 44, JDScreenSize.width, JDScreenSize.height-44)];
    _carView = carView;
    [self.view addSubview:carView];
    
    carView.contentSize = CGSizeMake(JDScreenSize.width,carView.mainView.bounds.size.height+carView.bottomV.bounds.size.height);
    
//    点击维修点调用
    [carView.repairBtn addTarget:self action:@selector(clickRepair) forControlEvents:UIControlEventTouchUpInside];
    
    //点击预约按钮调用
    [carView.commitBtn addTarget:self action:@selector(clickMainten) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i =0; i < 9; i ++) {
        UIButton *statusBtn = [carView viewWithTag:1000 + i];
        [statusBtn addTarget:self action:@selector(clickCagetory:) forControlEvents:UIControlEventTouchUpInside];
        
        statusBtn.selected = YES;
    }
    
    [carView.timeBtn addTarget:self action:@selector(clickTime) forControlEvents:UIControlEventTouchUpInside];
    
    
}

/**点击时间框调用*/
-(void)clickTime
{
    
    [self showTime];
    [self showMengc];
    
}

-(void)showTime
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.proView.transform = CGAffineTransformMakeTranslation(0, -self.proView.bounds.size.height);
        
    }];
}

-(void)hiddenTime
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.proView.transform = CGAffineTransformIdentity;
        
    }];
}

//添加时间框
-(void)addRepairTime
{
    CGFloat proCX = 0;
    CGFloat proCY = JDScreenSize.height;
    CGFloat proCW = JDScreenSize.width;
    CGFloat proCH = JDScreenSize.height * 2 / 5;
    /*************维修预约时间的选择框*************/
    UIView *proView = [[UIView alloc] initWithFrame:CGRectMake(proCX, proCY, proCW, proCH)];
    _proView = proView;
    proView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:proView];
    
    //确定取消按钮的视图
    CGFloat rowH = 50; //按钮的高度
    UIView *cancel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, proView.bounds.size.width, rowH)];
    [proView addSubview:cancel];
    
    /**确定取消按钮的下方的线条*/
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, rowH - 0.5, JDScreenSize.width, 0.5)];
    line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [cancel addSubview:line];
    
    //取消按钮
    UIButton *canBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [canBtn setFrame:CGRectMake(0, 0, 100, rowH)];
    [canBtn setTitle:@"取消" forState:UIControlStateNormal];
    [canBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    //文字向左对齐
    canBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //距离左边的间距
    canBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [canBtn addTarget:self action:@selector(clickTimeCancel) forControlEvents:UIControlEventTouchUpInside];
    [cancel addSubview:canBtn];
    
    //确定按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setFrame:CGRectMake(proView.bounds.size.width - 100, 0, 100, rowH)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    //文字向左对齐
    sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //距离左边的间距
    sureBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [sureBtn addTarget:self action:@selector(clickTimeSure) forControlEvents:UIControlEventTouchUpInside];
    [cancel addSubview:sureBtn];
    
    //自定义datepicker
    JDDatePickerView *datePicker = [[JDDatePickerView alloc] initWithFrame:CGRectMake(0, rowH, proView.bounds.size.width, proView.bounds.size.height - rowH)];
    _datePickerView = datePicker;
    [proView addSubview:datePicker];
    
}

//点击确定按钮调用
-(void)clickTimeSure
{
    [self hiddenTime];
    
    
    if (self.datePickerView.selectTimeStr) {
        
        [self.carView.timeBtn setTitle:self.datePickerView.selectTimeStr forState:UIControlStateNormal];
        
    }
    
    [self hiddenMengc];
    
}

//点击取消按钮调用
-(void)clickTimeCancel
{
    [self hiddenTime];
    
    [self hiddenMengc];
}

#pragma mark - 点击维修项目调用
-(void)clickCagetory:(UIButton *)btn
{

    UIImageView *place = [[UIImageView alloc] init];
    for (UIView *view in btn.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            
            place = (UIImageView *)view;
            
        }
    }
    
    UILabel *label = nil;
    for (UIView *view in btn.subviews) {
        
        if ([view isKindOfClass:[UILabel class]]) {
            
            label = (UILabel *)view;
            
        }
        
    }
    
    NSArray *textArr = @[@0,@1,@2,@3,@4,@5,@6,@7,@8];
    NSArray *imageArr = [NSArray array];
    if (btn.selected) {
        
        [self.topStr addObject:textArr[btn.tag - 1000]];
        
        imageArr = @[@"更换机油_选择状态",@"常规检修_选择状态",@"电路检修_选择状态",@"变速箱检修_选择状态",@"电瓶检修_选择状态",@"发动机修理_选择状态",@"钣金做漆_选择状态",@"机械修理_选择状态",@"胎压_选择状态"];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"蓝色按下底图"] forState:UIControlStateNormal];
        
        label.textColor = [UIColor whiteColor];
        
    }else if(!btn.selected){

        [self.topStr removeObject:textArr[btn.tag - 1000]];
        
        imageArr = @[@"更换机油",@"常规检修",@"电路检修",@"变速箱检修",@"电瓶检修",@"发动机修理",@"钣金做漆",@"机械修理",@"胎压"];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"白色底图"] forState:UIControlStateNormal];
        
        label.textColor = BLACKCOLOR;
    }
    
    place.image = [UIImage imageNamed:imageArr[btn.tag-1000]];
    
    btn.selected =! btn.selected;
    
}

#pragma mark - 动画


//点击维修点调用
-(void)clickRepair
{
    [UIView animateWithDuration:0.3 animations:^{
       
        self.carView.timeView.transform = CGAffineTransformIdentity;
        self.carView.proView.transform = CGAffineTransformIdentity;
        
    }];
    
    self.carView.timeBtn.selected = YES;
    self.carView.projectBtn.selected = YES;
    
    JDRepairViewController *repairVC = [[JDRepairViewController alloc] init];
    
    [self.navigationController pushViewController:repairVC animated:YES];
    
    repairVC.delegate = self;

}

//点击预约按钮调用
-(void)clickMainten
{
    if (![JDIsNetwork sharedInstance]) {
        
        [GetData addAlertViewInView:self title:@"温馨提示" message:@"网络无连接" count:0 doWhat:^{
            
        }];
        
    }else{
        
        /**
         *  预约时间的button上的时间
         */
        NSString *timeStr = self.carView.timeBtn.titleLabel.text;
        /**
         *  预约的时间 年月日string
         */
        NSString *dateTime = [timeStr substringToIndex:10];
        dateTime = [dateTime stringByReplacingOccurrencesOfString:@"/" withString:@""];

        /**
         *  预约的时间 小时
         */
        NSString *hourTime = [timeStr substringFromIndex:16];
        hourTime = [hourTime substringToIndex:2];
        
        /**
         *  维修项目string
         */
        NSMutableString *repairPro = [NSMutableString string];
        
        if (self.topStr.count == 0) { //如果没有选择维修项目
            
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"请选择维修项目!" count:0 doWhat:^{
                
            }];
            
        }else if(!self.repairID){ //如果没有选择维修点
            
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"请选择维修点!" count:0 doWhat:^{
                
//                JDRepairViewController *repairVC = [[JDRepairViewController alloc] init];
//                
//                [self presentViewC:repairVC animation:YES];
                
            }];
            
        }else{
            
            
            for (int i = 0; i < self.topStr.count; i ++) {
                
                
                repairPro = (NSMutableString *)[repairPro stringByAppendingString:[NSString stringWithFormat:@"%@,",self.topStr[i]]];
                
            }
            repairPro = (NSMutableString *)[repairPro substringToIndex:self.topStr.count*2-1];
            
            [GetData addAlertViewInView:self title:@"温馨提示" message:@"您确定要预约吗？" count:1 doWhat:^{
                
                [GetData addMBProgressWithView:self.view style:0];
                [GetData showMBWithTitle:@"正在预约..."];
                
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                params[@"type"] = @"2";
                params[@"phoneNo"] = PHONENO;
                params[@"password"] = PASSWORD;
                params[@"loginTime"] = LOGINTIME;
                //        params[@"role"] = @"0"; //身份 0出租车，1乘客
                if (self.repairID) {
                    
                    params[@"addressId"] = self.repairID; //维修点ID
                }else{
                    params[@"addressId"] = @"1";
                }
                params[@"optionIdList"] = repairPro; //维修项目ID
                params[@"dateStart"] = dateTime; //预约时间
                params[@"startTime"] = hourTime; // 小时 24小时制
                
                
                [GetData getDataWithUrl:[NSString urlWithApiName:@"getReservationInfo.json"] params:params success:^(id response) {
                    
                    NSString *string = @"";
                    
                    int returnCode = [response[@"returnCode"] intValue];
                    
                    if(returnCode == 0){
                        
                        [GetData hiddenMB];
                        
                        if (response[@"wait"]) {
                            
                            string = [NSString stringWithFormat:@"预约成功！请到‘我的预约中’查看您的预约状态！超过%@未到指定维修点进行维修视为放弃预约！",response[@"wait"]];
                            
                            
                        }else{
                            
                            string = [NSString stringWithFormat:@"预约成功！请到‘我的预约中’查看您的预约状态！"];
                            
                        }
                        
                        
                    }else if(returnCode ==2){//强制退出
                        
                        [GetData addAlertViewInView:self title:@"温馨提示" message:[NSString stringWithFormat:@"%@",response[@"msg"]] count:0 doWhat:^{
                            
//                            NSLog(@"success");
                            /**
                             *  执行强制退出
                             */
                            PersonalVC *p = [[PersonalVC alloc] init];
                            [p removeFileAndInfo];
                            
                        }];
                        
                    }else{
                        [GetData hiddenMB];
                        
                        string = response[@"msg"];
                        
                    }
                    
                    /**
                     *  预约成功之后跳转界面
                     */
                    [GetData addAlertViewInView:self title:@"温馨提示" message:string count:0 doWhat:^{
                        if (returnCode==0) {
                            
                            MyOrderViewController *orderView = [[MyOrderViewController alloc] init];
                            [orderView addNavigationBar:@"我的预约"];
                            [self.navigationController pushViewController:orderView animated:YES];
                            
                            UIButton *btn = (UIButton *)[orderView.view viewWithTag:502];
                            [btn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
                            
                        }
                        
                        
                    }];
                    
                } failure:^(NSError *error) {
                    
//                    NSLog(@"error----->%@",error);
                    [GetData hiddenMB];
                    [GetData addAlertViewInView:self title:@"温馨提示" message:@"预约失败" count:0 doWhat:nil];
                    
                }];
                
            }];
            
        }
        
    }
    
}
//返回主界面
-(void)clickBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];

}

#pragma mark - repairVC delegate
-(void)setRepairName:(NSString *)repairName repairID:(NSString *)repairID
{
    [self.carView.repairBtn setTitle:repairName forState:UIControlStateNormal];
    
    _repairID = repairID;
    
}

@end
