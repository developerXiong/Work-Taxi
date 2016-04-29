//
//  JDMainViewData.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMainViewData.h"

#import "MJExtension.h"

#define JDCountKey @"count"

@implementation JDMainViewData

+(instancetype)mainDataWithDict:(NSDictionary *)dict
{
    JDMainViewData *data = [JDMainViewData mj_objectWithKeyValues:dict];
    
    return data;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_count forKey:JDCountKey];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        _count = [aDecoder decodeObjectForKey:JDCountKey];
        
    }
    
    return self;
}

@end
