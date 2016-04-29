//
//  JDCallCarData.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDCallCarData.h"

#import "MJExtension.h"

@implementation JDCallCarData

+(instancetype)callCarDataWithDictionary:(NSDictionary *)dict
{
    JDCallCarData *data = [self mj_objectWithKeyValues:dict];
    
    return data;
}

@end
