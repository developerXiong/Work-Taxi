//
//  JDLoginVC.h
//  eTaxi-iOS
//
//  Created by jeader on 15/12/31.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface JDLoginVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNo;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (strong, nonatomic) MBProgressHUD * hud;
@property (strong, nonatomic) IBOutlet UIButton * deleteBtn1;
@property (strong, nonatomic) IBOutlet UIButton * deleteBtn2;


@end
