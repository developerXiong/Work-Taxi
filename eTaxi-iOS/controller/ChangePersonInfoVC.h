//
//  ChangePersonInfoVC.h
//  eTaxi-iOS
//
//  Created by jeader on 16/1/6.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScrollView.h"

@interface ChangePersonInfoVC : UIViewController

//身份证 正面照片
@property (strong, nonatomic) UIImage * getImage1;
//身份证背面照片
@property (strong, nonatomic) UIImage * getImage2;
//驾驶证
@property (strong, nonatomic) UIImage * getImage3;
//运营证
@property (strong, nonatomic) UIImage * getImage4;
//表格
@property (weak, nonatomic) IBOutlet UITableView *editTable;
//记录按钮单机的tag值
@property (strong, nonatomic) NSString * tagStr;
@end
