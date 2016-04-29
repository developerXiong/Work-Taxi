//
//  JDLostNetTool.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/8.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JDLostNetTool : NSObject

/**
 *  请求失物信息接口
 */
+(void)lostDataInVC:(UIViewController *)Vc Success:(void(^)(NSMutableArray *dataArr))success failure:(void(^)(NSError *error))failure;

/**
 *  上传失物信息的接口（含图片）
 */
+(void)sendLostDataInVC:(UIViewController *)Vc lostType:(NSString *)styleStr image:(UIImage *)image Success:(void(^)())success failure:(void(^)(NSError *error))failure;

/**
 *  补充详情（不含图片）
 */
+(void)sendLostDataInVC:(UIViewController *)Vc Describe:(NSString *)describe returnID:(NSString *)returnId Success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
