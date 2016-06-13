//
//  CYFloatingBallView.h
//  CYFloatingBall
//
//  Created by jeader on 16/6/3.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^floatingball)(UIButton *sender);

@interface CYFloatingBallView : UIWindow

/**
 *  召车信息的数量
 */
//@property (nonatomic, assign) int number;

@property (nonatomic, strong) floatingball floatBall;

@property (nonatomic, assign) BOOL enble;

+(instancetype)shareInstance;

/**
 *  开始动画(有通知消息的时候+1)
 */
-(void)startAnimation;

/**
 *  改变浮动窗口上面的数字
 */
-(void)setUpNumber;

-(void)show;
-(void)hidden;

@end
