//
//  JDRoadData.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/9.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDRoadData.h"

#import "MJExtension.h"

@implementation JDRoadData

+(instancetype)roadDataWithDict:(NSDictionary *)dict
{
    JDRoadData *road = [JDRoadData mj_objectWithKeyValues:dict];
    
    return road;
}

-(void)setRoadImage:(NSString *)roadImage
{
    _roadImage = (NSURL *)roadImage;
}

@end
