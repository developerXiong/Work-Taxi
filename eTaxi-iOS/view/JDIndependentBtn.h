//
//  JDIndependentBtn.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/20.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadFile.pch"

@protocol JDIndependentBtnDelegate <NSObject>

@optional

/**
 *  动画完成之后调用
 */
-(void)clickBtnDidAnimation:(UIButton *)sender;
/**
 *  动画将要开始的时候调用
 */
-(void)clickBtnWillAnimation:(UIButton *)sender;

@end

@interface JDIndependentBtn : UIView

@property (nonatomic, weak) id<JDIndependentBtnDelegate>delegate;

/**
 *  点击事件的按钮
 */
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, assign) NSInteger tag_main;

@property (nonatomic, assign) BOOL enble_main;

/**
 *  正常的图片View
 */
@property (nonatomic, weak) UIImageView *normalImageView;
/**
 *  翻转的图片View
 */
@property (nonatomic, weak) UIImageView *zImageView;



/**
 *  正常的图片
 */
@property (nonatomic, strong) UIImage *normalImage;
/**
 *  翻转的图片
 */
@property (nonatomic, strong) UIImage *zImage;

@end
