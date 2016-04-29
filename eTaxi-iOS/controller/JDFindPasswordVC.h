//
//  JDFindPasswordVC.h
//  eTaxi-iOS
//
//  Created by jeader on 15/12/31.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKCountDownButton.h"

@interface JDFindPasswordVC : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNo;
@property (weak, nonatomic) IBOutlet UITextField *confirm;
@property (weak, nonatomic) IBOutlet UITextField *nPassword;
@property (weak, nonatomic) IBOutlet UILabel *nLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property BOOL isFindPasword;
@property (nonatomic, strong) IBOutlet UITableView * tableView;
@property (nonatomic, strong) IBOutlet UIButton * containBtn;
@property (weak, nonatomic) IBOutlet UIButton *commit;
@property (weak, nonatomic) IBOutlet JKCountDownButton *countDownXib;
- (IBAction)countDownXibTouched:(JKCountDownButton*)sender;

@end
