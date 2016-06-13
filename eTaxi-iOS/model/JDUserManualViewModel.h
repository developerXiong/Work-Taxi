//
//  JDUserManualViewModel.h
//  eTaxi-iOS
//
//  Created by jeader on 16/5/16.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface JDUserManualViewModel : NSObject

/**
    使用说明的图片排布viewModel
 */
@property (nonatomic, strong) NSArray *imageArr;

@property (nonatomic, assign) CGRect firstFrame;

@property (nonatomic, assign) CGRect secondFrame;

@property (nonatomic, assign) CGRect thirdFrame;

@property (nonatomic, assign) CGRect fourthFrame;

@property (nonatomic, assign) CGRect fiveFrame;

@property (nonatomic, assign) CGRect tipFrame;

@property (nonatomic, assign) CGFloat scrollViewH;

@property (nonatomic, assign) CGFloat scrollViewW;

/**
 *  使用说明的特别提醒图片排布viewModel
 */
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, assign) CGRect imageVFrame;

@property (nonatomic, assign) CGRect btnFrame;

@property (nonatomic, assign) CGRect lineFrame;

@property (nonatomic, assign) CGRect mainFrame;

@end
