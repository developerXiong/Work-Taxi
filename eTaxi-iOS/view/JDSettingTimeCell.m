//
//  JDSettingTimeCell.m
//  eTaxi-iOS
//
//  Created by jeader on 16/6/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDSettingTimeCell.h"

#import "JDShareInstance.h"

#import "JDSettingViewController.h"

@implementation JDSettingTimeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withKey:(NSString *)key
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier withKey:key]) {
        // 移除switch
        [[self.detailView.subviews lastObject] removeFromSuperview];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:self.detailView.bounds];
        NSString *time = [[NSUserDefaults standardUserDefaults] valueForKey:key];
        // 如果是第一次进入设置界面或者 存储的时间字符串为空,给time一个默认值
        if ([JDSettingViewController isFirstComingIn]||[time length]==0) {
            time = @"12:00"; // 默认值
            [[NSUserDefaults standardUserDefaults] setValue:time forKey:key];
        }
        self.timeLabel.text = time;
        self.timeLabel.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0  blue:107/255.0  alpha:1.0];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.font = [UIFont systemFontOfSize:15];
        [self.detailView addSubview:self.timeLabel];
        
    }
    return self;
}


@end
