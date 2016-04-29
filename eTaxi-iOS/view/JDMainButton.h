//
//  JDMainButton.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/20.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JDMainButtonDelegate <NSObject>

@optional

-(void)mainButtonDidAnimation:(UIButton *)sender;

-(void)mainButtonWillAnimation:(UIButton *)sender;

@end

@interface JDMainButton : UIView

/**
 *  点击预约维修block
 */
@property (nonatomic, weak) id<JDMainButtonDelegate>delegate;

@end
