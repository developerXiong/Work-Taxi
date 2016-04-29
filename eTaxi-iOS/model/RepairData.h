//
//  RepairData.h
//  eTaxi-iOS
//
//  Created by jeader on 16/1/6.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepairData : NSObject

/**
 *  维修点电话
 */
@property (nonatomic, copy) NSString *tel;

/**
 *  维修点地址
 */
@property (nonatomic, copy) NSString *address;

/**
 *  维修点ID
 */
@property (nonatomic, copy) NSString *id;

/**
 *  维修点名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  维修点图片
 */
@property (nonatomic, copy) NSString *imgAddress;


+(instancetype)repairDataWithDictionary:(NSDictionary *)dict;

@end
