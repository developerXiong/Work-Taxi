//
//  MyTool.h
//  eTaxi-iOS
//
//  Created by jeader on 15/12/31.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  @brief 判断登陆和合法性的工具类 
 */

@interface MyTool : NSObject
@property (nonatomic, strong) NSString * pecc_handle;
@property (nonatomic, strong) NSString * pecc_point;
@property (nonatomic, strong) NSString * pecc_officer;
@property (nonatomic, strong) NSString * pecc_money;
@property (nonatomic, strong) NSString * pecc_info;
@property (nonatomic, strong) NSString * pecc_date;
@property (nonatomic, strong) NSString * pecc_address;
@property (nonatomic, strong) NSString * pecc_cityName;
@property (nonatomic, strong) NSString * pecc_provinceName;
@property (nonatomic, strong) NSString * pecc_id;
@property (nonatomic, strong) NSString * pecc_result;


//判断是否登录过
+(BOOL)isLogin;

//判断手机号是否合法
+ (BOOL)validatePhone:(NSString *) textString;

//判断密码是否合法
+ (BOOL)validatePassword:(NSString *) textString;

//封装一个alertcontroller的类 
- (UIAlertController *)showAlertControllerWithTitle:(NSString *)title WithMessages:(NSString *)msg WithCancelTitle:(NSString *)cancelTitle;
//一个可以检测是否有网络链接的方法
+(void)checkNetWorkWithCompltion:(void(^)(NSInteger statusCode))block;
//解析违章信息
+ (NSMutableArray*)getAnalysisWithSmallArr:(NSMutableArray *)arr;
@end
