//
//  JDRoadDataTool.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/9.
//  Copyright © 2016年 jeader. All rights reserved.
//  快速缓存 取出 数据。。。目前没用上

#import <Foundation/Foundation.h>


@interface JDRoadDataTool : NSObject

+(void)saveRoadData:(NSMutableArray *)roadData;

/**
 *  返回模型数组
 */
+(NSMutableArray *)roadData;

@end
