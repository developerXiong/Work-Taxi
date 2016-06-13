//
//  JDUserManualBtnView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/5/16.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UserManualButtonClick)(NSInteger index);

@interface JDUserManualBtnView : UIView

/**
 *  五个按钮的图片名字
 */
@property (nonatomic, strong) NSMutableArray *btnArr;
/**
 *  高亮状态按钮
 */
@property (nonatomic, strong) NSMutableArray *highlightBtnArr;
/**
 *  当前选中的按钮
 */
@property (nonatomic, assign) NSInteger currentIndex;
/**
 *  按钮上的实线
 */
@property (nonatomic, weak) UILabel *line;

@property (nonatomic, strong) UserManualButtonClick userManualClick;

-(void)userManualClickBtn:(UserManualButtonClick)userManualClick;

-(void)selectBtnIndex:(NSInteger)index;

@end
