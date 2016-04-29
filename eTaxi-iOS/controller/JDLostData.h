//
//  JDLostData.h
//  netWordDataTEST
//
//  Created by jeader on 16/3/4.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface JDLostData : NSObject

@property (nonatomic, strong) NSString *describe;

@property (nonatomic, strong) NSString *lostId;

@property (nonatomic, strong) NSURL *lostImage;

@property (nonatomic, assign) int lostStatus;

@property (nonatomic, strong) NSString *lostTime;

@property (nonatomic, strong) NSString *lostType;

+(instancetype)lostDataWithDict:(NSDictionary *)dict;

+(NSString *)setUpTimeWithTime:(NSString *)timeStr;

@end
