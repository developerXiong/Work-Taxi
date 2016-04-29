//
//  MyCell.h
//  E+TAXI
//
//  Created by jeader on 15/12/29.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
//上边的cell1--个人信息头像的row
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

//下边的cell2 --个人信息其他信息的row
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

//cell3----上传个人信息各种图片的row
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;

//cell4-----抽屉头像row
@property (weak, nonatomic) IBOutlet UIImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *teleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

//cell5-----抽屉其他信息row
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel * vipLab;
@end
