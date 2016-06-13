//
//  UIViewController+CustomModelView.m
//  custom魔态势图TEST
//
//  Created by jeader on 16/2/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "UIViewController+CustomModelView.h"

#import "UIView+UIView_CYChangeFrame.h"
#import "HeadFile.pch"

#define JDScreenS [UIScreen mainScreen].bounds.size


static UIImageView *_imageV;
static UILabel *titleView;
static UIButton *_btn;

@implementation UIViewController (CustomModelView)

-(void)addNavigationBar:(NSString *)title
{

    [self addNavigationBar:COLORWITHRGB(0, 91, 201, 1) image:nil title:title];
    
}

-(void)addCleaerNavigationBar:(NSString *)title
{
    
    [self addNavigationBar:[UIColor clearColor] image:nil title:title];
}

-(void)addNavigationBar:(UIColor *)color image:(UIImage *)image title:(NSString *)title
{
    /**
     *  添加整体的navigationBar
     */
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, JDScreenS.width, 64)];
    _imageV = imageV;
    imageV.userInteractionEnabled = YES;
    if (color) {
        
        imageV.backgroundColor = color;
    }
    if (image) {
        
        imageV.image = image;
    }
    [self.view addSubview:imageV];
    
    CGSize imageS = [[UIImage imageNamed:@"返回"] size];
    /**
     *  添加坐边点击返回按钮
     */
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 20, imageS.width+30, 44)];
    _btn = btn;
    btn.tag = 502;
    [btn addTarget:self action:@selector(dismissViewC) forControlEvents:UIControlEventTouchUpInside];
    [imageV addSubview:btn];
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, (44-imageS.height)/2, imageS.width, imageS.height)];
    image1.image = [UIImage imageNamed:@"返回"];
    [btn addSubview:image1];
    
    /**
     *  添加控制器的主题
     */
    UILabel *titleV = [[UILabel alloc] initWithFrame:CGRectMake((JDScreenS.width-150)/2, 20, 150, 44)];
    titleView = titleV;
    titleV.text = title;
    titleV.font = [UIFont systemFontOfSize:18];
    titleV.textColor = [UIColor whiteColor];
    titleV.textAlignment = NSTextAlignmentCenter;
    [imageV addSubview:titleV];
}



-(void)addRightBtnWithImage:(NSString *)image action:(SEL)action
{
    CGSize rightS = [[UIImage imageNamed:image] size];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(JDScreenS.width-15-rightS.width, 20 + (44-rightS.height)/2, rightS.width, rightS.height)];
    imageV.image = [UIImage imageNamed:image];
    imageV.userInteractionEnabled = YES;
    [_imageV addSubview:imageV];
    
    /**
     *  添加右边带图片的按钮
     */
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(JDScreenS.width-rightS.width-50, 20, rightS.width+50, 44)];
    [_imageV addSubview:rightBtn];
    
    
    
    if (action==nil) {
        
    }else{
        
        [rightBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        
    }
}

-(void)addRightBtnWithTitle:(NSString *)title action:(SEL)action
{
    /**
     *  添加右边的按钮
     */
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn setFrame:CGRectMake(JDScreenS.width-120, 20, 120, 44)];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [_imageV addSubview:rightBtn];
    
    if (action==nil) {
        
    }else{
        
        [rightBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        
    }
}

-(void)presentViewC:(UIViewController *)VC animation:(BOOL)animation
{
    
    if (self.childViewControllers.count == 0) {
        [self addChildViewController:VC];
        
        VC.view.frame = CGRectMake(JDScreenS.width, 0, JDScreenS.width, JDScreenS.height);
        
        [self.view addSubview:VC.view];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            
            VC.view.transform = CGAffineTransformMakeTranslation(-JDScreenS.width, 0);
            
            
        }];

    }
    
    [self.view endEditing:YES];

}

// 点击返回按钮回到根界面
-(void)popToRootViewCntroller
{
    [_btn removeTarget:self action:@selector(dismissViewC) forControlEvents:UIControlEventTouchUpInside];
    [_btn addTarget:self action:@selector(dismissToMainVC) forControlEvents:UIControlEventTouchUpInside];
}

-(void)dismissViewC
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)dismissToMainVC
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
