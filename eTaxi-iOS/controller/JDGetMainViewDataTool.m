//
//  JDGetMainViewDataTool.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDGetMainViewDataTool.h"

#import "HeadFile.pch"
#import "JDMainViewData.h"
#import "JDMainDataTool.h"

@implementation JDGetMainViewDataTool

+(void)GetVipInfoWithVc:(UIViewController *)VC plate:(id)plate engine:(id)engine success:(void(^)(NSMutableDictionary *dictArr))success failure:(void(^)(NSError *error))failure
{
    
//    JDLog(@"%@----%@",plate,engine);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phoneNo"] = PHONENO;
    params[@"password"] = PASSWORD;
    params[@"loginTime"] = LOGINTIME;
    params[@"plateNo"] = PLATE;
    params[@"engineNo"] = ENGINE;
    
//    JDLog(@"%@----%@---%@----%@-----%@",PLATE,ENGINE,PHONENO,PASSWORD,LOGINTIME);
    
    JDLog(@"plateNo===%@====%@",PLATE,ENGINE);
    
    [GetData getDataWithUrl:[NSString urlWithApiName:@"queryHomePageInfo.json"] params:params success:^(id response) {
        
        JDLog(@"response-%@====%@",response,response[@"msg"]);
        
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
        int returnCode = [response[@"returnCode"] intValue];
        if (returnCode==0) {
            
            NSDictionary *dict = response;
            JDMainViewData *mainData = [JDMainViewData mainDataWithDict:dict];
            [dataDict setObject:mainData forKey:@"mainData"];
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:mainData.totalScore forKey:@"leftScore"];
//            [user setObject:mainData.count forKey:@"totalPecc"];
            [user synchronize];
            
            [JDMainDataTool saveMainData:mainData];
            
            success(dataDict);
            
        }else if(returnCode==2){
            
            [GetData addAlertViewInView:VC title:@"温馨提示" message:[NSString stringWithFormat:@"%@",response[@"msg"]] count:0 doWhat:^{
                
                /**
                 *  执行强制退出
                 */
                PersonalVC *p = [[PersonalVC alloc] init];
                [p removeFileAndInfo];
                
            }];
            
        }else{
            
            
            
        }
        
        
    } failure:^(NSError *error) {
        failure(error);
        
        JDLog(@"%@",error);
    }];
    
}

@end