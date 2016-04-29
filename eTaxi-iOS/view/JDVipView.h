//
//  JDVipView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/3/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDVipView : UIView

/**
 *  整体的视图
 */
@property (nonatomic, strong) UIImageView *mainView;

/**
 *  推荐乘客次数
 */
@property (nonatomic, strong) UILabel *commendCount;

/**
 *  信用积分数
 */
@property (nonatomic, strong) UILabel *creditCount;

/**
 *  姓名
 */
@property (nonatomic, strong) UILabel *nameLabel;

/**
 *  会员等级
 */
@property (nonatomic, strong) UILabel *memberLevel;


@end
