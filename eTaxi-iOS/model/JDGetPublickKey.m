//
//  JDGetPublickKey.m
//  eTaxi-iOS
//
//  Created by jeader on 16/6/6.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDGetPublickKey.h"

#import "GetData.h"
#import "HeadFile.pch"

#import "RSA.h"

static NSString *publicKey;

@implementation JDGetPublickKey

+(void)securityTextWithPass:(NSString *)password success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [GetData getDataWithUrl:@"http://192.168.1.250:8080/tad/client/getPublicKey.json" params:nil success:^(id response) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *str1 =  [response objectForKey:@"publicKey"]; // 公钥
                NSString *security = [RSA encryptString:password publicKey:str1];
                
                if (str1) {
                    if (success) {
                        success(security);
                    }
                }
                
            });
            
        } failure:^(NSError *error) {
            
            if (failure) {
                failure(error);
            }
            
        }];
    });
}

+(void)securityTextWithPass:(NSString *)oldPassword newPass:(NSString *)newPass success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [GetData getDataWithUrl:@"http://192.168.1.250:8080/tad/client/getPublicKey.json" params:nil success:^(id response) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *str1 =  [response objectForKey:@"publicKey"]; // 公钥
                NSString *oldSecurity = [RSA encryptString:oldPassword publicKey:str1];
                NSString *newSecurity = [RSA encryptString:newPass publicKey:str1];
                
                if (str1) {
                    if (success) {
                        success(oldSecurity,newSecurity);
                    }
                }
                
            });
            
        } failure:^(NSError *error) {
            
            if (failure) {
                failure(error);
            }
            
        }];
    });
}

@end
