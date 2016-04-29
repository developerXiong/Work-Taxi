//
//  JDMaintenanceTimeView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/27.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Cancel)(); // 取消按钮的block
typedef void(^Sure)(NSString *timeStr); // 确定按钮的block

@interface JDMaintenanceTimeView : UIView

@property (nonatomic, strong) Cancel cancel;

@property (nonatomic, strong) Sure sure;

-(void)ClickCancel:(Cancel)cancel Sure:(Sure)sure;

-(void)show;

-(void)hidden;

@end
