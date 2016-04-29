//
//  JDGoodsData.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDGoodsData.h"

#import "MJExtension.h"

@implementation JDGoodsData

+(instancetype)goodsDataWithDict:(NSDictionary *)dict
{
    
    JDGoodsData *data = [self mj_objectWithKeyValues:dict];
    
    return data;
    
}

-(void)setImgAddress:(NSString *)imgAddress
{
    _imgAddress = (NSURL *)imgAddress;
}

@end
