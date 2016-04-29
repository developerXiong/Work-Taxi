//
//  JDMaintenanceBtnView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/26.
//  Copyright © 2016年 jeader. All rights reserved.
//  维修预约的按钮视图（未完成...）

#import <UIKit/UIKit.h>

typedef void(^RepairProject)(UIButton *sender);

@interface JDMaintenanceBtnView : UIView

@property (nonatomic, strong) NSMutableArray *btnArr;

@property (nonatomic, strong) RepairProject repair;

-(void)clickRepairPro:(RepairProject)repair;

@end
