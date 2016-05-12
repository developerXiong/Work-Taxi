//
//  JDMaintenanceView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/26.
//  Copyright © 2016年 jeader. All rights reserved.
//  整体的预约维修视图（未完成...）

#import <UIKit/UIKit.h>

@protocol JDMaintenanceViewDelegate <NSObject>

@optional
/**
 *  点击预约时间按钮
 */
-(void)maintenanceClickRepairTime;
/**
 *  点击维修点按钮
 */
-(void)maintenanceClickRepairPoint;
/**
 *  点击立刻上传按钮按钮
 */
-(void)maintenanceClickRepairCommit;
///**
// *  点击时间框上的确定按钮
// */
//-(void)maintenanceClickTimeViewSure:(NSString *)timeStr;
///**
// *  点击时间框上的取消按钮
// */
//-(void)maintenanceClickTimeViewCancel;

-(void)maintenanceClickRepairPro:(UIButton *)sender;

@end

@interface JDMaintenanceView : UIScrollView

/**
 *  维修点按钮
 */
@property (nonatomic, weak) UIButton *repairPoint;

@property (nonatomic, weak) id<JDMaintenanceViewDelegate>delegate_main;

/**
 *  获取当前时间的字符串
 *
 *  @return <#return value description#>
 */
-(NSString *)currentTimeStr;

/**
 *  隐藏时间框和蒙层
 */
-(void)hiddenTimeAndMengc;
/**
 *  添加时间选择框
 *
 *  @param sure   点击确定按钮的回调
 *  @param cancel 点击取消按钮的回调
 */
-(void)showChooseTimeViewInView:(UIView *)view ClickSure:(void(^)(NSString *timeStr))sure cancel:(void(^)())cancel;

@end
