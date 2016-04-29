//
//  SetView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/1/23.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetViewDelegate <NSObject>

- (void)cancelBtnClick;
- (void)containBtnClick;
- (void)datePickerValueChange:(NSString *)date;

@end

@interface SetView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, assign) id<SetViewDelegate>delegate;
@property (nonatomic, strong) UIPickerView * pickerVi;
@property (nonatomic, strong) NSMutableArray * myArr;
@property (nonatomic, strong) UILabel * labb;

@property (nonatomic, strong) NSString * str1;
@property (nonatomic, strong) NSString * str2;
@property (nonatomic, strong) NSString * str3;

@end
