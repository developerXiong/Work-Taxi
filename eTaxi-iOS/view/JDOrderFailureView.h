//
//  JDOrderFailureView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JDOrderFailureDelegate <NSObject>

@optional

-(void)clickLookOtherBtn;

@end

@interface JDOrderFailureView : UIView

@property (nonatomic, weak) id<JDOrderFailureDelegate>delegate;

//+(instancetype)shareView;

-(void)showInView:(UIView *)view;

-(void)hidden;

@end
