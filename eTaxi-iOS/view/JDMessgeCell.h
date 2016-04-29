//
//  JDMessgeCell.h
//  eTaxi-iOS
//
//  Created by jeader on 16/3/10.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDMessgeCell : UITableViewCell
/**
 *  消息标题
 */
@property (weak, nonatomic) IBOutlet UILabel *title;

/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *time;

/**
 *  消息内容
 */
@property (weak, nonatomic) IBOutlet UILabel *describe;

/**
 *  提醒小点
 */
@property (weak, nonatomic) IBOutlet UIImageView *messPoint;

@end
