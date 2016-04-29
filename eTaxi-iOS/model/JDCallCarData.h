//
//  JDCallCarData.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDCallCarData : NSObject
/**
 *  乘客手机号
 */
@property (nonatomic, copy) NSString *passengerPhoneNo;
/**
 *  乘车时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  乘车地点
 */
@property (nonatomic, copy) NSString *address;
/**
 *  目的地
 */
@property (nonatomic, copy) NSString *destination;
/**
 *  用车类型 0:现在用车，1：预约用车
 */
@property (nonatomic, copy) NSString *useType;
/**
 *  单子编号
 */
@property (nonatomic, copy) NSString *number;
/**
 *  订单状态，type为3的时候需要
 */
@property (nonatomic, copy) NSString *orderStatus;

+(instancetype)callCarDataWithDictionary:(NSDictionary *)dict;

@end
