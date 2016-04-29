//
//  PeccancyViewC.h
//  E+TAXI
//
//  Created by jeader on 15/12/29.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeccancyViewC : UIViewController


@property (strong, nonatomic) IBOutlet UITableView * _tableVi;

//接受数据的字典
@property (strong, nonatomic) NSMutableDictionary * getDic;
////接受数据的数组
//@property (strong, nonatomic) NSMutableArray * array;

@property (strong, nonatomic) IBOutlet UIButton * dealBtn;

@end
