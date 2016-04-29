//
//  JDVipAnimationView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/3/23.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDVipAnimationView.h"
#import <QuartzCore/QuartzCore.h>

#import "HeadFile.pch"

@interface JDVipAnimationView ()

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, assign) int index;

@end

@implementation JDVipAnimationView

static NSTimer *timer;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _index = 0;
        
    }
    return self;
}

-(void)createAnimation:(float)startAngle andEndAngle:(float)endAngle
{
    //创建运转动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO; //动画完成之后是否移除
    pathAnimation.duration = 1.0;
    pathAnimation.repeatDuration = 1; //动画执行的次数
    
    pathAnimation.delegate = self;
    
    //设置运转动画的路径
    CGFloat arcW = JDScreenSize.width/2+30;//圆的半径 //4 5
    CGFloat oX = JDScreenSize.width+26; //圆的圆点的 x
    CGFloat oY = 60+arcW; //圆的圆点的 y
    if (JDScreenSize.width==375) { //6
        arcW += 1;
        oY += 10;
//        oX += 3;
    }
    if (JDScreenSize.width==414) { //6p
        arcW += 2;
        oY += 20;
    }
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathAddArc(curvedPath, NULL, oX, oY, arcW, startAngle, endAngle, 0);
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //图片
    UIImage *image = [UIImage imageNamed:@"会员等级坐标点"];
    CGSize imageS = [image size];
    UIImageView *imageV = [[UIImageView alloc] init];
    _imageV = imageV;
    [self addSubview:imageV];
    imageV.frame = CGRectMake(1000, 1000, imageS.width, imageS.height);
    imageV.image = image;
    [imageV.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];


}

-(void)createTextAnimation:(float)startAngle andEndAngle:(float)endAngle
{
    //创建运转动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO; //动画完成之后是否移除
    pathAnimation.duration = 1.0;
    pathAnimation.repeatDuration = 1; //动画执行的次数
    
    pathAnimation.delegate = self;
    
    //设置运转动画的路径
    CGFloat arcW = JDScreenSize.width/2+30+60;//圆的半径 //4 5
    CGFloat oX = JDScreenSize.width+26; //圆的圆点的 x
    CGFloat oY = 60+arcW-20; //圆的圆点的 y
    if (JDScreenSize.width==375) { //6
        arcW += 1;
        oY += 10;
        //        oX += 3;
    }
    if (JDScreenSize.width==414) { //6p
        arcW += 2;
        oY += 20;
    }
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathAddArc(curvedPath, NULL, oX, oY, arcW, startAngle, endAngle, 0);
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(1000, 1000, 70, 15)];
    _commendText = label;
//    label.text = [NSString stringWithFormat:@"%d次推荐",_index];
    label.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    label.font = [UIFont systemFontOfSize:13];
    [self addSubview:label];
    [label.layer addAnimation:pathAnimation forKey:@"moveTheCircleTwo"];
    
}



@end
