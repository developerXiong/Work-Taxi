//
//  JDCallCarAlertViewFrame.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/23.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JDCallCarData;
@interface JDCallCarAlertViewFrame : NSObject

@property (nonatomic, strong) JDCallCarData *callCarData;

/**
 *  整体的view
 */
@property (nonatomic, assign) CGRect totalViewFrame;


/********  前面的字  *******/
/**
 *  联系方式Label
 */
@property (nonatomic, assign) CGRect phoneNoLabelFrame;
/**
 *  出发时间label
 */
@property (nonatomic, assign) CGRect goTimeLabelFrame;
/**
 *  上车地点label
 */
@property (nonatomic, assign) CGRect addressLabelFrame;
/**
 *  目的地label
 */
@property (nonatomic, assign) CGRect destinationLabelFrame;

/********  后面的字  *******/
/**
 *  联系方式
 */
@property (nonatomic, assign) CGRect phoneNoFrame;
/**
 *  出发时间
 */
@property (nonatomic, assign) CGRect goTimeFrame;
/**
 *  上车地点
 */
@property (nonatomic, assign) CGRect addressFrame;
/**
 *  目的地
 */
@property (nonatomic, assign) CGRect destinationFrame;

/**
 *  线1
 */
@property (nonatomic, assign) CGRect lineFrame1;

/**
 *  确认按钮
 */
@property (nonatomic, assign) CGRect sureFrame;

/**
 *  线2
 */
@property (nonatomic, assign) CGRect lineFrame2;

/**
 *  取消按钮
 */
@property (nonatomic, assign) CGRect cancelFrame;


@property (nonatomic, assign) CGRect bottomViewFrame;


@end
