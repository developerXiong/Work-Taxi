//
//  JDAuditStatusView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/8.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JDAuditStatusViewDelegate <NSObject>

@optional

-(void)auditStatusBtnClick:(NSInteger)index;

@end

@interface JDAuditStatusView : UIView

/**
 *  传入按钮的名称数组
 */
@property (nonatomic, strong) NSArray *statusBtnArr;

/**
 *  当前选中第几个
 */
@property (nonatomic, assign) NSInteger currentIndex;


@property (nonatomic, weak) id<JDAuditStatusViewDelegate>delegate;


//+(void)changeBtnStatus:(NSInteger)tag;

@end
