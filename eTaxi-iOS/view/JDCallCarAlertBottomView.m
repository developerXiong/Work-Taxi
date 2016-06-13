//
//  JDCallCarAlertBottomView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/23.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDCallCarAlertBottomView.h"

#import "JDCallCarAlertViewFrame.h"
#import "JDCallCarData.h"

#import "HeadFile.pch"

#define TextFont [UIFont systemFontOfSize:15]

@interface JDCallCarAlertBottomView ()

/*******前面的字*******/
/**
 *  联系方式
 */
@property (nonatomic, weak) UILabel *phoneNoLabel;
/**
 *  出发时间
 */
@property (nonatomic, weak) UILabel *goTimeLabel;
/**
 *  上车地点
 */
@property (nonatomic, weak) UILabel *addressLabel;
/**
 *  目的地
 */
@property (nonatomic, weak) UILabel *destinationLabel;


/*******后面的字*******/
/**
 *  联系方式
 */
@property (nonatomic, weak) UILabel *phoneNo;
/**
 *  出发时间
 */
@property (nonatomic, weak) UILabel *goTime;
/**
 *  上车地点
 */
@property (nonatomic, weak) UILabel *address;
/**
 *  目的地
 */
@property (nonatomic, weak) UILabel *destination;

@property (nonatomic, weak) UILabel *line1;

@property (nonatomic, weak) UILabel *line2;

@property (nonatomic, weak) UIButton *sure;

@property (nonatomic, weak) UIButton *cancel;


@end

@implementation JDCallCarAlertBottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        [self setUpChildViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setUpChildViews
{
    
    // 联系方式
    UILabel *phoneNoLabel = [[UILabel alloc] init];
    [self addSubview:phoneNoLabel];
    _phoneNoLabel = phoneNoLabel;
    phoneNoLabel.font = TextFont;
    phoneNoLabel.text = @"联系方式：";
    
    // 出发时间
    UILabel *goTimeLabel = [[UILabel alloc] init];
    [self addSubview:goTimeLabel];
    _goTimeLabel = goTimeLabel;
    goTimeLabel.font = TextFont;
    goTimeLabel.text = @"出发时间：";
    
    // 上车地点
    UILabel *addressLabel = [[UILabel alloc] init];
    [self addSubview:addressLabel];
    _addressLabel = addressLabel;
    addressLabel.font = TextFont;
    addressLabel.text = @"上车地点：";
    
    // 目的地
    UILabel *destinationLabel = [[UILabel alloc] init];
    [self addSubview:destinationLabel];
    _destinationLabel = destinationLabel;
    destinationLabel.font = TextFont;
    destinationLabel.text = @"目  的 地：";
    
    // 联系方式
    UILabel *phoneNo = [[UILabel alloc] init];
    [self addSubview:phoneNo];
    _phoneNo = phoneNo;
    phoneNo.font = TextFont;
    
    // 出发时间
    UILabel *goTime = [[UILabel alloc] init];
    [self addSubview:goTime];
    _goTime = goTime;
    goTime.font = TextFont;
    
    // 上车地点
    UILabel *address = [[UILabel alloc] init];
    [self addSubview:address];
    _address = address;
    address.font = TextFont;
    address.numberOfLines = 0;
    
    // 目的地
    UILabel *destination = [[UILabel alloc] init];
    [self addSubview:destination];
    _destination = destination;
    destination.font = TextFont;
    destination.numberOfLines = 0;

    // 线1
    UILabel *line1 = [[UILabel alloc] init];
    [self addSubview:line1];
    _line1 = line1;
    line1.backgroundColor = COLORWITHRGB(206, 206, 206, 1);
    
    // 线2
    UILabel *line2 = [[UILabel alloc] init];
    [self addSubview:line2];
    _line2 = line2;
    line2.backgroundColor = COLORWITHRGB(206, 206, 206, 1);
    
    // 确定按钮
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:sure];
    _sure = sure;
    [sure setTitle:@"确定接单" forState:UIControlStateNormal];
    [sure setTitleColor:COLORWITHRGB(56, 146, 255, 1) forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(clickSure) forControlEvents:UIControlEventTouchUpInside];
    
    // 取消按钮
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:cancel];
    _cancel = cancel;
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:COLORWITHRGB(255, 69, 69, 1) forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    
}
// 点击确定按钮
-(void)clickSure
{
    if ([_delegate respondsToSelector:@selector(clickAlertViewSureBtn)]) {
        [_delegate clickAlertViewSureBtn];
    }
    
}

// 点击取消按钮
-(void)clickCancel
{
    if ([_delegate respondsToSelector:@selector(clickAlertViewCancelBtn)]) {
        [_delegate clickAlertViewCancelBtn];
    }
}


-(void)setAlertViewFrame:(JDCallCarAlertViewFrame *)alertViewFrame
{
    _alertViewFrame = alertViewFrame;
    
    JDCallCarData *data = alertViewFrame.callCarData;

    // 设置数据
    _phoneNo.text = data.passengerPhoneNo;
    
    _goTime.text = data.time;
    
    _address.text = data.address;
    
    _destination.text = data.destination;
    
    // 设置frame
    _phoneNoLabel.frame = alertViewFrame.phoneNoLabelFrame;
    _phoneNo.frame = alertViewFrame.phoneNoFrame;
    
    _goTimeLabel.frame = alertViewFrame.goTimeLabelFrame;
    _goTime.frame = alertViewFrame.goTimeFrame;
    
    _addressLabel.frame = alertViewFrame.addressLabelFrame;
    _address.frame = alertViewFrame.addressFrame;
    
    _destinationLabel.frame = alertViewFrame.destinationLabelFrame;
    _destination.frame = alertViewFrame.destinationFrame;
    
    _line1.frame = alertViewFrame.lineFrame1;
    
    _line2.frame = alertViewFrame.lineFrame2;
    
    _sure.frame = alertViewFrame.sureFrame;
    
    _cancel.frame = alertViewFrame.cancelFrame;
    
}

@end
