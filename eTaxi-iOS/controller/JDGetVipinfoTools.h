//
//  JDGetVipinfoTools.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDGetVipinfoTools : NSObject

+(void)GetVipInfoSuccess:(void(^)(NSMutableDictionary *dictArr))success failure:(void(^)(NSError *error))failure;


/**
 *  根据推荐的人数计算还差几个人升级
 *
 *  @param count 推荐人数
 *
 *  @return 差的人数
 */
+(int)calculationWith:(int)count;

/**
 *  根据推荐的人数计算下一个会员等级是什么
 *
 *  @param recommendCount 推荐的人数
 *
 *  @return 下一个会员等级
 */
+(NSString *)backVipLevelWithRecommenCount:(NSString *)recommendCount;


@end
