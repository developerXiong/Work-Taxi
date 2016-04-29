//
//  MyScrollView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/1/8.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YangjxKeyboardScrollViewDelegate <NSObject>

- (void)keyboardWillHide;

@end

/**
 *  @brief 继承与UIScrollView,添加解决键盘自动隐藏的功能
 */

@interface MyScrollView : UIScrollView

// 键盘将要隐藏的代理
@property (weak, nonatomic) id<YangjxKeyboardScrollViewDelegate> keyboardHideDelegate;

@end
