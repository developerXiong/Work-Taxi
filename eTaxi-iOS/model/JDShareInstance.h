//
//  JDShareInstance.h
//  eTaxi-iOS
//
//  Created by jeader on 16/6/7.
//  Copyright © 2016年 jeader. All rights reserved.
//  单例

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kIncomeIndexPath [NSIndexPath indexPathForRow:0 inSection:0] // 营收
#define kIncomeTimeIndexPath [NSIndexPath indexPathForRow:1 inSection:0] // 营收时间
#define kTrafficIndexPath [NSIndexPath indexPathForRow:0 inSection:1] // 违章
#define kCallcarIndexPath [NSIndexPath indexPathForRow:0 inSection:2] // 召车
#define kCallcarFloatIndexPath [NSIndexPath indexPathForRow:1 inSection:2] // 召车

/**
 *  判断程序是否为第一次加的key值（系统偏好设置）
 */
#define kIsFirstLaunchKey @"isFirstLaunch"
/**
 *  判断是否第一次进入设置界面的key值
 */
#define kFirstComeInSettingView @"comingInSettingKey"

typedef enum{
    
    kIncomeVideoSwitchKey,
    kIncomeTimeKey,
    kTrafficVideoSwitchKey,
    kCallcarVideoSwitchKey,
    kCallcarFloatingSwitchKey,
    
}JDKey;

@interface JDShareInstance : NSObject

@property (nonatomic, assign) JDKey settingKey;

+(instancetype)shareInstance;

/**
 *  获取哪个存偏好设置时的key值
 *
 *  @param settingKey 枚举
 *
 *  @return key值
 */
-(NSString *)settingKey:(JDKey)settingKey;
/**
 *  存放设置界面 里面的 每个单元格对应的 存入系统偏好设置时的key值
 *
 *  @return 存放key值的数组
 */
-(NSArray *)settingKeys;
/**
 *  设置所有的语音开关打开
 */
-(void)setUpAllSwitchOn;
/**
 *  设置所有的语音开关关闭
 */
-(void)setUpAllSwitchOff;

/**
 *  程序是否是第一次加载
 */
-(BOOL)isFirstLunch;

@end
