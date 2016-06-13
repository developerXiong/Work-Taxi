//
//  JDUserManualButton.h
//  eTaxi-iOS
//
//  Created by jeader on 16/5/16.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JDUserManualButtonDelegate <NSObject>

@optional
-(void)userManualButtonClickIndex:(NSInteger)index;

@end

@interface JDUserManualButton : UIView

@property (nonatomic, weak) id<JDUserManualButtonDelegate>delegate;
/**
 *  图片名称
 */
@property (nonatomic, copy) NSString *imageName;
/**
 *  按钮的tag值
 */
@property (nonatomic, assign) NSInteger btn_tag;

@end
