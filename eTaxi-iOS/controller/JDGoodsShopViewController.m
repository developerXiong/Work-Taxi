//
//  JDGoodsShopViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDGoodsShopViewController.h"

#import "JDGoodsView.h"

#import "HeadFile.pch"

#import "JDGoodsData.h"
#import "JDGoodsHttpTool.h"

#import "JDGoodsInfoViewController.h"

#import "UsingRecordViewController.h"

#import "JDGoodsTools.h"


@interface JDGoodsShopViewController ()<JDGoodsViewDelegate,JDGoodsInfoDelegate>

@property (nonatomic, weak) JDGoodsView *goodsView;

@end

@implementation JDGoodsShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加子视图
    [self setUpAllChildViews];
    
    [self addNavigationBar:@"积分商城"];
    [self addRightBtnWithImage:@"分享" action:@selector(clickShare)];
    
    [self getData];
}

-(void)getData
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [JDGoodsHttpTool getGoodsInfoInVC:self Success:^(NSMutableArray *modelArr) {
            
            JDLog(@"modelArr=====%@",modelArr);
            
            dispatch_async(dispatch_get_main_queue(), ^{
               _goodsView.modelArr = modelArr; 
            });
            
        } failure:^(NSError *error) {
            
        }];
    });
    
}

//点击分享按钮调用
-(void)clickShare
{
    
    /**
     *  自定义分享界面
     */
    [JDGoodsTools shareUMInVc:self];
    
}

#pragma mark - 添加子视图
-(void)setUpAllChildViews
{
    JDGoodsView *goodsView = [[JDGoodsView alloc] initWithFrame:CGRectMake(0, 64, JDScreenSize.width, JDScreenSize.height-64)];
    [self.view addSubview:goodsView];
    goodsView.delegate=self;
    _goodsView = goodsView;
}

#pragma mark - goodsView delegate
-(void)goodsViewSelectItem:(JDGoodsData *)data
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data.goodDetail]]];
        
        UIImage *image = [UIImage imageWithData:imageData];
//        
//        JDLog(@"%@",data.goodDetail);
//        
//        JDLog(@"%@",image);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            JDGoodsInfoViewController *goodsInfo = [[JDGoodsInfoViewController alloc] init];
            
            goodsInfo.detailImage = image;
            
            
            goodsInfo.goodsData = data;
            
            goodsInfo.delegate = self;
            
            [self presentViewController:goodsInfo animated:YES completion:nil];
            
        });
        
    });

    
}

#pragma mark - goods view delegate
-(void)clickExchangeBtn:(int)count goodsID:(int)goodsID
{
    
    [JDGoodsHttpTool exchangeGoodsWithCount:count goodsID:goodsID inVc:self success:^(int status) {
       
        UsingRecordViewController *useVC = [[UsingRecordViewController alloc] init];
        [self.navigationController pushViewController:useVC animated:YES];
        [useVC addNavigationBar:@"兑换记录"];
        
    } failure:^(NSError *error) {
        
    }];
}

@end
