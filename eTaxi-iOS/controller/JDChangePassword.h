//
//  JDChangePassword.h
//  eTaxi-iOS
//
//  Created by jeader on 15/12/31.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDChangePassword : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNo;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *nPass;


@property (weak, nonatomic) IBOutlet UITableView *tableVi;
@property (weak, nonatomic) IBOutlet UIButton *commit;

@end
