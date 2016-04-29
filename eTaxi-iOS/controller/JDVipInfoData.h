//
//  JDVipInfoData.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDVipInfoData : NSObject
/**
 *  推荐人数
 */
@property (nonatomic, copy) NSString *referrals;
/**
 *  会员等级
 */
@property (nonatomic, copy) NSString *grade;
/**
 *  信用积分
 */
@property (nonatomic, copy) NSString *creditScore;

+(instancetype)vipInfoWithDict:(NSDictionary *)dict;

@end
