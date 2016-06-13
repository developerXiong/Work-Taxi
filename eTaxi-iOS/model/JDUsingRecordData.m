//
//  JDUsingRecordData.m
//  eTaxi-iOS
//
//  Created by jeader on 16/5/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDUsingRecordData.h"

#import "MJExtension.h"

@implementation JDUsingRecordData

+(instancetype)usingrecordDataWithDictionary:(NSDictionary *)dict
{
    id data = [self mj_objectWithKeyValues:dict];
    
    return data;
}

+(NSMutableArray *)dataArrWithArray:(NSArray *)modelArr
{
    NSMutableArray *lastArr = [NSMutableArray array];
    NSMutableArray *noArr = [NSMutableArray array]; // 未兑换的数组
    NSMutableArray *beArr = [NSMutableArray array]; // 已兑换的数组
    
    for (JDUsingRecordData *data in modelArr) {
        if (!data.useStatus) {
            [noArr addObject:data];
        }else{
            [beArr addObject:data];
        }
    }
    
    [lastArr addObjectsFromArray:noArr];
    [lastArr addObjectsFromArray:beArr];
    
    return lastArr;
}

//-(void)setUseStatus:(NSString *)useStatus
//{
//    _useStatus = useStatus;
//    
//    
//}
//
//-(int)costStatus
//{
//    NSDate *currentDate = [NSDate date];
//    
//    NSDateFormatter *dmf = [[NSDateFormatter alloc] init];
//    dmf.dateFormat = @"YYYYMMDD";
//    NSString *dateStr = [dmf stringFromDate:currentDate];
//    int date = [dateStr intValue];
//    if (date>[_useStatus intValue]) {
//        return 2;
//    }
//    
//    return [_useStatus intValue];
//}

-(void)setCostNumber:(NSString *)costNumber
{
    _costNumber = costNumber;
}

-(void)setCost:(NSString *)cost
{
    _cost = cost;
}

-(NSString *)count
{
    return [NSString stringWithFormat:@"数量：x%@",_costNumber];
}

-(NSString *)price
{
    return [NSString stringWithFormat:@"单价：%d积分",-[_cost intValue]/[_costNumber intValue]];
}

-(NSString *)total
{
    return [NSString stringWithFormat:@"总计：%d积分",-[_cost intValue]];
}



@end
