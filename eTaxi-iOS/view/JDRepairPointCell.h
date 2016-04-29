//
//  JDRepairPointCell.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/28.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDRepairPointCell : UITableViewCell
/**
 *  维修点名称
 */
@property (weak, nonatomic) IBOutlet UILabel *repairName;
/**
 *  维修点图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *repairImage;
/**
 *  维修点地址
 */
@property (weak, nonatomic) IBOutlet UILabel *repairAddress;
/**
 *  维修点 营业时间
 */
@property (weak, nonatomic) IBOutlet UILabel *repairTime;
/**
 *  维修点电话
 */
@property (weak, nonatomic) IBOutlet UILabel *repairPhone;
/**
 *  维修点的确定按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *repairSureBtn;


@end
