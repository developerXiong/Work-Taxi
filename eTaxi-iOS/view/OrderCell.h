//
//  OrderCell.h
//  eTaxi-iOS
//
//  Created by jeader on 16/1/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell

//cell1
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *telLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *itemLab;
@property (weak, nonatomic) IBOutlet UIImageView *stateImage;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UIButton * cancelBtn;
@property (weak, nonatomic) IBOutlet UIImageView * deleteImg;
@property (weak, nonatomic) IBOutlet UIImageView *orderStatus;
@property (weak, nonatomic) IBOutlet UIImageView *repairImage;


//cell2
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UITextField *IDtf;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UILabel *lineLab;

//cell3
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
@property (weak, nonatomic) IBOutlet UIButton *marketBtn;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UIButton * earnScore;


//cell4
@property (weak, nonatomic) IBOutlet UILabel *spendDateLab;
@property (weak, nonatomic) IBOutlet UILabel *spendItemLab;
@property (weak, nonatomic) IBOutlet UILabel *spendPointLab;


@end
