//
//  UIImageView+JDImageMove.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "UIImageView+JDImageMove.h"

#import "HeadFile.pch"

#import "UIView+MJExtension.h"

#import "CYFloatingBallView.h"


@implementation UIImageView (JDImageMove)

-(void)moveFromView:(UIView *)view
{
    
    CALayer *viewLayer=[self layer];
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration=0.1;
    animation.repeatCount = 100000;
    animation.autoreverses=YES;
    animation.fromValue=[NSValue valueWithCATransform3D:CATransform3DRotate(viewLayer.transform, -0.03, 0.0, 0.0, 0.03)];
    animation.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate(viewLayer.transform, 0.03, 0.0, 0.0, 0.03)];
    [viewLayer addAnimation:animation forKey:@"wiggle"];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self startWobbleInView:view];

    });
    
}

-(void)startWobbleInView:(UIView *)view
{
    
    NSArray *windows = [[UIApplication sharedApplication] windows];
    
    UIWindow *keywindow = (UIWindow *)windows[0];
    
    JDLog(@"---->%@====%p",keywindow,keywindow);
    
    CGRect rect = [self convertRect:self.bounds toView:keywindow];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:rect];
    imageV.image = self.image;
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.windowLevel = 800;
    [view addSubview:window];
    [window makeKeyAndVisible];
    
    [self removeFromSuperview];
    [window addSubview:imageV];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        imageV.mj_w = 85;
        imageV.mj_h = 25;
        
        imageV.mj_x = (JDScreenSize.width-85)/2;
        imageV.mj_y = 120;
        
    } completion:^(BOOL finished) {
        
        window.hidden = YES;
        [window resignKeyWindow];
        [imageV removeFromSuperview];
        
    }];

    JDLog(@"%p---%p",window,imageV);
}

@end
