//
//  MyTool.m
//  eTaxi-iOS
//
//  Created by jeader on 15/12/31.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import "MyTool.h"
#import "AFNetworkReachabilityManager.h"
#import "PersonalVC.h"
#define IAIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@implementation MyTool


+ (BOOL)isLogin
{
    //判断有没有token值
    NSString * phoneNo = [[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
    NSString * password =[[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    
    if (phoneNo==nil||password==nil)
    {
        return NO;
    }

    return YES;
}
+ (BOOL)validatePhone:(NSString *) textString
{
    NSString* phone=@"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phone];
    return [numberPre evaluateWithObject:textString];
}

+ (BOOL)validatePassword:(NSString *) textString
{
    NSString* password=@"^[0-9]{6}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",password];
    return [numberPre evaluateWithObject:textString];
}
- (UIAlertController *)showAlertControllerWithTitle:(NSString *)title WithMessages:(NSString *)msg WithCancelTitle:(NSString *)cancelTitle
{
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancel =[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    return alert;
}

+(void)checkNetWorkWithCompltion:(void(^)(NSInteger statusCode))block
{
    NSInteger __block code = 0;
    AFNetworkReachabilityManager * manager =[AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable)
        {
            code = 0;
        }
        else
        {
            code = 1;
        }
        block(code);
    }];
    
}
+ (NSMutableArray*)getAnalysisWithSmallArr:(NSMutableArray *)arr
{
    NSLog(@"%@",arr);
    NSMutableArray * peccArr1 =[NSMutableArray array]; // 放未处理的数据
    NSMutableArray * peccArr2 =[NSMutableArray array]; // 处理中
    NSMutableArray * peccArr3 =[NSMutableArray array]; // 扣分
    NSMutableArray * peccArr =[NSMutableArray array]; // 整体的数组
    
    
    
    for (NSDictionary * smallDic in arr)
    {
        if ([smallDic[@"result"] isEqualToString:@"未处理"]) {
            if ([smallDic[@"fen"] intValue]==0) {
                
                [peccArr1 addObject:smallDic]; // 未处理 不扣分
            }else{
                [peccArr3 addObject:smallDic]; // 未处理 扣分
            }
        }else if ([smallDic[@"result"] isEqualToString:@"已受理"]){
            [peccArr2 addObject:smallDic];
        }
       
    }
    
    for (NSDictionary *smallDic in peccArr1) {
        
        MyTool * p = [[[self alloc] init] modelArrWithDict:smallDic];
        
        [peccArr addObject:p];
        
    }
    
    for (NSDictionary *smallDic in peccArr2) {
        
        MyTool * p = [[[self alloc] init] modelArrWithDict:smallDic];
        
        [peccArr addObject:p];
    }
    
    for (NSDictionary *smallDic in peccArr3) {
        
        MyTool * p = [[[self alloc] init] modelArrWithDict:smallDic];
        
        [peccArr addObject:p];
    }
    
    return peccArr;
}

-(instancetype)modelArrWithDict:(NSDictionary *)smallDic
{
    MyTool * p =[[MyTool alloc] init];
    p.pecc_handle =[smallDic objectForKey:@"status"];
    p.pecc_point=[smallDic objectForKey:@"fen"];
    p.pecc_officer=[smallDic objectForKey:@"officer"];
    p.pecc_money=[smallDic objectForKey:@"money"];
    p.pecc_info=[smallDic objectForKey:@"info"];
    p.pecc_date=[smallDic objectForKey:@"occur_date"];
    p.pecc_address=[smallDic objectForKey:@"occur_area"];
    p.pecc_cityName=[smallDic objectForKey:@"city_name"];
    p.pecc_provinceName=[smallDic objectForKey:@"provinceName"];
    p.pecc_id=[smallDic objectForKey:@"id"];
    p.pecc_result=[smallDic objectForKey:@"result"];
    return p;
}

@end
