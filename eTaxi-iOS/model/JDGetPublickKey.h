//
//  JDGetPublickKey.h
//  eTaxi-iOS
//
//  Created by jeader on 16/6/6.
//  Copyright © 2016年 jeader. All rights reserved.
//  获取转密文的公钥

#import <Foundation/Foundation.h>

@interface JDGetPublickKey : NSObject

/**
 *  获取密文
 *
 *  password : 密码
 *  publicKey: 公钥
 *  return : 对密码加密后的密文
 */
+(void)securityTextWithPass:(NSString *)password success:(void(^)(NSString *security))success failure:(void(^)(NSError *error))failure;

+(void)securityTextWithPass:(NSString *)oldPassword newPass:(NSString *)newPass success:(void(^)(NSString *oldSecurity,NSString *newSecurity))success failure:(void(^)(NSError *error))failure;

@end
