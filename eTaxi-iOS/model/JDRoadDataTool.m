//
//  JDRoadDataTool.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/9.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDRoadDataTool.h"

#import "JDRoadData.h"

#define FilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"road.plist"]

@implementation JDRoadDataTool

+(void)saveRoadData:(NSMutableArray *)roadData
{
    [roadData writeToFile:FilePath atomically:NO];
}

+(NSMutableArray *)roadData
{
    NSMutableArray *roadData = [[NSMutableArray alloc] initWithContentsOfFile:FilePath];
    
    NSMutableArray *roadDataArr = [NSMutableArray array];
    
    for (NSDictionary *dict in roadData) {
        
        JDRoadData *roadData = [JDRoadData roadDataWithDict:dict];
        
        [roadDataArr addObject:roadData];
        
    }
    
//    NSLog(@"/////////%@",roadDataArr);
    
    return roadDataArr;
}

@end
