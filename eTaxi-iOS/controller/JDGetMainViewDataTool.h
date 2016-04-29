//
//  JDGetMainViewDataTool.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JDGetMainViewDataTool : NSObject

+(void)GetVipInfoWithVc:(UIViewController *)VC plate:(id)plate engine:(id)engine success:(void(^)(NSMutableDictionary *dictArr))success failure:(void(^)(NSError *error))failure;

@end
