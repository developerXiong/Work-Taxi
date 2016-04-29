//
//  JDMainView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/19.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JDMainBtnView;
@class JDMainBar;
@interface JDMainView : UIView

/**
 *  主页整体视图
 */
@property (nonatomic, strong) JDMainBtnView *mainBtn;
/**
 *  导航栏
 */
@property (nonatomic, strong) JDMainBar *mainBar;

@property (nonatomic, assign) CGFloat contentH;

@end
