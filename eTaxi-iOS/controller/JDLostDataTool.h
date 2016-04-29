//
//  JDLostDataTool.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/8.
//  Copyright © 2016年 jeader. All rights reserved.
//  快速缓存 取出 数据。。。目前没用上

#import <Foundation/Foundation.h>

@class JDLostData;
@interface JDLostDataTool : NSObject

+(void)saveLostData:(NSMutableArray *)lostData;

/**
 *  返回模型数组
 */
+(NSMutableArray *)lostData;

@end
