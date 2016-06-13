//
//  JDCallCarViewController.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/21.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDCallCarViewController : UIViewController

/**
 *  是否在当前界面
 */
-(BOOL)isInCurrentViewController;
/**
 *  刷新界面
 */
-(void)refresh;

@end
