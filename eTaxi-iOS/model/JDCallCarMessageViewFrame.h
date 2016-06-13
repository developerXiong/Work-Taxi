//
//  JDCallCarMessageViewFrame.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JDCallCarData;
@interface JDCallCarMessageViewFrame : NSObject

@property (nonatomic, strong) JDCallCarData *callCarData;

/**
 *  整体的view
 */
@property (nonatomic, assign) CGRect totalViewFrame;

/**
 *  订单状态
 */
@property (nonatomic, assign) CGRect orderStatuFrame;

/**
 *  查看详情
 */
@property (nonatomic, assign) CGRect lookDetailFrame;


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
 *  线
 */
@property (nonatomic, assign) CGRect lineFrame;

/**
 *  整体视图下的cellHeight
 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
