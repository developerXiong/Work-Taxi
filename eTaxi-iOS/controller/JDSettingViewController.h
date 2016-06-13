//
//  JDSettingViewController.h
//  eTaxi-iOS
//
//  Created by jeader on 16/6/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDSettingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 *  是否是第一次进入界面
 */
+(BOOL)isFirstComingIn;

@end
