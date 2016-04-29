//
//  JDLostData.m
//  netWordDataTEST
//
//  Created by jeader on 16/3/4.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDLostData.h"

#import "MJExtension.h"

#define JDDescribeKey @"describe"
#define JDLostIdKey @"lostId"
#define JDLostImageKey @"lostImage"
#define JDLostStatusKey @"lostStatus"
#define JDLostTimeKey @"lostTime"
#define JDLostTypeKey @"lostType"

static NSString *timeLost;

@implementation JDLostData


+(instancetype)lostDataWithDict:(NSDictionary *)dict
{
    JDLostData *lost = [JDLostData mj_objectWithKeyValues:dict];
    
    return lost;
}

-(void)setLostImage:(NSString *)lostImage
{
    _lostImage = (NSURL *)lostImage;
}

-(void)setLostTime:(NSString *)lostTime
{
    _lostTime = lostTime;
    
    timeLost = lostTime;
    
}

+(NSString *)setUpTimeWithTime:(NSString *)timeStr
{

    NSString *timeStr1 = [timeStr substringToIndex:4];
    
    NSString *timeStr2 = [timeStr substringFromIndex:4];
    timeStr2 = [timeStr2 substringToIndex:2];
    
    NSString *timeStr3 = [timeStr substringFromIndex:6];
    
    timeStr = [NSString stringWithFormat:@"发布时间: %@/%@/%@",timeStr1,timeStr2,timeStr3];
    
    return timeStr;
}

//归档
//-(void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:_describe forKey:JDDescribeKey];
//    [aCoder encodeObject:_lostId forKey:JDLostIdKey];
//    [aCoder encodeObject:_lostImage forKey:JDLostImageKey];
//    [aCoder encodeObject:_lostStatus forKey:JDLostStatusKey];
//    [aCoder encodeObject:_lostTime forKey:JDLostTimeKey];
//    [aCoder encodeObject:_lostType forKey:JDLostTypeKey];
//}
////解档
//-(instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init]) {
//        
//        _describe = [aDecoder decodeObjectForKey:JDDescribeKey];
//        _lostId = [aDecoder decodeObjectForKey:JDLostIdKey];
//        _lostImage = [aDecoder decodeObjectForKey:JDLostImageKey];
//        _lostStatus = [aDecoder decodeObjectForKey:JDLostStatusKey];
//        _lostTime = [aDecoder decodeObjectForKey:JDLostTimeKey];
//        _lostType = [aDecoder decodeObjectForKey:JDLostTypeKey];
//        
//    }
//    return self;
//}

@end
/*
 @property (nonatomic, strong) NSString *describe;
 
 @property (nonatomic, strong) NSString *lostId;
 
 @property (nonatomic, strong) NSString *lostImage;
 
 @property (nonatomic, strong) NSString *lostStatus;
 
 @property (nonatomic, strong) NSString *lostTime;
 
 @property (nonatomic, strong) NSString *lostType;
 
 */