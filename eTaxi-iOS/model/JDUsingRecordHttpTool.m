//
//  JDUsingRecordHttpTool.m
//  eTaxi-iOS
//
//  Created by jeader on 16/5/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDUsingRecordHttpTool.h"

#import "GetData.h"
#import "HeadFile.pch"
#import "JDIsNetwork.h"
#import "JDUsingRecordData.h"

@implementation JDUsingRecordHttpTool

+(void)getUsingRecordDataInVC:(UIViewController *)Vc success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phoneNo"] = PHONENO;
    params[@"password"] = PASSWORD;
    params[@"loginTime"] = LOGINTIME;
    params[@"type"] = @"1"; // 请求支出积分的兑换记录
    params[@"beginDate"] = @"";
    params[@"overDate"] = @"";
    
    [GetData getDataWithUrl:[NSString urlWithApiName:@"queryScore.json"] params:params success:^(id response) {
       
        JDLog(@"%@",response);
        NSArray *records = response[@"Integrals"];
        NSInteger returnCode = [response[@"returnCode"] integerValue];
        NSString *msg = [NSString stringWithFormat:@"%@",response[@"msg"]];
        NSMutableArray *modelArr = [NSMutableArray array];
        
        if ([JDIsNetwork sharedInstance]) { // 网络连接良好
            
            if (returnCode==0) { // 返回成功
                
                for (NSDictionary *dict in records) {
                    // 字典转模型
                    JDUsingRecordData *data = [JDUsingRecordData usingrecordDataWithDictionary:dict];
                    [modelArr addObject:data];
                    
                }
                
                if (success) {
                    success(modelArr);
                }
                
            }else if (returnCode == 2) { //强制退出
                [GetData addAlertViewInView:Vc title:@"温馨提示" message:msg count:0 doWhat:^{
                    /**
                     *  执行强制退出
                     */
                    PersonalVC *p = [[PersonalVC alloc] init];
                    [p removeFileAndInfo];
                }];
            }else {
                [GetData addAlertViewInView:Vc title:@"温馨提示" message:msg count:0 doWhat:^{
                    
                }];
            }
            
        }else { // 网络未连接
            [GetData addAlertViewInView:Vc title:@"温馨提示" message:@"请检查网络连接" count:0 doWhat:^{
                
            }];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

@end
