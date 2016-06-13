//
//  JDUserManualAlertView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/5/19.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JDUserManualViewModel;
@interface JDUserManualAlertView : UIWindow

@property (nonatomic, strong) JDUserManualViewModel *viewModel;


+(instancetype)userManualAlertView;

-(void)showWithBtn:(UIButton *)sender;
-(void)hidden;

@end
