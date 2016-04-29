//
//  UIView+UIView_CYChangeFrame.h
//  ChangeFrameTest
//
//  Created by jeader on 16/1/28.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIView_CYChangeFrame)

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

@end

@interface UIScrollView (CYChangeContentoffset)

@property (nonatomic, assign) CGFloat contentOffsetX;

@property (nonatomic, assign) CGFloat contentOffsetY;

@end