//
//  JDGetVipinfoTools.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDGetVipinfoTools.h"

#import "HeadFile.pch"
#import "JDVipInfoData.h"

#define OrdinaryVip 3 // 升级普通会员需要推荐的人数
#define PlatinumVip 15 // 升级白金会员需要推荐的人数
#define DiamondVip 30 // 升级钻石会员需要推荐的人数

@implementation JDGetVipinfoTools

+(void)GetVipInfoSuccess:(void (^)(NSMutableDictionary *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phoneNo"] = PHONENO;
    params[@"password"] = PASSWORD;
    params[@"loginTime"] = LOGINTIME;
    
    [GetData getDataWithUrl:[NSString urlWithApiName:@"getVipInfo.json"] params:params success:^(id response) {
       
        JDLog(@"%@",response);
        
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
        int returnCode = [response[@"returnCode"] intValue];
        if (returnCode==0) {
            NSDictionary *dict = response;
            JDVipInfoData *vipData = [JDVipInfoData vipInfoWithDict:dict];
            
            [dataDict setObject:vipData forKey:@"vipInfo"];
            
            success(dataDict);
            
        }
        
        
    } failure:^(NSError *error) {

        failure(error);
    }];
    
}

+(int)calculationWith:(int)count
{
    int different1 = OrdinaryVip-count;
    int different2 = PlatinumVip-count;
    int different3 = DiamondVip-count;
    
    return different1 > 0 ? different1 : different2 > 0 ? different2 : different3;
}


+(NSString *)backVipLevelWithRecommenCount:(NSString *)recommendCount
{
    //已推荐人数
    int recommend = [recommendCount intValue];
    
    if (recommend<OrdinaryVip) {
        return @"普通会员";
    }else if(recommend<PlatinumVip){
        return @"白金会员";
    }else{
        return @"钻石会员";
    }
    return nil;
    
}

@end
