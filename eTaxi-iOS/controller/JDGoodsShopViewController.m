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
#import "UIImageView+WebCache.h"
#import "UIImage+MultiFormat.h"

#import "JDNoMessageView.h"


@interface JDGoodsShopViewController ()<JDGoodsViewDelegate,JDGoodsInfoDelegate>

@property (nonatomic, weak) JDGoodsView *goodsView;

/**
 *  传递到物品详情界面的图片ImageV
 */
@property (nonatomic, strong) UIImageView *detailImageV;

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
-(void)goodsViewSelectItem:(NSInteger)index
{
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//       
//        
    JDGoodsData *goodsData = _goodsView.modelArr[index];
    
    UIImageView *detailImageV = nil;
    UIImage *image = [UIImage sd_imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:goodsData.goodDetail]]];
    
    if (image) { // 防止图片为空的情况
        
        CGSize imageS = [image size];
        CGFloat scale = imageS.height/imageS.width , imageVW = JDScreenSize.width, imageVH = imageVW*scale;
        
        detailImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageVW, imageVH)];
        detailImageV.image = image;
        //    detailImageV.contentMode = UIViewContentModeScaleAspectFit;
        
        JDLog(@"----%@",detailImageV.image);
    }else { // 没有图片
        
        detailImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, 500/2)];
        JDNoMessageView *noView = [[JDNoMessageView alloc] initWithFrame:detailImageV.bounds];
        noView.message = @"当前物品没有详情图片,请与商家联系添加!";
        [detailImageV addSubview:noView];
        JDLog(@"----%@",detailImageV.subviews);
    }
    
        dispatch_async(dispatch_get_main_queue(), ^{
            
            JDGoodsInfoViewController *goodsInfo = [[JDGoodsInfoViewController alloc] init];
            
            goodsInfo.index = index;
            
            goodsInfo.delegate = self;
            
            goodsInfo.detailImageV = detailImageV;
            
            [self presentViewController:goodsInfo animated:YES completion:nil];
            
        });
        
//    });
    
    
}

#pragma mark - goods view delegate
-(void)clickExchangeBtn:(int)count goodsID:(int)goodsID totalCosts:(NSInteger)costs
{
    // 剩余积分
    NSInteger costses;
    if (SCORE) {
        
        costses = [[NSString stringWithFormat:@"%@",SCORE] integerValue];
    }else {
        costses = 0;
    }
    
    if (costses<costs) {
        [GetData addAlertViewInView:self title:@"温馨提示" message:@"您的积分余额不足!" count:0 doWhat:^{
            
        }];
    }else {
        [JDGoodsHttpTool exchangeGoodsWithCount:count goodsID:goodsID inVc:self success:^(int status) {
            
            UsingRecordViewController *useVC = [[UsingRecordViewController alloc] init];
            [self.navigationController pushViewController:useVC animated:YES];
            [useVC addNavigationBar:@"兑换记录"];
            
        } failure:^(NSError *error) {
            
        }];
    }
    
}

@end
