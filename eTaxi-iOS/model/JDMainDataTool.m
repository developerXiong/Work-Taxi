//
//  JDMainDataTool.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/8.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMainDataTool.h"

#import "JDMainViewData.h"

#define FilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"main.data"]

@implementation JDMainDataTool

+(void)saveMainData:(JDMainViewData *)mainData
{
    
    [NSKeyedArchiver archiveRootObject:mainData toFile:FilePath];
}

+(JDMainViewData *)mainData
{
    JDMainViewData *mainData = [NSKeyedUnarchiver unarchiveObjectWithFile:FilePath];
    
    return mainData;
}

@end
