//
//  JDMorethanViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/29.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMorethanViewController.h"

#import "HeadFile.pch"

#import "JDMessgeViewController.h"
#import "JDGoodsShopViewController.h"

@interface JDMorethanViewController ()

/**
 *  推送的消息
 */
@property (nonatomic, strong)NSMutableArray *pushArr;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBtn;

@end

@implementation JDMorethanViewController

-(NSMutableArray *)pushArr
{
    if (_pushArr == nil) {
        
        _pushArr = [NSMutableArray array];
        
        
        
    }
    return _pushArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNavigationBar:@"更多"];
    
    if (JDScreenSize.width == 320) {
        self.leftBtn.constant = 35;
        self.rightBtn.constant = 35;
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (PUSHDATA) {
        
        for (NSDictionary *dict in PUSHDATA) {
            
            [_pushArr addObject:dict];
            
        }
    }
    
}

// 点击消息
- (IBAction)clickShop:(id)sender {
    
    
    
    NSMutableArray *newArr = [NSMutableArray array];
    
    for (NSDictionary *dict in self.pushArr) {
        
        
        NSMutableDictionary *dddd = [NSMutableDictionary dictionary];
        
        [dddd setValuesForKeysWithDictionary:dict];
        
        if ([dddd[@"flag"] intValue] == 0) {
            
            [dddd setValue:@"1" forKey:@"flag"];
            
        }
        
        [newArr addObject:dddd];
        
    }
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:newArr forKey:@"pushArr"];
    [user synchronize];
    
    JDMessgeViewController *messVc = [[JDMessgeViewController alloc] init];
    messVc.dataArr = newArr;
    [self.navigationController pushViewController:messVc animated:YES];
    
}

// 点击积分商城
- (IBAction)clickMessage:(id)sender {
    
    JDGoodsShopViewController *messVc = [[JDGoodsShopViewController alloc] init];
    [self.navigationController pushViewController:messVc animated:YES];
}

@end
