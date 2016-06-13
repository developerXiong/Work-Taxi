//
//  UIViewController+CustomModelView.h
//  custom魔态势图TEST
//
//  Created by jeader on 16/2/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CustomModelView)

/**
 *  添加导航栏
 *
 *  @param title     导航栏的名称
 *  @param imageName 右边点击按钮的图片名称
 *  @param action    按钮的点击事件
 */
-(void)addNavigationBar:(NSString *)title;

-(void)addCleaerNavigationBar:(NSString *)title;

-(void)presentViewC:(UIViewController *)VC animation:(BOOL)animation;

/**
 *  添加带图片的右侧的按钮
 */
-(void)addRightBtnWithImage:(NSString *)image action:(SEL)action;

/**
 *  添加带文字右侧的按钮
 */
-(void)addRightBtnWithTitle:(NSString *)title action:(SEL)action;

/**
 *  返回上一个界面
 */
-(void)dismissViewC;

-(void)dismissToMainVC;

/**
 *  点击返回按钮回到根界面
 */
-(void)popToRootViewCntroller;

@end
