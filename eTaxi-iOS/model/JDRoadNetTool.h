//
//  JDRoadNetTool.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/9.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface JDRoadNetTool : NSObject

/**
 *  请求路况信息接口
 */
+(void)roadDataInVC:(UIViewController *)Vc Success:(void(^)(NSMutableArray *dataArr))success failure:(void(^)(NSError *error))failure;

/**
 *  上传路况信息的接口（含图片）
 */
+(void)sendRoadDataInVC:(UIViewController *)Vc RoadType:(NSString *)styleStr image:(UIImage *)image location:(CLLocation *)location Success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
