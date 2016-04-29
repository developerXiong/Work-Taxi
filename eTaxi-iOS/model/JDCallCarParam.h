//
//  JDCallCarParam.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"

@interface JDCallCarParam : NSObject<MJKeyValue>
/**
 *  手机号
 */
@property (nonatomic, copy) NSString *phoneNo;
/**
 *  密码
 */
@property (nonatomic, copy) NSString *password;
/**
 *  登录时间
 */
@property (nonatomic, copy) NSString *loginTime;
/**
 *  处理类型
 */
@property (nonatomic, copy) NSString *type;
/**
 *  单子编号
 */
@property (nonatomic, copy) NSString *number;


@end
