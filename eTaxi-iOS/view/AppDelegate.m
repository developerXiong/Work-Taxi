//
//  AppDelegate.m
//  E+TAXI
//
//  Created by jeader on 15/12/21.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "PlayerView.h"
#import "HeadFile.pch"
#import <AudioToolbox/AudioToolbox.h>

#import "UMSocial.h"

#import "UMSocialWechatHandler.h"

#import "UMSocialQQHandler.h"

#import "UIImageView+WebCache.h"

#import "JDSoundPlayer.h"

#import "MyData.h"

#import "JDPushData.h"
#import "JDPushDataTool.h"

#import "JDShareInstance.h"
#import "JDCallCarViewController.h"


NSString *const NotificationCategoryIdent = @"ACTIONABLE";
NSString *const NotificationActionOneIdent = @"FIRST_ACTIOIN";
NSString *const NotificationActionTwoIdent = @"SECOND_ACTION";

@interface AppDelegate ()
{
    PlayerView * avView;
}


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /**
     *  友盟分享
     微信id：wxd930ea5d5a258f4f
     微信secret：db426a9829e4b49a0dcac7b4162da6b6
     qqid：1105140594
     */
    [UMSocialData setAppKey:@"56c040fee0f55accb90001ca"];
    
    [UMSocialWechatHandler setWXAppId:@"wx85efb0363ddc11a5" appSecret:@"fd924151af10b22d104c39023a3bdfa5" url:@"http://www.umeng.com/social"];
    
//    umsoc
    [UMSocialQQHandler setQQWithAppId:@"1105140594" appKey:@"7zVeTrcREoDAZbrI" url:@"http://www.umeng.com/social"];
//    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.baidu.com"];
    
    [UMSocialQQHandler setQQWithAppId:@"1105140594" appKey:@"7zVeTrcREoDAZbrI" url:@"http://www.baidu.com"];
    
    //启动SDK
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    // 注册APNS
    [self registerUserNotification];
    //处理远程通知启动APP
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UIViewController alloc]init];
    [self.window makeKeyAndVisible];
    
    JDLog(@"---->%@====%p",self.window,self.window);
    
    // 程序加载的时候开始请求个人信息，防止其他界面请求不到而影响程序运行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [MyData getPersonInfoWithCompletion:^(NSString *returnCode, NSString *msg, NSMutableDictionary *dic) {
            
        }];
    });
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    NSString * path =[[NSBundle mainBundle]pathForResource:@"kaiji4" ofType:@"mp4"];
    avView =[[PlayerView alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, JDScreenSize.height) url:path];
    [self.window addSubview:avView];
    [avView play];
    [self performSelector:@selector(delayChange) withObject:nil afterDelay:5];
    
    
    return YES;
}
- (void)delayChange
{
    ViewController * view =[[ViewController alloc]init];
    self.window.rootViewController = view;
}

- (void)registerUserNotification
{
    //如果是ios8.0 and later
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>= 8.0)
    {
        //IOS8 新的通知机制category注册
        //执行的动作一
        UIMutableUserNotificationAction *action1 ;
        action1 =[[UIMutableUserNotificationAction alloc] init];
        [action1 setActivationMode:UIUserNotificationActivationModeForeground];
        [action1 setIdentifier:NotificationActionOneIdent];
        [action1 setTitle:@"取消"];
        [action1 setDestructive:NO];
        [action1 setAuthenticationRequired:NO];
        //执行的动作二
        UIMutableUserNotificationAction * action2 ;
        action2 =[[UIMutableUserNotificationAction alloc] init];
        [action2 setActivationMode:UIUserNotificationActivationModeBackground];
        [action2 setIdentifier:NotificationActionTwoIdent];
        [action2 setTitle:@"接收"];
        [action2 setDestructive:NO];
        [action2 setAuthenticationRequired:NO];
        //设置categorys
        UIMutableUserNotificationCategory * actionCategorys =[[UIMutableUserNotificationCategory alloc] init];
        [actionCategorys setIdentifier:NotificationCategoryIdent];
        [actionCategorys setActions:@[action1,action2] forContext:UIUserNotificationActionContextDefault];
        //将类型 装在集合里面
        NSSet * categories =[NSSet setWithObject:actionCategorys];
        UIUserNotificationType types =(UIUserNotificationTypeAlert |
                                       UIUserNotificationTypeSound |
                                       UIUserNotificationTypeBadge);
        //设置 set属性
        UIUserNotificationSettings * settings =[UIUserNotificationSettings settingsForTypes:types categories:categories];
        [[UIApplication sharedApplication]registerForRemoteNotifications];
        [[UIApplication sharedApplication]registerUserNotificationSettings:settings];
    }
    else
    {
        UIRemoteNotificationType apn_type =(UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication]registerForRemoteNotificationTypes:apn_type];
    }
    
}

// 收到内存警告的时候调用 SDWebImage
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 取消所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    //清空缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
    
}

/** 自定义：APP被“推送”启动时处理推送消息处理（APP 未启动--》启动）*/
- (void)receiveNotificationByLaunchingOptions:(NSDictionary *)launchOptions
{
    if (!launchOptions)
    {
        return;
    }
    /*
     通过“远程推送”启动APP
     UIApplicationLaunchOptionsRemoteNotificationKey 远程推送Key
     */
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo)
    {
//        NSLog(@"\n>>>[Launching RemoteNotification]:%@", userInfo);
    }
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken
{
    NSString * myToken =[[deviceToken description]stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    myToken =[myToken stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"%@",myToken);
    [GeTuiSdk registerDeviceToken:myToken]; //向个推服务器注册deviceToken
}
/** APP已经接收到“远程”通知(推送) - (App运行在后台/App运行在前台) */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    JDLog(@"输出输出cccccc%@",userInfo);
//    NSString *record = [NSString stringWithFormat:@"字典模式ssssss[APN]%@, %@", [NSDate date], userInfo];
//    NSLog(@"字典模式模式模式%@",record);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
}
// 如果APNS 注册失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [GeTuiSdk registerDeviceToken:@""];
}
// 远程通知
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
//    NSLog(@"远程推送成功之后返回的结果有%@,,,,%@,,,,",identifier,userInfo);
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //background fetch 恢复SDK运行
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}
// 个推启动成功返回clientID
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId
{
    if (clientId.length>0)
    {
        NSUserDefaults * us =[NSUserDefaults standardUserDefaults];
        [us setValue:clientId forKey:@"clientID"];
        [us synchronize];
//        NSLog(@"ssssss%@",clientId);
    }
    else
    {
//        NSLog(@"没有获取到clientID");
    }
    
}
//个推遇到错误回调
- (void)GeTuiSdkDidOccurError:(NSError *)error
{
//    NSLog(@"个推遇到错误 :%@",[error localizedDescription]);
}

// 推送的内容
- (void)GeTuiSdkDidReceivePayload:(NSString *)payloadId andTaskId:(NSString *)taskId andMessageId:(NSString *)aMsgId andOffLine:(BOOL)offLine fromApplication:(NSString *)appId
{
    
    NSData * payload =[GeTuiSdk retrivePayloadById:payloadId];
    NSString * payloadMsg =nil;
    if (payload)
    {
        payloadMsg=[[NSString alloc]initWithBytes:payload.bytes length:payload.length encoding:NSUTF8StringEncoding];
        
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY/MM/dd HH:mm:ss";
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    
    //data类型转为JSON数据
    NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:payload options:0 error:nil];
    NSDictionary *dict = (NSDictionary *)json;
    JDLog(@"--->%@",dict);
    
    NSMutableDictionary *pushDict = [NSMutableDictionary dictionary];
    pushDict[@"title"] = dict[@"title"];
    pushDict[@"content"] = dict[@"content"];
    pushDict[@"currentTime"] = currentTime;
    pushDict[@"flag"] = @"0";
    pushDict[@"methodName"] = dict[@"methodName"];
    
    NSString *methodName = [NSString stringWithFormat:@"%@",dict[@"methodName"]];
    
    // 语音开关是否打开
    BOOL videoSwitch = [[NSUserDefaults standardUserDefaults] boolForKey:[[JDShareInstance shareInstance] settingKeys][kCallcarIndexPath.section][kCallcarIndexPath.row]];
    /**
     *  如果传过来的通知是有用的就显示到消息栏，如果没用，只做推送，不展示
     */
    if ([methodName isEqualToString:@"use"]) {
        
        JDPushDataTool *tool = [[JDPushDataTool alloc] init];
        [tool createTable];
        [tool insertValuesForKeysWithDictionary:pushDict];
        
    }else if([methodName isEqualToString:@"order"]){ // 接单通知（取消订单，完成订单）
        
            if (TARGET_IPHONE_SIMULATOR) { // 模拟器
            }else if(TARGET_OS_IPHONE){ // 真机
        
                if (videoSwitch) { // 召车语音开关打开
                    
                    JDSoundPlayer *player = [JDSoundPlayer soundPlayerInstance];
                    [player play:[NSString stringWithFormat:@"%@",dict[@"content"]]];
                }
                
            }
        
        JDLog(@"====>%@",dict);
       
    }else if([methodName isEqualToString:@"call"]){ // 有召车信息
        
        // 悬浮窗口的动画
        // 设置悬浮窗口上显示的数字
        //        [[CYFloatingBallView shareInstance] show];
        [[CYFloatingBallView shareInstance] startAnimation];
        [[CYFloatingBallView shareInstance] setUpNumber];
        
        // 在召车界面
        if ([[JDCallCarViewController alloc] isInCurrentViewController]) {
            // 自动刷新界
            // 发送一个通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"callCarReloadData" object:nil];
            
        }
        
        if (TARGET_IPHONE_SIMULATOR) { // 模拟器
        }else if(TARGET_OS_IPHONE){ // 真机
            
            if (videoSwitch) { // 召车语音开关打开
                JDSoundPlayer *player = [JDSoundPlayer soundPlayerInstance];
                [player play:[NSString stringWithFormat:@"%@",dict[@"content"]]];
                
                JDLog(@"---->%@",dict[@"currentTime"]);
            }
            
        }
        JDLog(@"有新的订单消息!");
    }
    
    
//    NSString * msg =[NSString stringWithFormat:@"payloadId=%@,taskId=%@,messageId:%@,payloadMsg:%@%@",payloadId,taskId,aMsgId,payloadMsg,offLine ? @"<离线消息>":@""];
    
//    NSLog(@"个推收到的payload是%@",msg);
    
}
/**
 *  SDK设置关闭推送模式回调
 *
 *  @param isModeOff 关闭模式，YES.服务器关闭推送功能 NO.服务器开启推送功能
 *  @param error     错误回调，返回设置时的错误信息
 */
//- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error
//{
//    NSArray *keys = [[JDShareInstance shareInstance] settingKeys];
//    
//    BOOL off = [[NSUserDefaults standardUserDefaults] boolForKey:keys[0][0]];
//    BOOL off1 = [[NSUserDefaults standardUserDefaults] boolForKey:keys[0][0]];
//    BOOL off2 = [[NSUserDefaults standardUserDefaults] boolForKey:keys[0][0]];
//    
//}

//让项目禁止横屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    JDLog(@"进入后台!");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    JDLog(@"进入qian台!");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // 设置一个值来判断程序是否为首次加载
    JDLog(@"程序终止!!!");
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsFirstLaunchKey];
}

@end
