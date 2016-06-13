//
//  JDThirdRoadCell.h
//  eTaxi-iOS
//
//  Created by jeader on 16/2/27.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDThirdLostCell : UITableViewCell

/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
/**
 *  物品类型
 */
@property (weak, nonatomic) IBOutlet UILabel *goodsType;
/**
 *  发布时间
 */
@property (weak, nonatomic) IBOutlet UILabel *relTime;
/**
 *  添加详情
 */
@property (weak, nonatomic) IBOutlet UIButton *addDetail;
/**
 *  补充详情的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *addImage;

@property (weak, nonatomic) IBOutlet UILabel *boLinebo;

/**
 *  物品详情
 */
@property (weak, nonatomic) IBOutlet UILabel *detailInfo;


@end
