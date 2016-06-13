//
//  JDUsingRecordViewModel.h
//  eTaxi-iOS
//
//  Created by jeader on 16/5/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


@class JDUsingRecordData;
@interface JDUsingRecordViewModel : NSObject

@property (nonatomic, strong) JDUsingRecordData *data;

@property (nonatomic, assign) CGRect topViewFrame;

@property (nonatomic, assign) CGRect botViewFrame;

@property (nonatomic, assign) CGRect imageVFrame;

@property (nonatomic, assign) CGRect nameFrame;

@property (nonatomic, assign) CGRect costNumberFrame;

@property (nonatomic, assign) CGRect costFrame;

@property (nonatomic, assign) CGRect costsFrame;

@property (nonatomic, assign) CGRect costCodeLabelFrame;

@property (nonatomic, assign) CGRect costCodeFrame;

@property (nonatomic, assign) CGRect beUseFrame;

@property (nonatomic, assign) CGRect addViewFramel;

@property (nonatomic, assign) CGRect addressLabelFrame;

@property (nonatomic, assign) CGRect addressFrame;

@property (nonatomic, assign) CGFloat mainViewH;

@end
