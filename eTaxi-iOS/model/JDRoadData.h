//
//  JDRoadData.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/9.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDRoadData : NSObject

@property (nonatomic, strong) NSString *roadAddress;

@property (nonatomic, strong) NSURL *roadImage;

@property (nonatomic, assign) int roadStatus;

@property (nonatomic, strong) NSString *roadTime;

@property (nonatomic, strong) NSString *roadType;

+(instancetype)roadDataWithDict:(NSDictionary *)dict;

@end
