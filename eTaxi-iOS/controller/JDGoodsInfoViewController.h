//
//  JDGoodsInfoViewController.h
//  eTaxi-iOS
//
//  Created by jeader on 16/3/10.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JDGoodsData.h"

@protocol JDGoodsInfoDelegate <NSObject>

@optional

-(void)clickExchangeBtn:(int)count goodsID:(int)goodsID;

@end

@interface JDGoodsInfoViewController : UIViewController
/**
 *  整个底部视图
 */
@property (weak, nonatomic) IBOutlet UIView *botView;
/**
 *  所需积分
 */
@property (weak, nonatomic) IBOutlet UILabel *needPoint;
/**
 *  购买数量
 */
@property (weak, nonatomic) IBOutlet UILabel *buyCount;
/**
 *  立刻兑换按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *exchange;
/**
 *  tableview
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  取消按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *cancel;

/**
 *  接受数据的字典
 */
@property (nonatomic, strong)NSDictionary *dataDict;
/**
 *  减少数量
 */
@property (weak, nonatomic) IBOutlet UIButton *minus;
/**
 *  数量
 */
@property (weak, nonatomic) IBOutlet UIButton *count;
/**
 *  增加数量
 */
@property (weak, nonatomic) IBOutlet UIButton *plus;
/**
 *  已被兑换的数量
 */
@property (weak, nonatomic) IBOutlet UILabel *exchangeCount;

@property (nonatomic, strong) JDGoodsData *goodsData;

/**
 *  代理
 */
@property (nonatomic, assign) id<JDGoodsInfoDelegate>delegate;

@property (nonatomic, strong) UIImage *detailImage;

@end
