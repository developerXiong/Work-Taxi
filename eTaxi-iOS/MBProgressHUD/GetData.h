//
//  GetData.h
//  eTaxi-iOS
//
//  Created by jeader on 15/12/31.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetData : NSObject

//请求数据
+(void)getDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;


//上传图片到服务器
+(void)postDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params imageDatas:(NSArray *)images success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

@end
