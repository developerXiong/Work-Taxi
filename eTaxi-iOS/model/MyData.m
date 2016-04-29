//
//  MyData.m
//  E+TAXI
//
//  Created by jeader on 15/12/26.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import "MyData.h"
#import "AFNetworking.h"
#import "HeadFile.pch"
#import "MyTool.h"

@implementation MyData


//获取个人信息数据解析
+(void)getPersonInfoWithCompletion:(void(^)(NSMutableDictionary * dic))block
{
    //设置一个字典来接返回的数据
    NSMutableDictionary * dictionary =[[NSMutableDictionary alloc]initWithCapacity:0];
    
    //设置输入参数 
    NSDictionary * inDic =@{@"phoneNo":PHONENO,@"password":PASSWORD};
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];

    [manager POST:@"http://192.168.1.100:8080/tad/client/getDriverInfo2.json" parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString * statusStr =[responseObject objectForKey:@"returnCode"];
        int status =[statusStr intValue];
        if (status==0)
        {
            MyData * data = [MyData new];
            data.driverStatus=[responseObject objectForKey:@"driverStatus"];
            data.name=[responseObject objectForKey:@"name"];
            data.avataraUrl=[responseObject objectForKey:@"avataraUrl"];
            data.serviceNo=[responseObject objectForKey:@"serviceNo"];
            data.taxiCompany=[responseObject objectForKey:@"taxiCompany"];
            
            data.plateNo=[responseObject objectForKey:@"plateNo"];
            data.engineNo=[responseObject objectForKey:@"engineNo"];
            //写一个数组来装属性 方便view界面展示
            data.contents=[[NSMutableArray alloc]initWithCapacity:0];
            [data.contents addObject:data.serviceNo];
            [data.contents addObject:data.taxiCompany];
            [data.contents addObject:data.plateNo];
            [data.contents addObject:data.engineNo];
            
            NSUserDefaults * us =[NSUserDefaults standardUserDefaults];
            [us setObject:data.plateNo forKey:@"plateNo"];
            [us setObject:data.engineNo forKey:@"engineNo"];
            [us synchronize];
            
            dictionary[@"info"]=data;
        }
        block(dictionary);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"网络请求失败");
    }];
    
}

/**
 *  积分查询数据返回
 */
+(void)getScoreInfoWithBeginDate:(NSString *)begin WithOverDate:(NSString *)over Completion:(void(^)(NSMutableDictionary * dic))block
{

    NSMutableDictionary * dictionary =[[NSMutableDictionary alloc]initWithCapacity:0];
    NSDictionary * inDic =[NSDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",PASSWORD,@"password",begin,@"beginDate",over,@"overDate", nil];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    
    [manager POST:@"http://192.168.1.123:8080/tad/client/queryScore.json" parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
    {
        NSString * statusStr =[responseObject objectForKey:@"returnCode"];
        int status =[statusStr intValue];
        if (status==0)
        {
            MyData * p =[[MyData alloc]init];
            p.scoreLeft=[responseObject objectForKey:@"scoreLeft"];
            //装载支出数组
            NSArray * outtBigArr =[responseObject objectForKey:@"expendHistory"];
            
            //装载收入的数组
            NSArray * innBigArr =[responseObject objectForKey:@"incomeHistory"];
            
            //接解析之后支出的数组
            NSMutableArray * outArr =[NSMutableArray array];
            for (NSDictionary * smallDic in outtBigArr)
            {
                MyData * p =[[MyData alloc]init];
                p.score=smallDic[@"score"];
                p.address=[smallDic objectForKey:@"address"];
                p.datetime=[smallDic objectForKey:@"datetime"];
                p.goods=[smallDic objectForKey:@"goods"];
                [outArr addObject:p];
            }

            //接解析之后收入的数组
            NSMutableArray * inArr =[NSMutableArray array];
            for (NSDictionary * smallDic in innBigArr)
            {
                MyData * p =[[MyData alloc]init];
                p.in_datetime=[smallDic objectForKey:@"datetime"];
                p.in_score =[smallDic objectForKey:@"score"];
                p.in_name=[smallDic objectForKey:@"name"];
                [inArr addObject:p];
            }
            
            
            //将解析之后的两个数组都装入到大的一个字典里面
            [dictionary setObject:p.scoreLeft forKey:@"scoreLeft"];
            [dictionary setObject:outArr forKey:@"out"];
            [dictionary setObject:inArr forKey:@"in"];
            
        }
        block(dictionary);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"网络请求失败");
    }];
}


/**
 *  登陆
 */
-(void)goLoginWithloginWithPhoneNo:(NSString *)phone WithPsw:(NSString *)psw withCompletion:(void(^)(NSString * returnCode,NSString * msg))block
{
    
    NSDictionary * inDic =@{@"phoneNo":phone,@"password":psw,@"type":@"0",@"role":@"0"};
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.requestSerializer.timeoutInterval=10;
    [manager POST:@"http://192.168.1.100:8080/tad/client/loginAndRegister.json" parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
    {
        NSString * statusStr =[responseObject objectForKey:@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([statusStr intValue]==0)
        {
            block(statusStr,nil);
        }
        else
        {
            block(statusStr,msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"网络请求失败");
        NSString * statusStr =@"1";
        block(statusStr,nil);
    }];

}

/**
 *  获取验证码接口
 */

- (void)getconfirmCodeWithPhoneNo:(NSString *)newphone WithType:(NSString *)type WithCompletion:(void(^)(NSString * returnCode,NSString * number,NSString * msg))block
{
    NSDictionary * inDic =[[NSDictionary alloc]init];
    //二驾注册需要的验证码
    if ([type intValue]==1)
    {
        NSDictionary * dic1 =[NSDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",newphone,@"newPhoneNo",@"1",@"type",@"0",@"role", nil];
        inDic =dic1;
        NSLog(@"二驾注册");
    }
    //找回密码需要的验证码
    else if ([type intValue]==0)
    {
        NSDictionary * dic2 =[NSDictionary dictionaryWithObjectsAndKeys:newphone,@"phoneNo",@"0",@"type",@"0",@"role", nil];
        inDic=dic2;
        NSLog(@"找回密码");
    }
    //更换手机号需要的验证码
    else
    {
        NSDictionary * dic3 =[NSDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",newphone,@"newPhoneNo",@"2",@"type",@"0",@"role", nil];
        inDic =dic3;
        NSLog(@"更换手机号");
    }
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    [manager POST:@"http://192.168.1.100:8080/tad/client/getSmsVaildCode.json" parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * statusStr =[responseObject objectForKey:@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([statusStr intValue]==0)
        {
            NSString * confirmStr =[responseObject objectForKey:@"validCode"];
            NSDate * date =[NSDate dateWithTimeIntervalSinceNow:180];
            NSUserDefaults * us =[NSUserDefaults standardUserDefaults];
            [us setObject:date forKey:@"time"];
            [us synchronize];
            
            block(statusStr,confirmStr,nil);
        }
        else
        {
            block(statusStr,nil,msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error)
    {
        NSLog(@"请求网络失败");
    }];
}

/**
 *  获取找回密码的接口
 */
- (void)getFindNewPasswordWithPhoneNo:(NSString *)phone WithNewPassword:(NSString *)password WithCompletion:(void(^)(NSString * returnCode))block
{
    NSDictionary * inDic =@{@"phoneNo":phone,@"newPassword":password,@"type":@"3",@"role":@"0"};
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.requestSerializer.timeoutInterval=10;
    [manager POST:@"http://192.168.1.100:8080/tad/client/loginAndRegister.json" parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
    {
        NSString * returnCode =[responseObject objectForKey:@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([returnCode intValue]==0)
        {
           block(returnCode);
        }
        else
        {
            block(msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error)
    {
        NSLog(@"请求网络失败");
    }];
}
/**
 *  获取修改密码接口
 */
- (void)getChangeNewPasswordWithPhoneNo:(NSString * )phone WithPassword:(NSString *)password WithNewPassword:(NSString *)newP WithCompletion:(void(^)(NSString * returnCode,NSString *msg))block
{
    NSDictionary * inDic =@{@"phoneNo":phone,@"password":password,@"newPassword":newP,@"type":@"2",@"role":@"0"};
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.requestSerializer.timeoutInterval=10;
    [manager POST:@"http://192.168.1.100:8080/tad/client/loginAndRegister.json" parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
     {
         NSString * statusStr =[responseObject objectForKey:@"returnCode"];
         NSString * msg =[responseObject objectForKey:@"msg"];
         if ([statusStr intValue]==0)
         {
             block(statusStr,nil);
         }
         else
         {
             
             block(statusStr,msg);
         }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error)
    {
        NSLog(@"网络请求失败");
    }];
    
}

/**
 *  获取查询违章信息接口
 */
- (void)getPeccWithPhoneNo:(NSString *)phone WithPassword:(NSString *)password WithPlateNo:(NSString *)plate WithEngineNo:(NSString *)engineNo WithCompletion:(void(^)(NSMutableDictionary * dic))block
{
    //声明出来一个字典来接返回的数据
    NSMutableDictionary * dict =[NSMutableDictionary dictionary];
    
    NSDictionary * inDic=[NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNo",password,@"password",@"苏A85200",@"licenseNo",@"364954",@"engineNo", nil];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    [manager POST:@"http://192.168.1.100:8080/tad/client/getViolation.json" parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
    {
        NSString * statusStr =[responseObject objectForKey:@"returnCode"];
        int status =[statusStr intValue];
        if (status==0)
        {
            //声明一个类对象 用其属性接返回的数据
            MyData * data =[MyData new];
            //声明一个数组去接数据中返回的数组
            NSMutableArray * arr =[[NSMutableArray alloc]initWithCapacity:0];
            
            //用一个数组去装 解析整理好的数据
            NSMutableArray * array =[[NSMutableArray alloc]initWithCapacity:0];
            
            data.pecc_status=[responseObject objectForKey:@"status"];
            data.pecc_totalPoint=[responseObject objectForKey:@"totalScore"];
            data.pecc_totalMoney=[responseObject objectForKey:@"totalMoney"];
            data.pecc_count=[responseObject objectForKey:@"count"];
            
            
            arr=[responseObject objectForKey:@"historys"];
            for (NSDictionary * smallDic in arr)
            {
                MyData * p =[MyData new];
                p.pecc_handle =[smallDic objectForKey:@"status"];
                p.pecc_point=[smallDic objectForKey:@"fen"];
                p.pecc_officer=[smallDic objectForKey:@"officer"];
                p.pecc_money=[smallDic objectForKey:@"money"];
                p.pecc_info=[smallDic objectForKey:@"info"];
                p.pecc_date=[smallDic objectForKey:@"occur_date"];
                p.pecc_address=[smallDic objectForKey:@"occur_area"];
                p.pecc_cityName=[smallDic objectForKey:@"city_name"];
                p.pecc_provinceName=[smallDic objectForKey:@"provinceName"];
                [array addObject:p];
            }
            [dict setObject:data.pecc_status forKey:@"status"];
            [dict setObject:data.pecc_totalPoint forKey:@"totalPoint"];
            [dict setObject:data.pecc_totalMoney forKey:@"totalMoney"];
            [dict setObject:data.pecc_count forKey:@"count"];
            [dict setObject:array forKey:@"records"];
            
            block(dict);
            
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error)
    {
        NSLog(@"网络请求失败");
    }];
}

/**
 *  获取设置界面接口
 */
- (void)getSetWithIncomeSwitch:(NSString *)income WithBreakRulesSwitch:(NSString *)breakR WithIncomeTime:(NSString *)time WithCompletion:(void(^)(NSString * str,NSString * msg))block
{
    NSDictionary * inDic =[NSDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",PASSWORD,@"password",income,@"incomeNoticeSwitch",breakR,@"breakRulesNoticeSwitch",time,@"incomeNoticeTime", nil];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    [manager POST:@"http://192.168.1.123:8080/tad/client/setting.json" parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * returnCode =[responseObject objectForKey:@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([returnCode intValue]==0)
        {
            block(returnCode,nil);
        }
        else
        {
            block(returnCode,msg);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}
/**
 *  编辑个人信息
 */
- (void)getEditPersonInfoWithCompletion:(void(^)(NSString * str))block
{
    NSDictionary * inDic =[NSDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",PASSWORD,@"password", nil];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    [manager POST:@"http://192.168.1.100:8080/tad/client/getEditPersonalInfo.json" parameters:inDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData * data =[[NSData alloc]initWithContentsOfFile:[NSHomeDirectory()stringByAppendingPathComponent:@"Documents/pic.zip"]];
        /**
         *  1参将要上传的数据
         *  2参你上传的参数的名称
         *  3参定义你上传的文件的名称
         *  4参你上传的文件的类型
         */
        [formData appendPartWithFileData:data name:@"file" fileName:@"pic.zip" mimeType:@"application/octet-stream"];
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * returnCode =[responseObject objectForKey:@"returnCode"];
        block(returnCode);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"网络请求错误");
    }];
}

/**
 *  更换手机号码
 */
- (void)getChangeNewPhoneWithPhoneNo:(NSString *)phone WithNewPhoneNo:(NSString *)nPhone WithType:(NSString *)type WithCompletionBlock:(void(^)(NSString * returnCode,NSString * msg))block
{
    NSDictionary * inDic =[NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNo",nPhone,@"newPhoneNo",PASSWORD,@"password",type,@"type",@"0",@"role", nil];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.requestSerializer.timeoutInterval=10;
    [manager POST:@"http://192.168.1.100:8080/tad/client/loginAndRegister.json" parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * statusStr =[responseObject objectForKey:@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([statusStr intValue]==0)
        {
            block(statusStr,nil);
        }
        else
        {
            
            block(statusStr,msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"网络请求失败");
    }];
    
    
}
@end
