//
//  JDUserManualViewModel.m
//  eTaxi-iOS
//
//  Created by jeader on 16/5/16.
//  Copyright © 2016年 jeader. All rights reserved.
//  使用说明的视图模型

#import "JDUserManualViewModel.h"

#import "HeadFile.pch"

@implementation JDUserManualViewModel

-(void)setImageArr:(NSArray *)imageArr
{
    _imageArr = imageArr;
    
    UIImage *firstImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[0]]];
    UIImage *secondImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[1]]];
    UIImage *thirdImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[2]]];
    UIImage *fouthImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[3]]];
    UIImage *fiveImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[4]]];
    
    CGSize firstS = [firstImage size], secondS = [secondImage size], thirdS = [thirdImage size], fouthS = [fouthImage size], fiveS = [fiveImage size];
    
    // 1
    CGFloat width = JDScreenSize.width, fh = [self heightWithSize:firstS], x = 0, fy = 0;
    _firstFrame = CGRectMake(x, fy, width, fh);
    
    // 2
    CGFloat sh = [self heightWithSize:secondS];
    _secondFrame = CGRectMake(JDScreenSize.width, fy, width, sh);
    
    // 3
    CGFloat th = [self heightWithSize:thirdS];
    _thirdFrame = CGRectMake(JDScreenSize.width*2, fy, width, th);
    
    // 4
    CGFloat foh = [self heightWithSize:fouthS];
    _fourthFrame = CGRectMake(JDScreenSize.width*3, fy, width, foh);
    
    // 5
    CGFloat fih = [self heightWithSize:fiveS];
    _fiveFrame = CGRectMake(JDScreenSize.width*4, fy, width, fih);
    
    _scrollViewH = [self heightWithSize:firstS];
    _scrollViewW = imageArr.count*JDScreenSize.width;
    
    _tipFrame = CGRectMake((JDScreenSize.width-130)/2, _scrollViewH-110, 130, 50);
    
}

-(CGFloat)heightWithSize:(CGSize)size
{
    CGFloat width = JDScreenSize.width;
    
    return width*(size.height/size.width);
}

// // // // // //// ///////////

-(void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    CGSize imageS = [image size];
    
    CGFloat w = imageS.width, h = imageS.height, x = (JDScreenSize.width-w)/2, y = (JDScreenSize.height-64-h)/2-20;
    // 图片
    _imageVFrame = CGRectMake(0, 0, w, h);
    
    // 按钮
    _btnFrame = CGRectMake(0, CGRectGetMaxY(_imageVFrame), w, 40);
    
    // 线
    _lineFrame = CGRectMake(0, 0, w, 1);
    
    // 整体视图
    _mainFrame = CGRectMake(x, y, w, CGRectGetMaxY(_btnFrame));
    
}

@end
