//
//  JDGoodsData.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDGoodsData : NSObject
/**
 *  所需积分
 */
@property (nonatomic, copy) NSString *cost;
/**
 *  商品名称
 */
@property (nonatomic, copy) NSString *goodName;
/**
 *  商品详情
 */
@property (nonatomic, copy) NSString *goodDetail;
/**
 *  商品已兑换数量
 */
@property (nonatomic, copy) NSString *goodCount;
/**
 *  商品id
 */
@property (nonatomic, assign) int id;
/**
 *  商品照片地址
 */
@property (nonatomic, strong) NSURL *imgAddress;

+(instancetype)goodsDataWithDict:(NSDictionary *)dict;

@end
