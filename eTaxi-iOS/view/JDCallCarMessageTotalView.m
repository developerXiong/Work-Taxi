//
//  JDCallCarMessageTotalView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDCallCarMessageTotalView.h"

#import "JDCallCarMessageViewFrame.h"
#import "JDCallCarData.h"

#define TextFont [UIFont systemFontOfSize:12]
#define TextColor [UIColor blackColor]

@interface JDCallCarMessageTotalView ()

@property (nonatomic, weak) UILabel *orderStatus;

@property (nonatomic, weak) UILabel *phoneNoLabel;

@property (nonatomic, weak) UILabel *phoneNo;

@property (nonatomic, weak) UILabel *goTimeLabel;

@property (nonatomic, weak) UILabel *goTime;

@property (nonatomic, weak) UILabel *addressLabel;

@property (nonatomic, weak) UILabel *address;

@property (nonatomic, weak) UILabel *destinationLabel;

@property (nonatomic, weak) UILabel *destination;

@property (nonatomic, weak) UILabel *line;

@end

@implementation JDCallCarMessageTotalView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpAllChildViews];
        self.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
        
    }
    return self;
}

-(void)setUpAllChildViews
{
    // 订单状态
    UILabel *orderStatus = [[UILabel alloc] init];
    _orderStatus = orderStatus;
    [self addSubview:orderStatus];
    orderStatus.font = [UIFont systemFontOfSize:15];
    orderStatus.textColor = TextColor;
    orderStatus.textAlignment = NSTextAlignmentCenter;
    
    // 联系方式-前
    UILabel *phoneNoLabel = [[UILabel alloc] init];
    _phoneNoLabel = phoneNoLabel;
    [self addSubview:phoneNoLabel];
    phoneNoLabel.font = TextFont;
    phoneNoLabel.textColor = TextColor;
    
    // 联系方式-后
    UILabel *phoneNo = [[UILabel alloc] init];
    _phoneNo = phoneNo;
    [self addSubview:phoneNo];
    phoneNo.font = TextFont;
    phoneNo.textColor = TextColor;
    
    // 出发时间-前
    UILabel *goTimeLabel = [[UILabel alloc] init];
    _goTimeLabel = goTimeLabel;
    [self addSubview:goTimeLabel];
    goTimeLabel.font = TextFont;
    goTimeLabel.textColor = TextColor;
    
    // 出发时间-后
    UILabel *goTime = [[UILabel alloc] init];
    _goTime = goTime;
    [self addSubview:goTime];
    goTime.font = TextFont;
    goTime.textColor = TextColor;
    
    // 上车地点-前
    UILabel *addressLabel = [[UILabel alloc] init];
    _addressLabel = addressLabel;
    [self addSubview:addressLabel];
    addressLabel.font = TextFont;
    addressLabel.textColor = TextColor;
    
    // 上车地点-后
    UILabel *address = [[UILabel alloc] init];
    _address = address;
    [self addSubview:address];
    address.font = TextFont;
    address.textColor = TextColor;
    address.numberOfLines = 0;
    
    // 目的地-前
    UILabel *destinationLabel = [[UILabel alloc] init];
    _destinationLabel = destinationLabel;
    [self addSubview:destinationLabel];
    destinationLabel.font = TextFont;
    destinationLabel.textColor = TextColor;
    
    // 目的地-后
    UILabel *destination = [[UILabel alloc] init];
    _destination = destination;
    [self addSubview:destination];
    destination.font = TextFont;
    destination.numberOfLines = 0;
    destination.textColor = TextColor;
    
    // 线
    UILabel *line = [[UILabel alloc] init];
    [self addSubview:line];
    _line = line;
    line.backgroundColor = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1];
    
    
}


-(void)setViewFrame:(JDCallCarMessageViewFrame *)ViewFrame
{
    _ViewFrame = ViewFrame;
    
    // 设置frame
    _orderStatus.frame = ViewFrame.orderStatuFrame;
    
    _line.frame = ViewFrame.lineFrame;
    
    _phoneNoLabel.frame = ViewFrame.phoneNoLabelFrame;
    
    _phoneNo.frame = ViewFrame.phoneNoFrame;
    
    _goTimeLabel.frame = ViewFrame.goTimeLabelFrame;
    
    _goTime.frame = ViewFrame.goTimeFrame;
    
    _addressLabel.frame = ViewFrame.addressLabelFrame;
    
    _address.frame = ViewFrame.addressFrame;
    
    _destinationLabel.frame = ViewFrame.destinationLabelFrame;
    
    _destination.frame = ViewFrame.destinationFrame;
    
    // 设置数据
    _phoneNo.text = ViewFrame.callCarData.passengerPhoneNo;
    _phoneNoLabel.text = @"联系方式：";
    
    _goTime.text = ViewFrame.callCarData.time;
    _goTimeLabel.text = @"出发时间：";
    
    _address.text = ViewFrame.callCarData.address;
    _addressLabel.text = @"上车地点：";
    
    _destination.text = ViewFrame.callCarData.destination;
    _destinationLabel.text = @"目 的 地：";
    
    if ([ViewFrame.callCarData.orderStatus intValue]==0) { // 已完成的订单
        
        _orderStatus.text = @"订单已完成！";
        
    }else{ // 订单已被取消
        _orderStatus.text = @"订单已被取消！";
    }
    
}

@end
