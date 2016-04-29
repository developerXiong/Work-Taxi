//
//  JDNewAndFeatureImageView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDNewAndFeatureImageView : UIImageView

/**
 *  联系方式
 */
@property (nonatomic, strong) UILabel *phoneNo;
/**
 *  上车时间
 */
@property (nonatomic, strong) UILabel *time;
/**
 *  上车地点
 */
@property (nonatomic, strong) UILabel *address;
/**
 *  目的地
 */
@property (nonatomic, strong) UILabel *destination;

@end
