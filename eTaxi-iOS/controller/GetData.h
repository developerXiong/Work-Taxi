//
//  GetData.h
//  eTaxi-iOS
//
//  Created by jeader on 15/12/31.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GetData : NSObject

/**
 *  请求数据
 *
 *  @param url     <#url description#>
 *  @param params  <#params description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)getDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  请求数据
 *
 *  @param url        url
 *  @param params     params
 *  @param Vc         做系统提示所在的控制器
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+(void)getDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params ViewController:(UIViewController *)Vc success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

//上传图片到服务器
+(void)postDataWithUrl:(NSString *)url params:(NSMutableDictionary *)params imageDatas:(NSArray *)images success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/**
 *  快速创建alertView
 *
 *  @param VC      要显示在哪个控制器上面
 *  @param title   显示内容的主题
 *  @param message 显示的内容
 *  @param index   下面有几个按钮 （只有确定和取消按钮 0代表一个，其他数字代表有两个）
 *  @param what    点击确定按钮之后做得事情0
 */
+ (void)addAlertViewInView:(UIViewController *)VC title:(NSString *)title message:(NSString *)message count:(int)index doWhat:(void (^)(void))what;

+ (void)addAlertViewInVC:(UIViewController *)VC btnText1:(NSString *)text1 btnText2:(NSString *)text2 title:(NSString *)title message:(NSString *)message doWhat:(void (^)(void))what;

/**
 *  添加MBProgress
 *
 *  @param view 添加到哪个视图上
 */
+ (void)addMBProgressWithView:(UIView *)view style:(int)index;
+ (void)showMBWithTitle:(NSString *)title;
+ (void)hiddenMB;

@end
