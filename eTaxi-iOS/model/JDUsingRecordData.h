//
//  JDUsingRecordData.h
//  eTaxi-iOS
//
//  Created by jeader on 16/5/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDUsingRecordData : NSObject
/**
 *  兑换物品的花费 -42
 */
@property (nonatomic, copy) NSString *cost;
/**
 *  兑换物品的名称
 */
@property (nonatomic, copy) NSString *costName;
/**
 *  兑换的数量
 */
@property (nonatomic, copy) NSString *costNumber;
/**
 *  兑换物品的图片 地址
 */
@property (nonatomic, copy) NSString *imageUrl;
/**
 *  兑换的时间
 */
@property (nonatomic, copy) NSString *updateDate;
/**
 *  兑换地址
 */
@property (nonatomic, copy) NSString *shopAddress;
/**
 *  物品的兑换状态 0：未兑换，1：  已兑换 服务器返回的
 */
@property (nonatomic, copy) NSString *useStatus;
/**
 *  兑换码
 */
@property (nonatomic, copy) NSString *orderNo;
/**
 *  兑换码使用的日期
 */
@property (nonatomic, copy) NSString *useDate;

/**  处理过的数据  */
/**
 *  数量
 */
@property (nonatomic, copy) NSString *count;
/**
 *  单价
 */
@property (nonatomic, copy) NSString *price;
/**
 *  总价
 */
@property (nonatomic, copy) NSString *total;


/**
 *  字典转模型
 */
+(instancetype)usingrecordDataWithDictionary:(NSDictionary *)dict;

+(NSMutableArray *)dataArrWithArray:(NSArray *)modelArr;

@end
