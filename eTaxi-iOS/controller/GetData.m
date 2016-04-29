//
//  GetData.m
//  eTaxi-iOS
//
//  Created by jeader on 15/12/31.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import "GetData.h"

#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface GetData ()


@end

static MBProgressHUD *_mbV;

@implementation GetData

//请求网络数据
+(void)getDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"text/xml",nil]];
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
}

//上传图片
+(void)postDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params imageDatas:(NSArray *)images success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"text/xml",nil]];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (images==nil) {
            return ;
        }
        for (UIImage *image in images) {
            NSData *imageData = UIImagePNGRepresentation(image);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            
            /*
            此方法参数
            1. 要上传的[二进制数据]
            2. 对应网站上[upload.php中]处理文件的[字段"file"]
            3. 要保存在服务器上的[文件名]
             4. 上传文件的[mimeType]
            */
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
            
        }
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        success(responseObject);

        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

+ (void)addAlertViewInView:(UIViewController *)VC title:(NSString *)title message:(NSString *)message count:(int)index doWhat:(void (^)(void))what
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *action = [[UIAlertAction alloc] init];
    
    UIAlertAction *action1 = [[UIAlertAction alloc] init];
    
    if(index == 0){
        
        action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (what)
            {
                what();
            }
            
        }];
        
        action1 = nil;
        
    }else{
        
        action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            what();
            
        }];
        
        action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        
    }
    
    
    if (action1) {
        
        [alert addAction:action1];
        
    }
    [alert addAction:action];
    [VC presentViewController:alert animated:YES completion:^{
        
    }];
    
}

+(void)addAlertViewInVC:(UIViewController *)VC btnText1:(NSString *)text1 btnText2:(NSString *)text2 title:(NSString *)title message:(NSString *)message doWhat:(void (^)(void))what
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:text1 style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:text2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (what) {
            what();
        }
        
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    
    [VC presentViewController:alert animated:YES completion:^{
        
    }];
    
    
}

/**
 *  添加MBProgress
 *
 *  @param view 添加到哪个视图上
 *  @param index MB展现的方式，0代表添加刷新视图，1代表不添加刷新只显示文字
 */
+(void)addMBProgressWithView:(UIView *)view style:(int)index
{
    _mbV = [[MBProgressHUD alloc] initWithView:view];
    
    if (index == 0) {
        
        _mbV.mode = MBProgressHUDModeIndeterminate;
        
    }else{
        
        _mbV.mode = MBProgressHUDModeCustomView;
        
    }
    /**
     *  自定义view
     */
//    _mbV.customView
    
    _mbV.color = [UIColor whiteColor];
    [view addSubview:_mbV];
    
    _mbV.activityIndicatorColor = [UIColor blackColor];
    
}

+(void)showMBWithTitle:(NSString *)title
{
    _mbV.labelText = title;
    _mbV.labelColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [_mbV show:YES];
}

+(void)hiddenMB
{
    [_mbV hide:YES afterDelay:0.5];
}

@end
