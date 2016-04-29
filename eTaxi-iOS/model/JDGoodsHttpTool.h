//
//  JDGoodsHttpTool.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JDGoodsHttpTool : NSObject

/**
 *  请求商品数据
 *
 *  @param VC      <#VC description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)getGoodsInfoInVC:(UIViewController *)VC Success:(void(^)(NSMutableArray *modelArr))success failure:(void(^)(NSError *error))failure;

/**
 *   兑换商品
 *
 *  @param number  <#number description#>
 *  @param goodsID <#goodsID description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)exchangeGoodsWithCount:(int)number goodsID:(int)goodsID inVc:(UIViewController *)VC success:(void(^)(int status))success failure:(void(^)(NSError *error))failure;

@end
