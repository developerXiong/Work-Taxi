//
//  JDRepairNetTool.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/27.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JDRepairNetTool : NSObject

/**
 *  预约维修点
 *
 *  @param repairPro  代表维修项目的string @"0,1,2,3"
 *  @param repairID   维修点的ID
 *  @param timeString 时间字符串
 *  @param Vc         <#Vc description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+(void)sendRepairInfoWithPro:(NSMutableString *)repairPro repairId:(NSString *)repairID timeStr:(NSString *)timeString InVc:(UIViewController *)Vc Success:(void (^)())success failure:(void (^)(NSError *error))failure;

+(void)getRepairInfoInVc:(UIViewController *)Vc Success:(void (^)(NSMutableArray *modelArr))success failure:(void (^)(NSError *error))failure;

@end
