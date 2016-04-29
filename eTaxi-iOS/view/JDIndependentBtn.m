//
//  JDIndependentBtn.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/20.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDIndependentBtn.h"



@implementation JDIndependentBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpAllChildViews];
        
    }
    return self;
}

- (void)setUpAllChildViews
{
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_button setExclusiveTouch:YES];
    [self addSubview:_button];

    // 翻转的图片视图
    UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:self.bounds];
    _zImageView = imageV2;
    imageV2.tag = 100;
    [_button addSubview:imageV2];
    
    // 正常的图片视图
    UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:self.bounds];
    _normalImageView = imageV1;
    imageV1.tag = 101;
    [_button addSubview:imageV1];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_button setFrame:self.bounds];
    
    _normalImageView.frame = self.bounds;
    
    _zImageView.frame = self.bounds;
}

-(void)setNormalImage:(UIImage *)normalImage
{
    _normalImage = normalImage;
    
    _normalImageView.image = normalImage;
    
}

-(void)setZImage:(UIImage *)zImage
{
    _zImage = zImage;
    
    _zImageView.image = zImage;
    
}

-(void)setTag_main:(NSInteger)tag_main
{
    _tag_main = tag_main;
    
    _button.tag = tag_main;
}

-(void)setEnble_main:(BOOL)enble_main
{
    _enble_main = enble_main;
    
    _button.enabled = enble_main;
    
}

-(void)clickButton:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(clickBtnWillAnimation:)]) {
        [_delegate clickBtnWillAnimation:sender];
    }
    
    [self animationStart:sender durtion:0.6 type:0];
}

#pragma mark - 动画效果
-(void)animationStart:(UIButton *)sender durtion:(CGFloat)durtion type:(int)type
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:durtion];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:sender cache:YES];
    
    //当父视图里面只有两个视图的时候，可以直接使用下面这段.
    [sender exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    // type为0 的时候才会有结束动画
    if (type==0) {
        //动画结束的时候调用
        [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    }
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

// 动画结束后调用
-(void)endAnimation
{
    
    CGFloat durtion = 0.5; // 动画时间
    
    [UIView animateWithDuration:durtion animations:^{
        
        _zImageView.transform = CGAffineTransformMakeScale(2, 2);
        _zImageView.alpha --;
        
        _normalImageView.hidden = YES;
        
    } completion:^(BOOL finished) {
        
        if ([_delegate respondsToSelector:@selector(clickBtnDidAnimation:)]) {
            [_delegate clickBtnDidAnimation:_button];
        }
//        
//        NSLog(@"%ld",_button.tag);
        
        _zImageView.transform = CGAffineTransformIdentity;
        _zImageView.alpha = 1;
        _normalImageView.hidden = NO;
        [self animationStart:_button durtion:0 type:1];
    }];
}



@end
