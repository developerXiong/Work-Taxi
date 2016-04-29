//
//  ScoreCell.h
//  E+TAXI
//
//  Created by jeader on 15/12/29.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKCountDownButton.h"

@interface ScoreCell : UITableViewCell
//cell1
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *reasonLab;
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
//cell2
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UIImageView *image_;
//cell3
@property (weak, nonatomic) IBOutlet UILabel * headLab;
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet JKCountDownButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UILabel *lineLab;
@property (weak, nonatomic) IBOutlet UIButton * delete1;
//cell4
@property (weak, nonatomic) IBOutlet UILabel *titleLab1;
@property (weak, nonatomic) IBOutlet UITextField *inputTF1;
@property (weak, nonatomic) IBOutlet UILabel *lineLab1;
@property (weak, nonatomic) IBOutlet UIButton * delete2;

@end
