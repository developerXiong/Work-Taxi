//
//  JDMainDataTool.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/8.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JDMainViewData;
@interface JDMainDataTool : NSObject

+(void)saveMainData:(JDMainViewData *)mainData;

+(JDMainViewData *)mainData;

@end
