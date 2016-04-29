//
//  PersonalVC.h
//  E+TAXI
//
//  Created by jeader on 15/12/29.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *personTableView;

//可以全局使用的退出到登陆界面的方法
- (void)removeFileAndInfo;
@end
