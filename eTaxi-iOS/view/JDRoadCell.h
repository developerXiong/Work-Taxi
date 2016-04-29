//
//  JDRoadCell.h
//  eTaxi-iOS
//
//  Created by jeader on 16/3/1.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDRoadCell : UITableViewCell
/**
 *  路况申报-路况类型
 */
@property (weak, nonatomic) IBOutlet UILabel *roadType;
/**
 *  路况申报-申报时间
 */
@property (weak, nonatomic) IBOutlet UILabel *roadTime;
/**
 *  路况申报-申报地址
 */
@property (weak, nonatomic) IBOutlet UILabel *roadAdd;
/**
 *  路况申报-图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *roadImageV;

@end
