//
//  JDVipInfoData.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDVipInfoData.h"

#import "MJExtension.h"

@implementation JDVipInfoData

+(instancetype)vipInfoWithDict:(NSDictionary *)dict
{
    JDVipInfoData *info = [JDVipInfoData mj_objectWithKeyValues:dict];
    
    return info;
}

@end
