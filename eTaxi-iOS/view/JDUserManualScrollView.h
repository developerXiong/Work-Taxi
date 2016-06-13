//
//  JDUserManualScrollView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/5/16.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

// 滚动结束调用的block
typedef void(^ScrollViewTo)(NSInteger scrollY);
// 滚动时调用的block
//typedef void(^ScrollViewDidScroll)(CGFloat scrollX);

@class JDUserManualViewModel;
@interface JDUserManualScrollView : UIView

@property (nonatomic, strong) JDUserManualViewModel *viewModel;

@property (nonatomic, strong) ScrollViewTo scroll;

//@property (nonatomic, strong) ScrollViewDidScroll didScroll;

-(void)scrollToIndex:(NSInteger)index;

// 滚动结束调用
-(void)selectIndexScroll:(ScrollViewTo)scroll;

// 滚动的时候调用
//-(void)selectIndexDidScroll:(ScrollViewDidScroll)didScroll;

@end
