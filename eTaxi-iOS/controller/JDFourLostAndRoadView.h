//
//  JDFourLostAndRoadCell.h
//  eTaxi-iOS
//
//  Created by jeader on 16/3/3.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JDFourLostViewDelegate <NSObject>

@optional

//-(void)clickBtn:(NSString *)str btnArr:(NSMutableArray *)btnArr;

/**
 *  动画完成之后调用
 */
-(void)clickBtnDidAnimation:(UIView *)sender btnName:(NSString *)str;
/**
 *  动画将要开始的时候调用
 */
-(void)clickBtnWillAnimation:(UIView *)sender btnName:(NSString *)str;

@end

@interface JDFourLostAndRoadView : UIView

/**
 *  选择类型的按钮array
 */
@property (nonatomic, strong) NSMutableArray *btnArr;

/**
 *  存放类型名称的数组
 */
@property (nonatomic, strong) NSArray *nameArr;

/**
 *  存放类型图片的数组
 */
@property (nonatomic, strong) NSArray *imageNameArr;

/**
 *  整个顶部的视图
 */
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, weak) id<JDFourLostViewDelegate>delegate;

@end
