//
//  JDGoodsInfoViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/3/10.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDGoodsInfoViewController.h"
#import "HeadFile.pch"
#import "UIImageView+WebCache.h"
#import "UIImage+AFNetworking.h"

#import "JDGoodsData.h"
#import "JDGoodsHttpTool.h"

#import "UIView+UIView_CYChangeFrame.h"

@interface JDGoodsInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

/**商品的数量*/
@property (nonatomic, assign) int gCount;

/**
 *   商品详情图片
 */
@property (nonatomic, strong) UIImageView *detailImageV;

@end

@implementation JDGoodsInfoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_gCount == 1) {
        
        self.minus.enabled = NO;
        [self getData];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _gCount = 1;

    //取消tableview的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = 500;
    
}

// 请求数据
-(void)getData
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        [JDGoodsHttpTool getGoodsInfoInVC:self Success:^(NSMutableArray *modelArr) {
            
            JDGoodsData *goodsData = modelArr[_index];
            _goodsData = goodsData;
            
            NSURL *url = [NSURL URLWithString:goodsData.goodDetail];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                self.needPoint.text = goodsData.cost;
                self.exchangeCount.text = [NSString stringWithFormat:@"商品已被兑换%d件",[goodsData.goodCount intValue]];
                
                _detailImageV.image = image;
                _detailImageV.height = [image size].height;
                self.tableView.rowHeight = [image size].height;
                _detailImageV.contentMode = UIViewContentModeScaleToFill;
                
                
            });
            
        } failure:^(NSError *error) {
            
        }];
        
    });
    
    
//    self.needPoint.text = _goodsData.cost;
//    self.exchangeCount.text = [NSString stringWithFormat:@"商品已被兑换%d件",[_goodsData.goodCount intValue]];
//    
//    _detailImageV.contentMode = UIViewContentModeScaleToFill;
    
}

//点击立刻兑换按钮调用
- (IBAction)exchange:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    if ([_delegate respondsToSelector:@selector(clickExchangeBtn:goodsID:)]) {
        
        [_delegate clickExchangeBtn:_gCount goodsID:_goodsData.id];
        
    }
    
    
}

//点击取消按钮调用
- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

//点击增加数量按钮
- (IBAction)plus:(id)sender {
    
    self.minus.enabled = YES;
    
    _gCount ++;
    
    self.needPoint.text = [NSString stringWithFormat:@"%d",_gCount * [_goodsData.cost intValue]];
    
    [self.count setTitle:[NSString stringWithFormat:@"%d",_gCount] forState:UIControlStateNormal];
}

//点击减少数量按钮
- (IBAction)minus:(id)sender {

    UIButton *btn = (UIButton *)sender;
    
    if (_gCount == 2) {

        btn.enabled = NO;
    }

    _gCount --;
    
    self.needPoint.text = [NSString stringWithFormat:@"%d",_gCount*[_goodsData.cost intValue]];

    [self.count setTitle:[NSString stringWithFormat:@"%d",_gCount] forState:UIControlStateNormal];
    
}

#pragma mark - tableView delegate&datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 详情图片
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, 756)];
    _detailImageV = imageV;
    [cell.contentView addSubview:imageV];
    
    return cell;
}


@end
