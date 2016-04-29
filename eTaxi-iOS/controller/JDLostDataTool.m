//
//  JDLostDataTool.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/8.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDLostDataTool.h"

#import "JDLostData.h"

#define FilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"lost.plist"]

@interface JDLostDataTool ()

@end

@implementation JDLostDataTool

+(void)saveLostData:(NSMutableArray *)lostData
{
//    [NSKeyedArchiver archiveRootObject:lostData toFile:FilePath];
    //plist 中 不能存放对象
    
    
    [lostData writeToFile:FilePath atomically:NO];
    
}

+(NSMutableArray *)lostData
{
    
    NSMutableArray *lostData = [[NSMutableArray alloc] initWithContentsOfFile:FilePath];
    
    NSMutableArray *lostDataArr = [NSMutableArray array];
    
    for (NSDictionary *dict in lostData) {
        
        JDLostData *lostData = [JDLostData lostDataWithDict:dict];
        
        [lostDataArr addObject:lostData];
        
    }
    
//    NSLog(@"/////////%@",lostDataArr);
    
    return lostDataArr;
}

@end
