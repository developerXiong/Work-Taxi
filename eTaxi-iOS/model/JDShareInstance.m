//
//  JDShareInstance.m
//  eTaxi-iOS
//
//  Created by jeader on 16/6/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDShareInstance.h"

#import "HeadFile.pch"

@implementation JDShareInstance

+(instancetype)shareInstance
{
    static id shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareInstance = [[self alloc] init];

    });
    
    return shareInstance;
}

-(NSString *)settingKey:(JDKey)settingKey
{
    NSString *key = @"";
    
    NSArray *keys = [self settingKeys];
    
    switch (settingKey) {
        case 0:
        {
            key = [keys[kIncomeIndexPath.section][kIncomeIndexPath.row] description];
        }
            break;
        case 1:
        {
            key = [keys[kIncomeTimeIndexPath.section][kIncomeTimeIndexPath.row] description];
        }
            break;
        case 2:
        {
            key = [keys[kTrafficIndexPath.section][kTrafficIndexPath.row] description];
        }
            break;
        case 3:
        {
            key = [keys[kCallcarIndexPath.section][kCallcarIndexPath.row] description];
        }
            break;
        case 4:
        {
            key = [keys[kCallcarFloatIndexPath.section][kCallcarFloatIndexPath.row] description];
        }
            break;
            
        default:
            break;
    }
    
    return key;
}

-(NSArray *)settingKeys
{
    NSArray *keys = @[@[@"incomeNotice",@"incomeTime"],@[@"trafficNotice"],@[@"callcarNotice",@"callcarFloating"]];
    
    return keys;
}

-(void)setUpAllSwitchOn
{
    NSArray *arr = [self settingKeys];
    
    for (NSArray *keys in arr) {
        
        for (int i = 0; i < keys.count; i++) {
            NSString *key = [NSString stringWithFormat:@"%@",keys[i]];
            
            JDLog(@"keys--->%@",key);
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
        }
        
    }
    
    // 单独设置营收时间 11
    [[NSUserDefaults standardUserDefaults] setValue:@"12:00" forKey:[self settingKey:kIncomeTimeKey]];
    
}
-(void)setUpAllSwitchOff
{
    NSArray *keys = [self settingKeys];
    for (int i = 0; i < keys.count; i++) {
        NSString *key = [NSString stringWithFormat:@"%@",keys[i]];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:key];
    }
}

/**
 *  程序是否是第一次加载
 */
-(BOOL)isFirstLunch
{
    BOOL foo = [[NSUserDefaults standardUserDefaults] boolForKey:kIsFirstLaunchKey];
    
    return !foo;
}

@end
