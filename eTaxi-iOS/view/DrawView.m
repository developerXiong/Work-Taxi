//
//  DrawView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/3/10.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "DrawView.h"
#import <QuartzCore/QuartzCore.h>

@implementation DrawView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 200/255.0, 200/255.0, 200/255.0, 1);
    CGContextSetLineWidth(context, 1.0);
    CGPoint sPoints[3];
    sPoints[0] =CGPointMake(5, 50);
    sPoints[1] =CGPointMake(250, 50);
    sPoints[2] =CGPointMake(250, 20);
    [[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1.0]setFill];
    CGContextAddLines(context, sPoints, 3);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextRef context2 =UIGraphicsGetCurrentContext();
    
//    CGContextSetRGBStrokeColor(context2, 200/255.0, 200/255.0, 200/255.0, 1.0);
    CGPoint mPoints[3];
    mPoints[0] =CGPointMake(5, 50);
    mPoints[1] =CGPointMake(100, 50);
    mPoints[2] =CGPointMake(100, 40);
    [[UIColor colorWithRed:30/255.0 green:103/255.0 blue:203/255.0 alpha:1.0]setFill];
    CGContextAddLines(context2, mPoints, 3);
    CGContextClosePath(context2);
    CGContextDrawPath(context2, kCGPathFillStroke);
    
}
- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self.backgroundColor=[UIColor whiteColor];
        
    }
    return self;
}
- (void)drawNow
{
    [self setNeedsDisplay];
}

@end
