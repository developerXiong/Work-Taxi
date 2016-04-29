//
//  UIView+UIView_CYChangeFrame.m
//  ChangeFrameTest
//
//  Created by jeader on 16/1/28.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "UIView+UIView_CYChangeFrame.h"

@implementation UIView (UIView_CYChangeFrame)

-(CGFloat)width
{
    CGFloat width = self.frame.size.width;
    
    return width;
}
-(void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

-(CGFloat)height
{
    CGFloat height = self.frame.size.height;
    return height;
}

-(void)setHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

-(CGFloat)x
{
    CGFloat x = self.frame.origin.x;
    return x;
}
-(void)setX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(CGFloat)y
{
    CGFloat y = self.frame.origin.y;
    return y;
}
-(void)setY:(CGFloat)y
{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

@end
