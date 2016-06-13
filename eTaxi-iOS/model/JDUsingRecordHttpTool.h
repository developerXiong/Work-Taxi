//
//  JDUsingRecordHttpTool.h
//  eTaxi-iOS
//
//  Created by jeader on 16/5/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface JDUsingRecordHttpTool : NSObject

+(void)getUsingRecordDataInVC:(UIViewController *)Vc success:(void(^)(NSArray *modelArr))success failure:(void(^)(NSError *error))failure;

@end
