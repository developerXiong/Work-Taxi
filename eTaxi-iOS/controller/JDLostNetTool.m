//
//  JDLostNetTool.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/8.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDLostNetTool.h"

#import "HeadFile.pch"
#import "JDLostData.h"
#import "JDLostDataTool.h"
#import "JDIsNetwork.h"

@implementation JDLostNetTool

//获取失物信息接口
+(void)lostDataInVC:(UIViewController *)Vc Success:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"type"] = @"0"; //请求申报记录
    params[@"phoneNo"] = PHONENO;
    params[@"password"] = PASSWORD;
    params[@"loginTime"] = LOGINTIME;
    
    [GetData getDataWithUrl:[NSString urlWithApiName:@"getLostAndRoadRecord.json"] params:params success:^(id response) {
       

        JDLog(@"lost time====%@",response);
        
        int returnCode = [response[@"returnCode"] intValue];
        
        NSArray *dictArr = (NSArray *)response[@"lostArr"];
        
        NSMutableArray *dataArr = [NSMutableArray array];
        if (returnCode == 0) {
            
            NSInteger count = 0;
            // 只取100条数据
            if (dictArr.count<=100) {
                
                count = dictArr.count;
                
            }else{
                
                count = 100;
                
            }
            
            for (int i = 0; i < count; i++) {
                
                NSDictionary *dict = (NSDictionary *)dictArr[i];
                
                JDLostData *lostData = [JDLostData lostDataWithDict:dict];
                
                [dataArr addObject:lostData];
                
            }
            
            success(dataArr);
            
        }else if(returnCode ==2){//强制退出
            
            [GetData addAlertViewInView:Vc title:@"温馨提示" message:[NSString stringWithFormat:@"%@",response[@"msg"]] count:0 doWhat:^{
                
                /**
                 *  执行强制退出
                 */
                PersonalVC *p = [[PersonalVC alloc] init];
                [p removeFileAndInfo];
                
            }];
            
        }
        
        
    } failure:^(NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}

//上传失物信息接口
+(void)sendLostDataInVC:(UIViewController *)Vc lostType:(NSString *)styleStr image:(UIImage *)image Success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"YYYYMMdd";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phoneNo"] = PHONENO;
    params[@"password"] = PASSWORD;
    params[@"loginTime"] = LOGINTIME;
    params[@"role"] = @"0";
    params[@"lostType"] = styleStr;
    params[@"lostTime"] = [fmt stringFromDate:[NSDate date]];
    
    
    if (![JDIsNetwork sharedInstance]) {
        
        [GetData addAlertViewInView:Vc title:@"温馨提示" message:@"网络无连接" count:0 doWhat:^{
            
        }];
        
    }else{
        
        [GetData addMBProgressWithView:Vc.view style:0];
        [GetData showMBWithTitle:@"正在提交"];
        //2秒延时之后隐藏MB
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [GetData hiddenMB];
        });
        
        NSString *url = @"lostAndFound.json";
        
        [GetData postDataWithUrl:[NSString urlWithApiName:url] params:params imageDatas:@[image] success:^(id response) {
            
            int returnCode = [response[@"returnCode"] intValue];
            
            if (returnCode == 0) {
                
                [GetData hiddenMB];
                
                success();
                
                [GetData addAlertViewInView:Vc title:@"温馨提示" message:@"上传成功！感谢您的参与！" count:0 doWhat:^{
                    
                    
                }];
                
            }else if(returnCode == 2){
                
                [GetData addAlertViewInView:Vc title:@"温馨提示" message:[NSString stringWithFormat:@"%@",response[@"msg"]] count:0 doWhat:^{
                    
                    /**
                     *  执行强制退出
                     */
                    PersonalVC *p = [[PersonalVC alloc] init];
                    [p removeFileAndInfo];
                }];
                
            }else{
                
                [GetData hiddenMB];
                [GetData addAlertViewInView:Vc title:@"温馨提示" message:[NSString stringWithFormat:@"%@",response[@"msg"]] count:0 doWhat:^{
                    
                }];
            }
            
        } failure:^(NSError *error) {
            
            //            NSLog(@"%@",error);
            
            if (error) {
                
                failure(error);
                [GetData addAlertViewInView:Vc title:@"温馨提示" message:@"上传失败！" count:0 doWhat:^{
                    
                }];
            }
            
            
        }];
        
        
    }

}

+(void)sendLostDataInVC:(UIViewController *)Vc Describe:(NSString *)describe returnID:(NSString *)returnId Success:(void (^)())success failure:(void (^)(NSError *))failure
{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"phoneNo"] = PHONENO;
        params[@"password"] = PASSWORD;
        params[@"loginTime"] = LOGINTIME;
        params[@"describe"] = describe;
        params[@"returnID"] = returnId;
    
        [GetData getDataWithUrl:[NSString urlWithApiName:@"lostAndFound.json"] params:params success:^(id response) {
    
            int returnCode = [response[@"returnCode"] intValue];
    
            if (returnCode == 0) {
    
                
                if (success) {
                    success();
                }
                
    
            }else if(returnCode == 2){
    
                [GetData addAlertViewInView:Vc title:@"温馨提示" message:[NSString stringWithFormat:@"%@",response[@"msg"]] count:0 doWhat:^{
    
                    /**
                     *  执行强制退出
                     */
                    PersonalVC *p = [[PersonalVC alloc] init];
                    [p removeFileAndInfo];
                }];
    
            }
            
        } failure:^(NSError *error) {
            
            if (failure) {
                failure(error);
            }
            
        }];

}

@end
