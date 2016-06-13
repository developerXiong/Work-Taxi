//
//  JDSettingCell.h
//  eTaxi-iOS
//
//  Created by jeader on 16/6/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDSettingSwitchCell : UITableViewCell

/**
 *  要存储到系统偏好设置中的键值
 */
@property (nonatomic, copy) NSString *forUserDefaultKey;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIView *detailView;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withKey:(NSString *)key;

@end
