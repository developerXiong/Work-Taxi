//
//  JDMainBar.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/20.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JDMainBarDelegate <NSObject>

@optional

-(void)clickPersonInfo;

@end

@interface JDMainBar : UIView

/**
 *  个人信息按钮
 */
@property (nonatomic, strong) UIButton *personInfoBtn;

@property (nonatomic, weak) id<JDMainBarDelegate>delegate;

@end
