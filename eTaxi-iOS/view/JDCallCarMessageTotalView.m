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

#define PhoneNoImage [UIImage imageNamed:@"dz_电话"]
#define GoTimeImage [UIImage imageNamed:@"dz_预约时间"]
#define GoAddressImage [UIImage imageNamed:@"dz_起点"]
#define DestinationImage [UIImage imageNamed:@"dz_终点"]

#define TextFont [UIFont systemFontOfSize:14]
#define TextGreenColor [UIColor colorWithRed:0/255.0 green:200/255.0 blue:136/255.0 alpha:1]; // 绿色字体 （订单完成）
#define TextBlueColor [UIColor colorWithRed:60/255.0 green:147/255.0 blue:254/255.0 alpha:1]; //蓝色字体（订单取消）
#define TextGrayColor [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1]; //灰色字体（订单信息）

@interface JDCallCarMessageTotalView ()

@property (nonatomic, weak) UILabel *orderStatus;

//@property (nonatomic, weak) UIButton *lookDetail;

@property (nonatomic, weak) UIImageView *phoneNoLabel;

@property (nonatomic, weak) UILabel *phoneNo;

@property (nonatomic, weak) UIImageView *goTimeLabel;

@property (nonatomic, weak) UILabel *goTime;

@property (nonatomic, weak) UIImageView *addressLabel;

@property (nonatomic, weak) UILabel *address;

@property (nonatomic, weak) UIImageView *destinationLabel;

@property (nonatomic, weak) UILabel *destination;

@property (nonatomic, weak) UILabel *line;

@end

@implementation JDCallCarMessageTotalView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpAllChildViews];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(void)setUpAllChildViews
{
    // 订单状态
    UILabel *orderStatus = [[UILabel alloc] init];
    _orderStatus = orderStatus;
    [self addSubview:orderStatus];
    orderStatus.font = [UIFont systemFontOfSize:14];
    orderStatus.textAlignment = NSTextAlignmentCenter;
    
    // 查看详情
//    UIButton *lookButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _lookDetail = lookButton;
//    [self addSubview:lookButton];
//    [lookButton setTitle:@"查看详情>" forState:UIControlStateNormal];
//    lookButton.titleLabel.font = [UIFont systemFontOfSize:9];
//    [lookButton setTitleColor:[UIColor colorWithRed:87/255.0 green:163/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
//    [lookButton addTarget:self action:@selector(clickLookDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    // 联系方式-icon
    UIImageView *phoneNoLabel = [[UIImageView alloc] init];
    _phoneNoLabel = phoneNoLabel;
    [self addSubview:phoneNoLabel];
    
    // 联系方式-后
    UILabel *phoneNo = [[UILabel alloc] init];
    _phoneNo = phoneNo;
    [self addSubview:phoneNo];
    phoneNo.font = TextFont;
    phoneNo.textColor = TextGrayColor;
    
    // 出发时间-icon
    UIImageView *goTimeLabel = [[UIImageView alloc] init];
    _goTimeLabel = goTimeLabel;
    [self addSubview:goTimeLabel];
    
    // 出发时间-后
    UILabel *goTime = [[UILabel alloc] init];
    _goTime = goTime;
    [self addSubview:goTime];
    goTime.font = TextFont;
    goTime.textColor = TextGrayColor;
    
    // 上车地点-icon
    UIImageView *addressLabel = [[UIImageView alloc] init];
    _addressLabel = addressLabel;
    [self addSubview:addressLabel];
    
    // 上车地点-后
    UILabel *address = [[UILabel alloc] init];
    _address = address;
    [self addSubview:address];
    address.font = TextFont;
    address.textColor = TextGrayColor;
    address.numberOfLines = 0;
    
    // 目的地-icon
    UIImageView *destinationLabel = [[UIImageView alloc] init];
    _destinationLabel = destinationLabel;
    [self addSubview:destinationLabel];
    
    // 目的地-后
    UILabel *destination = [[UILabel alloc] init];
    _destination = destination;
    [self addSubview:destination];
    destination.font = TextFont;
    destination.numberOfLines = 0;
    destination.textColor = TextGrayColor;
    
    // 线
    UILabel *line = [[UILabel alloc] init];
    [self addSubview:line];
    _line = line;
    line.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    
    
}


-(void)setViewFrame:(JDCallCarMessageViewFrame *)ViewFrame
{
    _ViewFrame = ViewFrame;
    
    // 设置frame
    _orderStatus.frame = ViewFrame.orderStatuFrame;
    
//    [_lookDetail setFrame:ViewFrame.lookDetailFrame];
    
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
    _phoneNoLabel.image = PhoneNoImage;
    
    _goTime.text = ViewFrame.callCarData.time;
    _goTimeLabel.image = GoTimeImage;
    
    _address.text = ViewFrame.callCarData.address;
    _addressLabel.image = GoAddressImage;
    
    _destination.text = ViewFrame.callCarData.destination;
    _destinationLabel.image = DestinationImage;
    
    if ([ViewFrame.callCarData.orderStatus intValue]==0) { // 已完成的订单
        
        _orderStatus.text = @"订单已完成";
        _orderStatus.textColor = TextGreenColor;
        
    }else{ // 订单已被取消
        _orderStatus.text = @"订单已取消";
        _orderStatus.textColor = TextBlueColor;
    }
    
}

-(void)setTag_mess:(NSInteger)tag_mess
{
    _tag_mess = tag_mess;
    
//    _lookDetail.tag = tag_mess;
}

#pragma  mark 按钮点击LOOKDETAIL
//-(void)clickLookDetail:(UIButton *)sender
//{
//    
//    if ([_delegate respondsToSelector:@selector(messageClickLookDetail:)]) {
//        [_delegate messageClickLookDetail:sender.tag];
//    }
//    
//}


@end
