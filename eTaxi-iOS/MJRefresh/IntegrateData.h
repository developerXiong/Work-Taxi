//
//  IntegrateData.h
//  eTaxi-iOS
//
//  Created by jeader on 16/1/6.
//  Copyright © 2016年 jeader. All rights reserved.
//  积分兑换的数据模型

#import <Foundation/Foundation.h>



@interface IntegrateData : NSObject<NSCoding>

//商品图片路径数组
@property (nonatomic, strong)NSArray *goodsImages;

//商品ID
@property (nonatomic, copy)NSString *goodsID;

//商品名称
@property (nonatomic, copy)NSString *name;

//商品兑换积分
@property (nonatomic, assign)int point;

//商品详细内容图片组
@property (nonatomic, strong)NSArray *detailImages;

//评论
@property (nonatomic, strong)NSArray *comments;

//商家说明
@property (nonatomic, copy)NSString *importantInfo;

//商家详细地址
@property (nonatomic, copy)NSString *address;

//经度
@property (nonatomic, copy)NSString *longitude;

//维度
@property (nonatomic, copy)NSString *latitude;

//成交记录
@property (nonatomic, assign)int dealRecord;

+(instancetype)integrateDataWithDictionary:(NSDictionary *)dict;

@end
