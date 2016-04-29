//
//  JDMaintenanceButtonView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/27.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RepairProject)(UIButton *sender);

@interface JDMaintenanceButton : UIView

/**
 *  主题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  图片名称
 */
@property (nonatomic, copy) NSString *imageName;
/**
 *  选中状态的图片
 */
@property (nonatomic, copy) NSString *selectImageName;

@property (nonatomic, assign) NSInteger tag_btn;

@property (nonatomic, strong) RepairProject repair;

-(void)clickProject:(RepairProject)repair;

@end
