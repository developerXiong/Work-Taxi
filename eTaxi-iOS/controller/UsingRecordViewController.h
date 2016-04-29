//
//  UsingRecordViewController.h
//  eTaxi-iOS
//
//  Created by jeader on 16/2/15.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsingRecordViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITableView * tableVi;
@property (weak, nonatomic) IBOutlet UIImageView * img;
@property (weak, nonatomic) IBOutlet UILabel * itemLab;

- (instancetype)initWithArray:(NSArray *)outArr;

@end
