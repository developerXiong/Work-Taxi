//
//  JDLostButton.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/8.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JDLostButtonDelegate <NSObject>

@optional

//-(void)clickStatusBtn:(NSString *)str;

/**
 *  动画完成之后调用
 */
-(void)clickBtnDidAnimation:(UIView *)sender btnName:(NSString *)str;
/**
 *  动画将要开始的时候调用
 */
-(void)clickBtnWillAnimation:(UIView *)sender btnName:(NSString *)str;

@end

@interface JDLostButton : UIView

// 背景图片
@property (nonatomic, copy) NSString *btnAndImageName;

// 按钮的名称
@property (nonatomic, copy) NSString *btnName;
/**
 *  高亮图片
 */
@property (nonatomic, copy) NSString *highlightImage;

@property (nonatomic, weak) id<JDLostButtonDelegate>delegate;

@property (nonatomic, assign) BOOL enble;

@property (nonatomic, weak) UIButton *btn;

@property (nonatomic, weak) UIImageView *imageV;

@end
