//
//  JDCallCarAlertBottomView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/23.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JDCallCarAlertBottomViewDelaget <NSObject>

@optional
-(void)clickAlertViewSureBtn;

-(void)clickAlertViewCancelBtn;

@end

@class JDCallCarAlertViewFrame;
@interface JDCallCarAlertBottomView : UIView

@property (nonatomic, weak) id<JDCallCarAlertBottomViewDelaget>delegate;

@property (nonatomic, strong) JDCallCarAlertViewFrame *alertViewFrame;

@end
