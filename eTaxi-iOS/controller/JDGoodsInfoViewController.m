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

@interface JDGoodsInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

/**商品的数量*/
@property (nonatomic, assign) int gCount;

@end

@implementation JDGoodsInfoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_gCount == 1) {
        
        self.minus.enabled = NO;
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _gCount = 1;
    
    //取消tableview的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)setGoodsData:(JDGoodsData *)goodsData
{
    _goodsData = goodsData;
    
    self.exchangeCount.text = [NSString stringWithFormat:@"  商品已被兑换%@件",goodsData.goodCount];
    
    self.needPoint.text = [NSString stringWithFormat:@"%@",goodsData.cost];
    
}

-(void)setDetailImage:(UIImage *)detailImage
{
    _detailImage = detailImage;
    
    NSLog(@"%@",detailImage);
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
    
    static NSString *ID = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if ([_goodsData.goodDetail length]) {

        // 详情图片
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, [_detailImage size].height)];
        [cell.contentView addSubview:imageV];
        imageV.image = _detailImage;
        
        NSLog(@"%@",_detailImage);
        
    }

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [_detailImage size].height;
}


@end
