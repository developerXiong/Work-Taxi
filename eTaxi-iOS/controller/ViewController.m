//
//  ViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 15/12/31.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import "ViewController.h"
#import "MyTool.h"
#import "JDLoginVC.h"
#import "HeadFile.pch"
#import "GetData.h"
#import "NSString+StringForUrl.h"
#import "MyData.h"
#import "PersonalVC.h"
#import "JDMianViewController.h"


@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ViewController

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BOOL isLogin =[MyTool isLogin];

    if (!isLogin)
    {
        /**
         *  是第一次登录
         */
        [self goLogin];
    }
    else
    {
        /**
         *  非首次登陆,直接跳过登陆过程
         */
        
        [self goMain];
    }
        
}

- (void)goMain
{
    
    JDMianViewController * homeVC_ =[[JDMianViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeVC_];
    nav.navigationBar.hidden = YES;
    UIWindow * window =[[[UIApplication sharedApplication]delegate]window];
    window.rootViewController=nav;

}

- (void)goLogin
{
    JDLoginVC * vc =[[JDLoginVC alloc] init];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.hidden = YES;
    UIWindow * window =[[[UIApplication sharedApplication]delegate]window];
    window.rootViewController=nav;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
