//
//  JDVipAnimationView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/3/23.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDVipAnimationView : UIView

@property (nonatomic, strong) UILabel *commendText;

-(void)createAnimation:(float)startAngle andEndAngle:(float)endAngle;

-(void)createTextAnimation:(float)startAngle andEndAngle:(float)endAngle;

@end
