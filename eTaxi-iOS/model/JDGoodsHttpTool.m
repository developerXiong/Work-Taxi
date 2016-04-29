//
//  JDGoodsHttpTool.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDGoodsHttpTool.h"

#import "HeadFile.pch"

#import "JDGoodsData.h"

@implementation JDGoodsHttpTool

+(void)getGoodsInfoInVC:(UIViewController *)VC Success:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *))failure
{
    /**
     *  要上传到服务器的参数
     */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"faceto"] = @"1";
    
    [GetData getDataWithUrl:[NSString urlWithApiName:@"getPointPromotionalGoodsInfo.json"] params:params success:^(id response) {
        
        JDLog(@"%@",response);
        
        int returnCode = [response[@"returnCode"] intValue];
        
        if (returnCode == 0) {
            
            NSArray *arr = response[@"goods"];
            
            NSMutableArray *modelArr = [NSMutableArray array];
            
            for (NSDictionary *dict in arr) {
                
                JDGoodsData *data = [JDGoodsData goodsDataWithDict:dict];
                
                [modelArr addObject:data];
                
            }
            
            if (success) {
                success(modelArr);
            }
            
            
        }else{//强制退出
            
            [GetData addAlertViewInView:VC title:@"温馨提示" message:[NSString stringWithFormat:@"%@",response[@"msg"]] count:0 doWhat:^{
                
                /**
                 *  执行强制退出
                 */
                PersonalVC *p = [[PersonalVC alloc] init];
                [p removeFileAndInfo];
                
                
            }];
            
        }
        
        
        
    } failure:^(NSError *error) {
        
        JDLog(@"%@",error);
        
    }];


}

+(void)exchangeGoodsWithCount:(int)number goodsID:(int)goodsID inVc:(UIViewController *)VC success:(void (^)(int))success failure:(void (^)(NSError *))failure
{
    
    [GetData addAlertViewInView:VC title:@"温馨提示" message:@"您确定要兑换吗？" count:1 doWhat:^{
        
        [GetData addMBProgressWithView:VC.view style:0];
        [GetData showMBWithTitle:@"正在兑换"];
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int16_t)(2.0*NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            
            [GetData hiddenMB];
            
        });
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"phoneNo"] = PHONENO;
        params[@"password"] = PASSWORD;
        params[@"loginTime"] = LOGINTIME;
        params[@"costNumber"] = [NSString stringWithFormat:@"%d",number]; //购买的个数
        params[@"goodId"] = [NSString stringWithFormat:@"%d",goodsID];
        
        
        [GetData getDataWithUrl:[NSString urlWithApiName:@"costScore.json"] params:params success:^(id response) {
            
            int returnCode = [response[@"returnCode"] intValue];
            
            if (returnCode == 0) {
                
                [GetData hiddenMB];
                
                [GetData addAlertViewInView:VC title:@"温馨提示" message:@"恭喜您！兑换成功!" count:0 doWhat:^{
                    
                    if (success) {
                        success(returnCode);
                    }
                    
                }];
                
            }else if(returnCode ==2){//强制退出
                
                [GetData addAlertViewInView:VC title:@"温馨提示" message:[NSString stringWithFormat:@"%@",response[@"msg"]] count:0 doWhat:^{
                    
                    //                            NSLog(@"success");
                    /**
                     *  执行强制退出
                     */
                    PersonalVC *p = [[PersonalVC alloc] init];
                    [p removeFileAndInfo];
                    
                    
                }];
                
            }else{
                
                [GetData hiddenMB];
                
                [GetData addAlertViewInView:VC title:@"温馨提示" message:[NSString stringWithFormat:@"%@",response[@"msg"]] count:0 doWhat:^{
                    
                }];
            }
            
        } failure:^(NSError *error) {
            
               JDLog(@"%@",error);
            
        }];
        
    }];
    
}


@end
