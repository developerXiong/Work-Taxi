//
//  VipCell.h
//  eTaxi-iOS
//
//  Created by jeader on 16/3/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VipCell : UITableViewCell

/**
 *  cell1
 */
@property (nonatomic ,weak) IBOutlet UILabel * titleLab;
@property (nonatomic ,weak) IBOutlet UILabel * contentLab;
@property (nonatomic, weak) IBOutlet UIView * defineVi;

/**
 *  cell2
 */
@property (nonatomic, weak) IBOutlet UIView * blueView;
@property (nonatomic, weak) IBOutlet UIView * whiteView;
@property (nonatomic, weak) IBOutlet UIView * littleVi1;
@property (nonatomic, weak) IBOutlet UIView * littleVi2;
@property (nonatomic, weak) IBOutlet UILabel * itemLab;
@property (nonatomic, weak) IBOutlet UILabel * rulesLab;

/**
 *  cell3
 */
@property (nonatomic, weak) IBOutlet UIView * whiteVi;

/**
 *  cell4
 */
@property (nonatomic ,weak) IBOutlet UILabel * titleLab1;
@property (nonatomic ,weak) IBOutlet UILabel * contentLab1;
@property (nonatomic, weak) IBOutlet UILabel * smallLab;

@end
