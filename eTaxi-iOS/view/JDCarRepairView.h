//
//  JDCarRepairView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/1/20.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDCarRepairView : UIScrollView

//维修时间的button
@property (nonatomic, strong) UIButton *timeBtn;

//维修点的button
@property (nonatomic, strong) UIButton *repairBtn;

//维修项目的button
@property (nonatomic, strong) UIButton *projectBtn;

//预约按钮
@property (nonatomic, strong) UIButton *maintenBtn;

//预约时间的选择框
@property (nonatomic, strong) UIView *timeView;

//维修项目的选择框
@property (nonatomic, strong) UIView *proView;

/**维修项目的按钮*/
@property (nonatomic, strong) UIButton *statusBtn;

/**预约按钮*/
@property (nonatomic, strong) UIButton *commitBtn;

/**上半部分按钮视图*/
@property (nonatomic, strong) UIView *mainView;

/**
 *  整体的底部的视图
 */
@property (nonatomic, strong) UIView *bottomV;

@end
