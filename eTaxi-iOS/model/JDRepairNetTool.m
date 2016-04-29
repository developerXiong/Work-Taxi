//
//  JDRepairNetTool.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/27.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDRepairNetTool.h"

#import "HeadFile.pch"

#import "RepairData.h"


@implementation JDRepairNetTool

+(void)sendRepairInfoWithPro:(NSMutableString *)repairPro repairId:(NSString *)repairID timeStr:(NSString *)timeString InVc:(UIViewController *)Vc Success:(void (^)())success failure:(void (^)(NSError *))failure
{
    
    /**
     *  预约时间的button上的时间
     */
    NSString *timeStr = timeString;
    /**
     *  预约的时间 年月日string
     */
    NSString *dateTime = [timeStr substringToIndex:10];
    dateTime = [dateTime stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    /**
     *  预约的时间 小时
     */
    NSString *hourTime = [timeStr substringFromIndex:16];
    hourTime = [hourTime substringToIndex:2];
    
    [GetData addAlertViewInView:Vc title:@"温馨提示" message:@"您确定要预约吗？" count:1 doWhat:^{
        
        [GetData addMBProgressWithView:Vc.view style:0];
        [GetData showMBWithTitle:@"正在预约..."];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"type"] = @"2";
        params[@"phoneNo"] = PHONENO;
        params[@"password"] = PASSWORD;
        params[@"loginTime"] = LOGINTIME;
        //        params[@"role"] = @"0"; //身份 0出租车，1乘客
        if (repairID) {
            
            params[@"addressId"] = repairID; //维修点ID
        }else{
            params[@"addressId"] = @"1";
        }
        params[@"optionIdList"] = repairPro; //维修项目ID
        params[@"dateStart"] = dateTime; //预约时间
        params[@"startTime"] = hourTime; // 小时 24小时制
        
        
        [GetData getDataWithUrl:[NSString urlWithApiName:@"getReservationInfo.json"] params:params success:^(id response) {
            
            NSString *string = @"";
            
            int returnCode = [response[@"returnCode"] intValue];
            
            if(returnCode == 0){
                
                [GetData hiddenMB];
                
                if (response[@"wait"]) {
                    
                    string = [NSString stringWithFormat:@"预约成功！请到‘我的预约中’查看您的预约状态！超过%@未到指定维修点进行维修视为放弃预约！",response[@"wait"]];
                    
                    
                }else{
                    
                    string = [NSString stringWithFormat:@"预约成功！请到‘我的预约中’查看您的预约状态！"];
                    
                }
                
                
            }else if(returnCode ==2){//强制退出
                
                [GetData addAlertViewInView:Vc title:@"温馨提示" message:[NSString stringWithFormat:@"%@",response[@"msg"]] count:0 doWhat:^{
                    
                    //                            NSLog(@"success");
                    /**
                     *  执行强制退出
                     */
                    PersonalVC *p = [[PersonalVC alloc] init];
                    [p removeFileAndInfo];
                    
                }];
                
            }else{
                [GetData hiddenMB];
                
                string = response[@"msg"];
                
            }
            
            /**
             *  预约成功之后跳转界面
             */
            [GetData addAlertViewInView:Vc title:@"温馨提示" message:string count:0 doWhat:^{
                if (returnCode==0) {
                    
//                    MyOrderViewController *orderView = [[MyOrderViewController alloc] init];
//                    [orderView addNavigationBar:@"我的预约"];
//                    [Vc.navigationController pushViewController:orderView animated:YES];
                    if (success) {
                        success();
                    }
                    
                }
                
                
            }];
            
        } failure:^(NSError *error) {
            
            //                    NSLog(@"error----->%@",error);
            [GetData hiddenMB];
            [GetData addAlertViewInView:Vc title:@"温馨提示" message:@"预约失败" count:0 doWhat:nil];
            
        }];
        
    }];
}


+(void)getRepairInfoInVc:(UIViewController *)Vc Success:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"phoneNo"] = PHONENO;
    params[@"password"] = PASSWORD;
    params[@"loginTime"] = LOGINTIME;
    params[@"type"] = @"0";
    params[@"role"] = @"0";
    
    [GetData getDataWithUrl:[NSString urlWithApiName:@"getReservationInfo.json"] params:params success:^(id response) {
        
        NSMutableArray *arr = response[@"maintenanceList"];
        
        NSMutableArray *modelArr = [NSMutableArray array];
        
        JDLog(@"%@",response);
        // 字典转模型
        for (NSDictionary *dict in arr) {
            
            RepairData *data = [RepairData repairDataWithDictionary:dict];
            
            [modelArr addObject:data];
            
        }
        
        int returnCode = [response[@"returnCode"] intValue];
        
        if (returnCode == 0) {
            
            if (success) {
                success(modelArr);
            }
            
        }else if(returnCode ==2){//强制退出
            
            [GetData addAlertViewInView:Vc title:@"温馨提示" message:[NSString stringWithFormat:@"%@",response[@"msg"]] count:0 doWhat:^{
                
                //                    NSLog(@"success");
                /**
                 *  执行强制退出
                 */
                PersonalVC *p = [[PersonalVC alloc] init];
                [p removeFileAndInfo];
                
            }];
            
        }else{
            
            [GetData addAlertViewInView:Vc title:@"温馨提示" message:response[@"msg"] count:0 doWhat:^{
                
            }];
            
            
        }
        
        
    } failure:^(NSError *error) {
        
                    JDLog(@"%@",error);
        if (error) {
            
            if (failure) {
                failure(error);
            }
            
        }
        
    }];


}

@end
