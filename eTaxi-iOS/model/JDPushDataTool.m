//
//  JDPushDataTool.m
//  eTaxi-iOS
//
//  Created by jeader on 16/5/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDPushDataTool.h"

#import "JDPushData.h"

#import "HeadFile.pch"

#define FilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"push.sqlite"]

#define TITLE @"title"
#define CONTENT @"content"
#define CURRENTTIME @"currentTime"
#define FLAG @"flag"
#define METHODNAME @"methodName"

static FMDatabase *_db;

@implementation JDPushDataTool

-(void)openDB
{
    // 获取数据库
    FMDatabase *db = [FMDatabase databaseWithPath:FilePath];
    // 打开数据库
    [db open];
    _db = db;
}

-(void)createTable
{
    [self openDB];
        
    // 创建表
    NSString *sql = [NSString stringWithFormat:@"create table if not exists push('%@' text,'%@' text,'%@' text,'%@' text,'%@' text);",TITLE,CONTENT,CURRENTTIME,FLAG,METHODNAME];
    
    BOOL result = [_db executeUpdate:sql];
    if (result) {
        JDLog(@"创建表成功");
    }else{
        JDLog(@"创建表失败");
    }
    
    [_db close];
}

// 插入数据
-(void)insertValuesForKeysWithDictionary:(NSDictionary *)dict
{
    [self openDB];
    
    JDPushData *data = [JDPushData pushDataWithDictionary:dict];
    
    NSString *insert = [NSString stringWithFormat:@"insert into push('%@','%@','%@','%@','%@') values('%@','%@','%@','%@','%@')",TITLE,CONTENT,CURRENTTIME,FLAG,METHODNAME,data.title,data.content,data.currentTime,data.flag,data.methodName];
    
    // executeUpdate:不确定的参数用？来占位
    BOOL result = [_db executeUpdate:insert];
    
    if (result) {
        JDLog(@"插入数据成功");
    }else{
        JDLog(@"插入数据失败");
    }
    
    [_db close];
    
}

// 删除表
-(void)deleteTable
{
    [self openDB];
    
    BOOL result1 = [_db executeUpdate:@"drop table if exists push;"];
    
    if (result1) {
        JDLog(@"删除表成功");
    }else{
        JDLog(@"删除表失败");
    }
    
    [_db close];
    
    
}

// 查询
-(NSArray *)query
{
    NSMutableArray *arr = [NSMutableArray array];
    [self openDB];
    
    // 1.执行查询语句
    FMResultSet *resultSet = [_db executeQuery:@"select * from push"];
    
    
    // 2.遍历结果
    while ([resultSet next]) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        NSString *title = [resultSet stringForColumn:TITLE];
        NSString *content = [resultSet stringForColumn:CONTENT];
        NSString *currentTime = [resultSet stringForColumn:CURRENTTIME];
        NSString *flag = [resultSet stringForColumn:FLAG];
        NSString *methodName = [resultSet stringForColumn:METHODNAME];
        
        dict[@"title"] = title;
        dict[@"content"] = content;
        dict[@"currentTime"] = currentTime;
        dict[@"flag"] = flag;
        dict[@"methodName"] = methodName;
        
        // 决定数组的排列顺序，正序还是倒序
        [arr insertObject:dict atIndex:0];
        JDLog(@"%@--%@--%@--%@--%@",title,content,currentTime,flag,methodName);
    }
    
    JDLog(@"%ld",(unsigned long)arr.count);
    
    [_db close];
    
    
    return arr;
    
}

@end
