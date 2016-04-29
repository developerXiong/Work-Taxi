//
//  JDCallCarAlertView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/23.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JDCallCarAlertViewFrame;
@protocol JDCallCarAlertViewDelaget <NSObject>

@optional
-(void)clickAlertViewSureBtn:(JDCallCarAlertViewFrame *)callCarAlertFrame;

-(void)clickAlertViewCancelBtn;

@end


@interface JDCallCarAlertView : UIView

@property (nonatomic, strong) JDCallCarAlertViewFrame *alertViewFrame;

@property (nonatomic, weak) id<JDCallCarAlertViewDelaget>delegate;

-(void)showInView:(UIView *)view;

-(void)hiddenAnimation:(BOOL)animation;

@end
