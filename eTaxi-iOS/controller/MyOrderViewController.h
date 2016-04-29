//
//  MyOrderViewController.h
//  eTaxi-iOS
//
//  Created by jeader on 16/1/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableVi;

@property (weak, nonatomic) IBOutlet UIImageView *imageG;
@property (weak, nonatomic) IBOutlet UILabel *tipsLab;

@property (weak, nonatomic) IBOutlet UIButton * btn1;
@property (weak, nonatomic) IBOutlet UIButton * btn2;
@property (weak, nonatomic) IBOutlet UIButton * btn3;

@property (weak, nonatomic) IBOutlet UIView * littleView;
@end
