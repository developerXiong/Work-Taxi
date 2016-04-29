//
//  AppDelegate.h
//  E+TAXI
//
//  Created by jeader on 15/12/21.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "GeTuiSdk.h"

//个推开发者网站中申请的App 时注册的Appid AppKey AppSecret
#define kGtAppId           @"3UOqzkCqpk888wmJHSWdg4"
#define kGtAppKey          @"EdV7WJdaSj6hnBX5BYBa76"
#define kGtAppSecret       @"KmFLCMwWst7QCKvmlznpr4"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,GeTuiSdkDelegate>

@property (strong, nonatomic) UIWindow *window;

@end