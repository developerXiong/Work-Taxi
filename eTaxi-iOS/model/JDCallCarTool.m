//
//  JDCallCarTool.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDCallCarTool.h"

#import "HeadFile.pch"
#import "GetData.h"

#import "JDCallCarData.h"
#import "JDCallCarParam.h"

#import "NSString+StringForUrl.h"

@implementation JDCallCarTool

+(void)getCallCarInfoWithType:(NSString *)type Num:(NSString *)number Success:(void (^)(NSMutableArray *, int))success failure:(void (^)(NSError *))failure
{
    
    JDCallCarParam *params = [[JDCallCarParam alloc] init];
    params.phoneNo = PHONENO;
    params.password = PASSWORD;
    params.loginTime = LOGINTIME;
    params.type = type;
    if ([type isEqualToString:@"1"]) {
        params.number = number;
    }
    
    if (!PHONENO||!PASSWORD||!LOGINTIME) return;
    
    [GetData getDataWithUrl:[NSString urlWithApiName:@"getCallCarInfo.json"] params:params.mj_keyValues success:^(id response) {
       
        int returnCode = [response[@"returnCode"] intValue];
        
        JDLog(@"response--->%@",response);
        
        if (returnCode==0) {
            
            if ([params.type isEqualToString:@"0"]) { // 召车信息
                
                NSArray *dataArr = response[@"callCarInfoArr"];
                NSMutableArray *modelArr = [NSMutableArray array];
                
                for (NSDictionary *dict in dataArr) {
                    
                    JDCallCarData *data = [JDCallCarData callCarDataWithDictionary:dict];
                    
                    [modelArr addObject:data];
                }
                
                if (success) {
                    success(modelArr,10);
                }
                
            }else if([params.type isEqualToString:@"1"]){ // 接单
                
                // Status 0：接单成功 ，1：接单失败
                int status = [response[@"status"] intValue];
                
                if (success) {
                    success(nil,status);
                }
            }else if([params.type isEqualToString:@"2"]){ // 请求当前已接单
                
                JDLog(@"····%@",response);
                
            }
           
        }else{
            
            
            
        }
      
     
    } failure:^(NSError *error) {
        
        JDLog(@"%@",error);
        
    }];
    
}

+(void)getCallCarListWithType:(NSString *)type Success:(void (^)(NSMutableArray *, int))success failure:(void (^)(NSError *))failure
{
    
    JDCallCarParam *params = [[JDCallCarParam alloc] init];
    params.phoneNo = PHONENO;
    params.password = PASSWORD;
    params.loginTime = LOGINTIME;
    params.type = type;
    
    if (!PHONENO||!PASSWORD||!LOGINTIME) return;
    
    [GetData getDataWithUrl:[NSString urlWithApiName:@"getCallCarInfo.json"] params:params.mj_keyValues success:^(id response) {
        
        int returnCode = [response[@"returnCode"] intValue];
        
        JDLog(@"response--->%@",response);
        
        if (returnCode==0) {
            
            NSArray *dataArr = response[@"callCarInfoArr"];
            NSMutableArray *modelArr = [NSMutableArray array];
            
            for (NSDictionary *dict in dataArr) {
                
                JDCallCarData *data = [JDCallCarData callCarDataWithDictionary:dict];
                
                [modelArr addObject:data];
            }
            
            int orderCount = 0;
            if ([type isEqualToString:@"2"]) { // 我的订单列表
                orderCount = [response[@"orderCount"] intValue];
            }
            
            if ([type isEqualToString:@"3"]) { // 获取消息列表
                if (modelArr.count>20) {
                    // 只去前20条数据
                    [modelArr removeObjectsInRange:NSMakeRange(20, modelArr.count-20)];
                }
            }
            
            if (success) {
                success(modelArr,orderCount);
            }
            
        }else{
            
            
            
        }
        
        
    } failure:^(NSError *error) {
        
        JDLog(@"%@",error);
        
    }];
}

@end
