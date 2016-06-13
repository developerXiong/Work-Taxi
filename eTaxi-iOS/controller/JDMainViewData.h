//
//  JDMainViewData.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDMainViewData : NSObject<NSCoding>

/**
 *  未完成预约数
 */
@property (nonatomic, copy) NSString *reservationNumber;
/**
 *  违章数
 */
@property (nonatomic, copy) NSString *count;
/**
 *  总营收
 */
@property (nonatomic, copy) NSString *totalInCome;
/**
 *  总罚款数
 */
@property (nonatomic, copy) NSString *totalMoney;
/**
 *  总扣分
 */
@property (nonatomic, copy) NSString *totalPoint;
/**
 *  剩余总积分
 */
@property (nonatomic, copy) NSString *totalScore;

+(instancetype)mainDataWithDict:(NSDictionary *)dict;

@end
