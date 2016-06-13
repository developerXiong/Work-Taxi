//
//  JDSettingCell.m
//  eTaxi-iOS
//
//  Created by jeader on 16/6/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDSettingSwitchCell.h"

#import "JDShareInstance.h"

#import "JDSettingViewController.h"

#import "CYFloatingBallView.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

#define SELFHeight 44 // cell的高度

@implementation JDSettingSwitchCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withKey:(NSString *)key
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.forUserDefaultKey = key;
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 120, SELFHeight)];
        self.label.text = @"label";
        self.label.font = [UIFont systemFontOfSize:15];
        self.label.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];
        [self addSubview:self.label];
        
        self.detailView = [[UIView alloc] initWithFrame:CGRectMake(Width-60-15, 0, 60, SELFHeight)];
        [self addSubview:self.detailView];
        
            
        UISwitch *noticeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        noticeSwitch.center = CGPointMake(self.detailView.bounds.size.width/2, self.detailView.bounds.size.height/2);
        noticeSwitch.onTintColor = [UIColor colorWithRed:72/255.0 green:123/255.0  blue:184/255.0  alpha:1.0];
        BOOL switchKey = [[NSUserDefaults standardUserDefaults] boolForKey:key];
//        if ([JDSettingViewController isFirstComingIn]) { // 是第一次进界面
//            switchKey = YES;
//            [[NSUserDefaults standardUserDefaults] setBool:switchKey forKey:key];
//        }
        noticeSwitch.on = switchKey;
        [self.detailView addSubview:noticeSwitch];
        [noticeSwitch addTarget:self action:@selector(clickSwitch:) forControlEvents:UIControlEventValueChanged];
        
    }
    
    return self;
}

-(void)clickSwitch:(UISwitch *)swith
{
    
    [[NSUserDefaults standardUserDefaults] setBool:swith.on forKey:self.forUserDefaultKey];
    NSString *key = [[JDShareInstance shareInstance] settingKey:kCallcarFloatingSwitchKey];
    
    if ([self.forUserDefaultKey isEqualToString:key]) {
        
        if (swith.on) {
            [[CYFloatingBallView shareInstance] show];
        }else {
            [[CYFloatingBallView shareInstance] hidden];
        }
        
    }
    
}

@end
