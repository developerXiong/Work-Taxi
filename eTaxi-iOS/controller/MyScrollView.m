//
//  MyScrollView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/1/8.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "MyScrollView.h"

@interface MyScrollView  ()

/*!
 *  @brief 上一次的偏移量
 */

@property (assign, nonatomic) CGPoint previousOffset;

//添加,移除对键盘的监听通知
- (void)addKeyboardNotification;
- (void)removeKeyboardNotification;

//键盘出现,隐藏的通知回调
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

@end


@implementation MyScrollView

- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        [self addKeyboardNotification];
    }
    return self;
}

- (void)awakeFromNib
{
    [self addKeyboardNotification];
    CGFloat screenW =[UIScreen mainScreen].bounds.size.width;
//    CGFloat screenH =[UIScreen mainScreen].bounds.size.height;
    
    self.contentSize=CGSizeMake(screenW, 736);
    return;
}

- (void)addKeyboardNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    return;
}
- (void)removeKeyboardNotification
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

//点击滚动视图时隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
    if ([self.keyboardHideDelegate respondsToSelector:@selector(keyboardWillHide)])
    {
        [self.keyboardHideDelegate keyboardWillHide];
    }
    return;
}
//scroll contentOffset when keyboard will show
- (void)keyboardWillShow:(NSNotification *)notification
{
    self.previousOffset =self.contentOffset;
    NSDictionary * userInfo =[notification userInfo];
    
    //get keyboard rect in window coordinate
    CGRect keyboardRect =[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //convert keyboard rect from window coordinate to scroll view coordinate
    keyboardRect =[self convertRect:keyboardRect fromView:nil];
    //get keyboard animation duration
    NSTimeInterval animatioinDuration =[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //get first responder textfield

    UIView *  currentResponder =[self findFirstResponderBeneathView:self];
    if (currentResponder != nil)
    {
        //convert textfield left bottom point to scroll view coordinate
        CGPoint point =[currentResponder convertPoint:CGPointMake(0, currentResponder.frame.size.height) toView:self];
        // 计算textfield 左下角和键盘上面20 像素  之间是不是差值
        float scrollY =point.y-(keyboardRect.origin.y - 20);
        if (scrollY > 0 )
        {
            [UIView animateWithDuration:animatioinDuration animations:^{
                //移动textfield 到键盘上面20个像素
                self.contentOffset=CGPointMake(self.contentOffset.x, self.contentOffset.y + scrollY);
            }];
        }
    }
    self.scrollEnabled=YES;
    return;
    
}

// roll back content offset
- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary * userInfo =[notification userInfo];
    NSTimeInterval animationDuration =[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.contentOffset=self.previousOffset;
    }];
    self.scrollEnabled=YES;
    if ([self.keyboardHideDelegate respondsToSelector:@selector(keyboardWillHide)])
    {
        [self.keyboardHideDelegate keyboardWillHide];
    }
    return;
}
- (UIView *)findFirstResponderBeneathView:(UIView *)view
{
    //递归查找第一响应者
    for (UIView * childView in view.subviews)
    {
        if ([childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder])
        {
            return childView;
        }
        UIView * result =[self findFirstResponderBeneathView:childView];
        if (result)
        {
            return result;
        }
    }
    return nil;
}


@end
