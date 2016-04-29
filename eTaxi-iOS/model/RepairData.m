//
//  RepairData.m
//  eTaxi-iOS
//
//  Created by jeader on 16/1/6.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "RepairData.h"


#import "MJExtension.h"

@implementation RepairData

+(instancetype)repairDataWithDictionary:(NSDictionary *)dict
{
    RepairData *repair = [RepairData mj_objectWithKeyValues:dict];
    
    return repair;
}

@end
