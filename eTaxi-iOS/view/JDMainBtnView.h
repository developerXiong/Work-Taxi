//
//  JDMainBtnView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/20.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadFile.pch"

@class JDMainButton;
@interface JDMainBtnView : UIScrollView

/**
 *  所有的按钮视图
 */
@property (nonatomic, strong) JDMainButton *mainButton;

@end
