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
#import "NSString+StringForUrl.h"

@implementation MyData


#pragma mark-获取个人信息数据解析
+(void)getPersonInfoWithCompletion:(void(^)(NSString * returnCode,NSString * msg,NSMutableDictionary * dic))block
{
    //设置一个字典来接返回的数据
    NSMutableDictionary * dictionary =[[NSMutableDictionary alloc]initWithCapacity:0];
    
    //设置输入参数 
//    NSDictionary * inDic1 =@{@"phoneNo":PHONENO,@"password":PASSWORD,@"loginTime":LOGINTIME};
    
    NSMutableDictionary *inDic = [NSMutableDictionary dictionary];
    inDic[@"phoneNo"] = PHONENO;
    inDic[@"password"] = PASSWORD;
    inDic[@"loginTime"] = LOGINTIME;
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];  
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    NSString * str =[NSString urlWithApiName:@"getDriverInfo2.json"];
    [manager POST:str parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

        JDLog(@"22222%@",responseObject);
        
        NSString * statusStr =[responseObject objectForKey:@"returnCode"];
        NSString * pushto=[responseObject objectForKey:@"pushno"];
        NSString * msg =[responseObject objectForKey:@"msg"];
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
            data.miles=[responseObject objectForKey:@"mileage"];
            
            //写一个数组来装属性 方便view界面展示
            data.contents=[[NSMutableArray alloc]initWithCapacity:0];
            [data.contents addObject:data.serviceNo];
            [data.contents addObject:data.taxiCompany];
            [data.contents addObject:data.plateNo];
            [data.contents addObject:data.engineNo];
            
            NSUserDefaults * us =[NSUserDefaults standardUserDefaults];

            
            if (![data.miles isEqual:[NSNull null]]) [us setValue:data.miles forKey:@"KM"];
            if (![data.plateNo isEqual:[NSNull null]]) [us setObject:data.plateNo forKey:@"plateNo"];
            if (![data.taxiCompany isEqual:[NSNull null]]) [us setObject:data.taxiCompany forKey:@"taxiCompany"];
            if (![pushto isEqual:[NSNull null]]) [us setValue:pushto forKey:@"pushno"];
            if (![data.name isEqual:[NSNull null]]) [us setObject:data.name forKey:@"name"];
            if (![data.serviceNo isEqual:[NSNull null]]) [us setObject:data.serviceNo forKey:@"serviceNo"];
            NSString * str =[data.engineNo substringWithRange:NSMakeRange(data.engineNo.length-6, 6)];
            if (![data.engineNo isEqual:[NSNull null]]) [us setObject:str forKey:@"engineNo"];
            
            [us synchronize];
            
            dictionary[@"info"]=data;
            block(statusStr,nil,dictionary);
            
        }
        else if (status==1)
        {
            block(@"1",msg,nil);
        }
        else
        {
            block(@"2",msg,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        block(@"666",nil,nil);
    }];
    
}

#pragma mark-积分查询数据返回

+(void)getScoreInfoWithBeginDate:(NSString *)begin WithOverDate:(NSString *)over withType:(NSString *)type Completion:(void(^)(NSString * returnCode,NSString * msg,NSMutableDictionary * dic))block
{
    NSMutableDictionary * dictionary =[[NSMutableDictionary alloc]initWithCapacity:0];
    NSMutableDictionary * inDic =[[NSMutableDictionary alloc]initWithCapacity:0];
    if ([type intValue]==0)
    {
        //查询收入记录
        NSMutableDictionary * dic1 =[NSMutableDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",PASSWORD,@"password",begin,@"beginDate",over,@"overDate",LOGINTIME,@"loginTime",type,@"type", nil];
        inDic=dic1;
    }
    else if ([type intValue]==1)
    {
        //查询支出记录
        NSMutableDictionary * dic2 =[NSMutableDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",PASSWORD,@"password",begin,@"beginDate",over,@"overDate",LOGINTIME,@"loginTime",type,@"type", nil];
        inDic=dic2;
    }
    else
    {
        //查询所有记录
        NSMutableDictionary * dic3 =[NSMutableDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",PASSWORD,@"password",begin,@"beginDate",over,@"overDate",LOGINTIME,@"loginTime", nil];
        inDic=dic3;
    }
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.requestSerializer.timeoutInterval=10;
    NSString * str =[NSString urlWithApiName:@"queryScore.json"];
    [manager POST:str parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
    {
        NSString * statusStr =[responseObject objectForKey:@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        int status =[statusStr intValue];
        if (status==0)
        {
            MyData * p =[[MyData alloc]init];
//            NSLog(@"scoreLeft--->%@",p.scoreLeft);
            p.scoreLeft=[responseObject objectForKey:@"totalScore"];
            NSUserDefaults * us =[NSUserDefaults standardUserDefaults];
            [us setValue:p.scoreLeft forKey:@"leftScore"];
            [us synchronize];
            NSArray * getArr =[responseObject objectForKey:@"Integrals"];
            
            //装入支出的数组
            NSMutableArray * outArr =[NSMutableArray array];
            //装入收入的数组
            NSMutableArray * inArr =[NSMutableArray array];
            
            for (NSDictionary * smallDic in getArr)
            {
                MyData * p =[[MyData alloc]init];
                p.score=smallDic[@"cost"];
                if ([p.score intValue]>0)
                {
                    p.score=smallDic[@"cost"];
                    p.goods=smallDic[@"costName"];
                    p.number=smallDic[@"costNumber"];
                    NSString * string =smallDic[@"updateDate"];
                    NSArray *array = [string componentsSeparatedByString:@"."];
                    p.datetime=[array firstObject];
                    [inArr addObject:p];
                }
                else
                {
                    p.score=smallDic[@"cost"];
                    p.goods=smallDic[@"costName"];
                    p.number=smallDic[@"costNumber"];
                    p.imageUrl=smallDic[@"imageUrl"];
                    NSString * string =smallDic[@"updateDate"];
                    NSArray *array = [string componentsSeparatedByString:@"."];
                    p.datetime=[array firstObject];
                    [outArr addObject:p];
                }
            }
            
            //将解析之后的两个数组都装入到大的一个字典里面
            [dictionary setObject:p.scoreLeft forKey:@"scoreLeft"];
            [dictionary setObject:outArr forKey:@"out"];
            [dictionary setObject:inArr forKey:@"in"];
            block(statusStr,nil,dictionary);
        }
        else if (status==1)
        {
            block(statusStr,msg,nil);
        }
        else
        {
            block(statusStr,msg,nil);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        block(@"666",nil,nil);
    }];
}


#pragma mark-登陆
-(void)goLoginWithloginWithPhoneNo:(NSString *)phone WithPsw:(NSString *)psw withPostType:(NSString *)type withManual:(NSString *)manual withMiles:(NSString *)miles withCompletion:(void(^)(NSString * returnCode,NSString * msg,NSString * checkFlg))block
{
    NSDictionary * inDic =[[NSDictionary alloc]init];
    if ([type intValue]==0)
    {
        NSString * cid =[[NSUserDefaults standardUserDefaults]objectForKey:@"clientID"];
        if ([manual intValue]==0)
        {
            NSDictionary * inDic1 =@{@"phoneNo":phone,@"password":psw,@"type":@"0",@"manual":@"0",@"loginTime":LOGINTIME,@"app":@"0"};
            inDic=inDic1;
            
            
        }
        else
        {
//            NSLog(@"clintID is %@",cid);
            JDLog(@"sussss");
            if (cid)
            {
                NSDictionary * inDic1 =@{@"phoneNo":phone,@"password":psw,@"type":@"0",@"manual":@"1",@"clientId":cid,@"app":@"0"};
                inDic=inDic1;
            }
            else
            {
                NSDictionary * inDic1 =@{@"phoneNo":phone,@"password":psw,@"type":@"0",@"manual":@"1",@"clientId":cid,@"app":@"0"};
                inDic=inDic1;
            }
        }
        
    }
    else if ([type intValue]==4)
    {
        
        NSDictionary * inDic2 =@{@"phoneNo":phone,@"password":psw,@"type":@"4",@"mileage":miles,@"loginTime":LOGINTIME};
        inDic=inDic2;
    }
    else
    {
        NSDictionary * inDic3 =@{@"phoneNo":phone,@"password":psw,@"type":@"5",@"loginTime":LOGINTIME};
        inDic=inDic3;
    }
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.requestSerializer.timeoutInterval=10;
    NSString * str =[NSString urlWithApiName:@"loginAndRegister.json"];
    [manager POST:str parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
    {
        JDLog(@"------>%@",responseObject);
        
        NSString * statusStr =[responseObject objectForKey:@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        NSString * checkFlg =[responseObject objectForKey:@"checkFlg"];
        NSString * loginTime = [responseObject objectForKey:@"loginTime"];
        NSUserDefaults * us =[NSUserDefaults standardUserDefaults];
        [us setValue:checkFlg forKey:@"checkFlg"];
        if (loginTime != nil)
        {
           [us setValue:loginTime forKey:@"loginTime"];
        }
        [us synchronize];
        if ([statusStr intValue]==0)
        {
            block(statusStr,nil,checkFlg);
        }
        else if ([statusStr intValue]==1)
        {
            block(statusStr,msg,nil);
        }
        else
        {
            block(statusStr,msg,nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        block(@"666",nil,nil);
        
        JDLog(@"%@",error);
    }];

}

#pragma mark-获取验证码接口

- (void)getconfirmCodeWithPhoneNo:(NSString *)newphone WithType:(NSString *)type WithCompletion:(void(^)(NSString * returnCode,NSString * number,NSString * msg))block
{
    NSDictionary * inDic =[[NSDictionary alloc]init];
    //二驾注册需要的验证码
    if ([type intValue]==1)
    {
        NSString * push =[[NSUserDefaults standardUserDefaults]objectForKey:@"pushno"];
//        NSDictionary * dic2 =[NSDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",PASSWORD,@"password",push,@"pushno",newphone,@"newPhoneNo",@"1",@"type",LOGINTIME,@"loginTime", nil];
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        dic1[@"phoneNo"] = PHONENO;
        dic1[@"type"] = @"1";
        dic1[@"password"] = PASSWORD;
        dic1[@"newPhoneNo"] = newphone;
        dic1[@"pushno"] = push;
        dic1[@"loginTime"] = LOGINTIME;
        
//        NSLog(@"%@",dic1);
        inDic =dic1;
//        NSLog(@"二驾注册");
    }
    //找回密码需要的验证码
    else if ([type intValue]==0)
    {
        
//        NSDictionary * dic2 =[NSDictionary dictionaryWithObjectsAndKeys:newphone,@"phoneNo",PASSWORD,@"password",@"0",@"type", nil];
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
        dic2[@"phoneNo"] = newphone;
        dic2[@"type"] = @"0";
//        dic2[@"password"] = PASSWORD;
//        dic2[@"newPhoneNo"] = newphone;
//        dic2[@"pushno"] = push;
//        dic2[@"loginTime"] = LOGINTIME;
//        NSLog(@"%@",dic2);
        inDic=dic2;
//        NSLog(@"找回密码");
    }
    //更换手机号需要的验证码
    else
    {
//        NSDictionary * dic3 =[NSDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",newphone,@"newPhoneNo",PASSWORD,@"password",@"2",@"type",LOGINTIME,@"loginTime", nil];
        NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
        dic3[@"phoneNo"] = PHONENO;
        dic3[@"type"] = @"2";
        dic3[@"password"] = PASSWORD;
        dic3[@"newPhoneNo"] = newphone;
        dic3[@"loginTime"] = LOGINTIME;
        
        inDic =dic3;
        NSLog(@"更换手机号");
    }
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    NSString * str =[NSString urlWithApiName:@"getSmsVaildCode.json"];
    [manager POST:str parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        JDLog(@"%@",responseObject);
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
        else if ([statusStr intValue]==1)
        {
            block(statusStr,nil,msg);
        }
        else
        {
            block(statusStr,nil,msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error)
    {
        block(@"666",nil,nil);
    }];
}

#pragma mark-获取找回密码的接口
- (void)getFindNewPasswordWithPhoneNo:(NSString *)phone WithNewPassword:(NSString *)password WithCompletion:(void(^)(NSString * returnCode,NSString * msg))block
{
//    NSDictionary * inDic1 =@{@"phoneNo":phone,@"newPassword":password,@"type":@"3",@"loginTime":LOGINTIME};
    
    NSMutableDictionary *inDic = [NSMutableDictionary dictionary];
    inDic[@"phoneNo"] = phone;
    inDic[@"newPassword"] = password;
    inDic[@"type"] = @"3";
//    inDic[@"loginTime"] = LOGINTIME;
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.requestSerializer.timeoutInterval=10;
    NSString * str =[NSString urlWithApiName:@"loginAndRegister.json"];
    [manager POST:str parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
    {
        JDLog(@"%@",responseObject[@"msg"]);
        
        NSString * returnCode =[responseObject objectForKey:@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([returnCode intValue]==0)
        {
           block(returnCode,nil);
        }
        else if ([returnCode intValue]==1)
        {
            block(@"1",msg);
        }
        else
        {
            block(@"2",msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error)
    {
        block(@"666",nil);
    }];
}
#pragma mark-获取修改密码接口
- (void)getChangeNewPasswordWithPhoneNo:(NSString * )phone WithPassword:(NSString *)password WithNewPassword:(NSString *)newP WithCompletion:(void(^)(NSString * returnCode,NSString *msg))block
{
    NSDictionary * inDic =@{@"phoneNo":phone,@"password":password,@"newPassword":newP,@"type":@"2",@"loginTime":LOGINTIME};
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.requestSerializer.timeoutInterval=10;
    NSString * str =[NSString urlWithApiName:@"loginAndRegister.json"];
    [manager POST:str parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
     {
         NSString * statusStr =[responseObject objectForKey:@"returnCode"];
         NSString * msg =[responseObject objectForKey:@"msg"];
         if ([statusStr intValue]==0)
         {
             block(statusStr,nil);
         }
         else if ([statusStr intValue]==1)
         {
             block(statusStr,msg);
         }
         else
         {
             block(statusStr,msg);
         }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error)
    {
        block(@"666",nil);
    }];
    
}

#pragma mark-获取查询违章信息接口
- (void)getPeccWithPhoneNo:(NSString *)phone WithPassword:(NSString *)password WithPlateNo:(NSString *)plate WithEngineNo:(NSString *)engineNo WithCompletion:(void(^)(NSString * returnCode,NSString * msg,NSMutableDictionary * dic))block
{
    //声明出来一个字典来接返回的数据
    NSMutableDictionary * dict =[NSMutableDictionary dictionary];
    
    //@"苏AJ08G9" @"005362"
    
//    NSDictionary * inDic1=[NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNo",password,@"password",PLATE,@"licenseNo",ENGINE,@"engineNo",LOGINTIME,@"loginTime", nil];
    
    NSMutableDictionary *inDic = [NSMutableDictionary dictionary];
    inDic[@"phoneNo"] = phone;
    inDic[@"password"] = password;
    inDic[@"licenseNo"] = plate;
    inDic[@"engineNo"] = engineNo;
    inDic[@"loginTime"] = LOGINTIME;
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.requestSerializer.timeoutInterval=10;
    NSString * str =[NSString urlWithApiName:@"getViolation.json"];
    [manager POST:str parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
    {
        NSString * statusStr =[responseObject objectForKey:@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        
//        NSLog(@"%@",responseObject);
        
        int status =[statusStr intValue];
        if (status==0)
        {
            //声明一个类对象 用其属性接返回的数据
            MyData * data =[MyData new];
            //声明一个数组去接数据中返回的数组
            NSMutableArray * arr =[[NSMutableArray alloc]initWithCapacity:0];
            
            data.pecc_status=[responseObject objectForKey:@"status"];
            data.pecc_totalPoint=[responseObject objectForKey:@"totalScore"];
            data.pecc_totalMoney=[responseObject objectForKey:@"totalMoney"];
            data.pecc_count=[responseObject objectForKey:@"count"];
            
            arr=[responseObject objectForKey:@"historys"];
            if (arr==nil)
            {
                NSLog(@"没有接收到数据");
            }
            else
            {
//                [dict setObject:data.pecc_totalPoint forKey:@"totalPoint"];
                [dict setObject:data.pecc_totalMoney forKey:@"totalMoney"];
                [dict setObject:data.pecc_count forKey:@"count"];
                [dict setObject:arr forKey:@"records"];
            }
            block(statusStr,nil,dict);
        }
        else if (status==1)
        {
            block(statusStr,msg,nil);
        }
        else
        {
            block(statusStr,msg,nil);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error)
    {
        block(@"666",nil,nil);
    }];
}

#pragma mark-获取设置界面接口
- (void)getSetWithIncomeSwitch:(NSString *)income WithBreakRulesSwitch:(NSString *)breakR WithIncomeTime:(NSString *)time WithCompletion:(void(^)(NSString * str,NSString * msg))block
{
    NSDictionary * inDic =[NSDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",PASSWORD,@"password",income,@"incomeNoticeSwitch",breakR,@"breakRulesNoticeSwitch",time,@"incomeNoticeTime",LOGINTIME,@"loginTime", nil];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    NSString * str =[NSString urlWithApiName:@"setting.json"];
    [manager POST:str parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * returnCode =[responseObject objectForKey:@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([returnCode intValue]==0)
        {
            block(returnCode,nil);
        }
        else if ([returnCode intValue]==1)
        {
            block(returnCode,msg);
        }
        else
        {
            block(returnCode,msg);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        block(@"666",@"网络链接失败");
    }];
}
#pragma mark-编辑个人信息
- (void)getEditPersonInfoWithCompletion:(void(^)(NSString * str,NSString * msg))block
{
    NSDictionary * inDic =[NSDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",PASSWORD,@"password",LOGINTIME,@"loginTime", nil];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.requestSerializer.timeoutInterval=10;
    NSString * str =[NSString urlWithApiName:@"getEditPersonalInfo.json"];
    [manager POST:str parameters:inDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData * data =[[NSData alloc]initWithContentsOfFile:[NSHomeDirectory()stringByAppendingPathComponent:@"Documents/pic.zip"]];
        /**
         *  1参将要上传的数据
         *  2参你上传的参数的名称
         *  3参定义你上传的文件的名称
         *  4参你上传的文件的类型
         */
        [formData appendPartWithFileData:data name:@"file" fileName:@"pic.zip" mimeType:@"application/octet-stream"];
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSLog(@"aaaa%@",responseObject);
        NSString * returnCode =[responseObject objectForKey:@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([returnCode intValue]==0)
        {
            block(returnCode,nil);
        }
        else if ([returnCode intValue]==1)
        {
            block(returnCode,msg);
        }
        else
        {
            block(returnCode,msg);
        }
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        block(@"666",nil);
    }];
}

#pragma mark-更换手机号码
- (void)getChangeNewPhoneWithPhoneNo:(NSString *)phone WithNewPhoneNo:(NSString *)nPhone WithType:(NSString *)type WithCompletionBlock:(void(^)(NSString * returnCode,NSString * msg))block
{
    NSDictionary * inDic =[NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNo",nPhone,@"newPhoneNo",PASSWORD,@"password",type,@"type",LOGINTIME,@"loginTime", nil];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.requestSerializer.timeoutInterval=10;
    NSString * str =[NSString urlWithApiName:@"loginAndRegister.json"];
    [manager POST:str parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * statusStr =[responseObject objectForKey:@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([statusStr intValue]==0)
        {
            block(statusStr,nil);
        }
        else if ([statusStr intValue]==1)
        {
            block(statusStr,msg);
        }
        else
        {
            block(statusStr,msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        block(@"666",nil);
    }];
}
#pragma mark-查询预约信息
- (void)getOrderTableWithType:(NSString *)type withCompletionBlock:(void(^)(NSMutableDictionary * dict,NSString * returnCode,NSString * msg))block
{
    //初始化一个回传的字典
    NSMutableDictionary * dict =[[NSMutableDictionary alloc] initWithCapacity:0];
    NSMutableDictionary * inDic =[[NSMutableDictionary alloc] initWithCapacity:0];
    if ([type intValue]==1)
    {
        
        NSMutableDictionary * dic1 =[NSMutableDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",PASSWORD,@"password",@"1",@"type",LOGINTIME,@"loginTime", nil];
        inDic=dic1;
    }
    else
    {
        NSMutableDictionary * dic2 =[NSMutableDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",PASSWORD,@"password",@"4",@"type",LOGINTIME,@"loginTime", nil];
        inDic=dic2;
    }
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.requestSerializer.timeoutInterval=10;
    NSString * str =[NSString urlWithApiName:@"getReservationInfo.json"];
    [manager POST:str parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        JDLog(@"response---。。。%@",responseObject);
        
        NSString * statusStr =[responseObject objectForKey:@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([statusStr intValue]==0)
        {
            NSArray * arr =[responseObject objectForKey:@"reservationList"];
            NSMutableArray * ordingArr =[[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray * completeArr =[[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray * cancelArr =[[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary * smallDic in arr)
            {
                MyData * data =[[MyData alloc] init];
                data.addressName=[smallDic objectForKey:@"addressName"];
                data.optioinTel=[smallDic objectForKey:@"tel"];
                data.addressId=[smallDic objectForKey:@"id"];
                data.dateStart=[smallDic objectForKey:@"dateStart"];
                data.startTime=[smallDic objectForKey:@"startTime"];
                data.optionName=[smallDic objectForKey:@"optionName"];
                data.delFlg=[smallDic objectForKey:@"delFlg"];
                data.wholeTime=[NSString stringWithFormat:@"%@ %@:00",data.dateStart,data.startTime]; 
                switch ([data.delFlg intValue])
                {
                    case 0: //预约中
                        [ordingArr addObject:data];
                        break;
                    case 1:   //预约完成
                        [completeArr addObject:data];
                        break;
                    case 2:  //预约取消
                        [cancelArr addObject:data];
                        break;
                        
                    default:
                        break;
                }
                [dict setObject:ordingArr forKey:@"ording"];
                [dict setObject:completeArr forKey:@"complete"];
                [dict setObject:cancelArr forKey:@"cancel"];
            }
            block(dict,statusStr,nil);
        }
        else if ([statusStr intValue]==1)
        {
            block(nil,statusStr,msg);
        }
        else
        {
            block(nil,statusStr,msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        block(nil,@"666",nil);
    }];
}

#pragma mark - 取消预约接口
- (void)getCancelOrderWithOptionID:(NSString *)optionID withType:(NSString *)type withCompletionBlock:(void(^)(NSString * returnCode,NSString * msg))block
{
    NSDictionary * inDic =[[NSDictionary alloc] init];
    if ([type intValue]==3)
    {
        NSDictionary * dic1 =[NSDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",PASSWORD,@"password",optionID,@"id",@"3",@"type",LOGINTIME,@"loginTime",nil];
        inDic=dic1;
    }
    else
    {
        NSDictionary * dic2 =[NSDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",PASSWORD,@"password",optionID,@"id",@"4",@"type",LOGINTIME,@"loginTime",nil];
        inDic=dic2;
    }
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.requestSerializer.timeoutInterval=10;
    NSString * str =[NSString urlWithApiName:@"getReservationInfo.json"];
    [manager POST:str parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * returnCode =[responseObject objectForKey:@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        if ([returnCode intValue]==0)
        {
            block(returnCode,nil);
        }
        else if ([returnCode intValue]==1)
        {
            block(returnCode,msg);
        }
        else
        {
            block(returnCode,msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        block(@"666",nil);
    }];
}
#pragma mark- 处理违章记录
- (void)getSubmitePeccInfoWithSpendPoint:(NSString *)point withViolations:(NSMutableString *)violation withCompletionBlock:(void(^)(NSString * returnCode,NSString * msg))block
{
    NSDictionary * inDic =[NSDictionary dictionaryWithObjectsAndKeys:PHONENO,@"phoneNo",PASSWORD,@"password",LOGINTIME,@"loginTime",@"苏AJ08G9",@"licenseNo",@"005362",@"engineNo",point,@"cost",violation,@"violations", nil];
    JDLog(@"the dic is %@",inDic);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    manager.requestSerializer.timeoutInterval=10;
    NSString * str=[NSString urlWithApiName:@"handleViolation.json"];
    [manager POST:str parameters:inDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString * returnCode =[responseObject objectForKey:@"returnCode"];
        NSString * msg =[responseObject objectForKey:@"msg"];
        NSString * leftScore =[responseObject objectForKey:@"leftScore"];
        NSUserDefaults * us =[NSUserDefaults standardUserDefaults];
        if (leftScore != nil)
        {
            [us setValue:leftScore forKey:@"leftScore"];
        }
        [us synchronize];
        if ([returnCode intValue]==0)
        {
            block(returnCode,nil);
        }
        else if ([returnCode intValue]==1)
        {
            block(returnCode,msg);
        }
        else
        {
            block(returnCode,msg);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        block(@"666",nil);
    }];
}
@end
