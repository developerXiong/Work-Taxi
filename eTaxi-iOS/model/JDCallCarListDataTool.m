//
//  JDCallCarListDataTool.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/23.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDCallCarListDataTool.h"

#import "MJExtension.h"

#import "JDCallCarData.h"

#define FilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"callCarList.plist"]

@implementation JDCallCarListDataTool

+(void)saveCallCarListDataWithArr:(NSMutableArray *)arr
{
    NSMutableArray *dataArr = [NSMutableArray array];
    // arr 是对象数组  处理
    for (int i = 0; i < arr.count; i++) {
        
        NSDictionary *dict = [arr[i] mj_keyValues];
        
        [dataArr addObject:dict];
        
    }
    
    
    [dataArr writeToFile:FilePath atomically:NO];
    
}

+(NSMutableArray *)callCarListData
{
    // 数据数组
    NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:FilePath];
    
    // 对象数组
    NSMutableArray *modelArr = [NSMutableArray array];
    
    for (NSDictionary *dict in arr) {
        
        JDCallCarData *data = [JDCallCarData callCarDataWithDictionary:dict];
        
        [modelArr addObject:data];
        
    }
    
    
    return modelArr;
}

+(void)removeCallCarPlist
{
    NSFileManager *manager = [[NSFileManager alloc] init];
    
    [manager removeItemAtPath:FilePath error:nil];
}

@end
