//
//  JDOrderListImageView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDOrderListImageView.h"

#import "HeadFile.pch"

#import "JDCallCarData.h"
#import "JDCallCarListViewModel.h"

#define TextFont [UIFont systemFontOfSize:15]
#define TextColor COLORWITHRGB(128, 128, 128, 1)

@interface JDOrderListImageView ()

@property (nonatomic, strong) UILabel *phoneNo;

@property (nonatomic, strong) UILabel *goTime;

@property (nonatomic, strong) UILabel *address;

@property (nonatomic, strong) UILabel *destination;

/*********************/

/**
 *  联系方式
 */
@property (nonatomic, strong) UILabel *phoneNoText;
/**
 *  出发时间
 */
@property (nonatomic, strong) UILabel *goTimeText;
/**
 *  上车地点
 */
@property (nonatomic, strong) UILabel *addressText;
/**
 *  目的地
 */
@property (nonatomic, strong) UILabel *destinationText;

@end

@implementation JDOrderListImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpAllChildViews];
        
    }
    return self;
}

-(void)setUpAllChildViews
{
    /**    前面的字   */
    // 联系方式
    _phoneNo = [[UILabel alloc] init];
    [self addSubview:_phoneNo];
    _phoneNo.font = TextFont;
    _phoneNo.textColor = TextColor;
    _phoneNo.text = @"联系方式：";
    
    // 出发时间
    _goTime = [[UILabel alloc] init];
    [self addSubview:_goTime];
    _goTime.font = TextFont;
    _goTime.textColor = TextColor;
    _goTime.text = @"出发时间：";
    
    // 上车地点
    _address = [[UILabel alloc] init];
    [self addSubview:_address];
    _address.font = TextFont;
    _address.textColor = TextColor;
    _address.text = @"上车地点：";
    
    // 目的地
    _destination = [[UILabel alloc] init];
    [self addSubview:_destination];
    _destination.font = TextFont;
    _destination.textColor = TextColor;
    _destination.text = @"目 的 地：";
    
    
    
    _phoneNoText = [[UILabel alloc] init];
    [self addSubview:_phoneNoText];
    _phoneNoText.font = TextFont;
    
    _goTimeText = [[UILabel alloc] init];
    [self addSubview:_goTimeText];
    _goTimeText.font = TextFont;
    
    _addressText = [[UILabel alloc] init];
    [self addSubview:_addressText];
    _addressText.font = TextFont;
    _addressText.numberOfLines = 0;
    
    _destinationText = [[UILabel alloc] init];
    [self addSubview:_destinationText];
    _destinationText.font = TextFont;
    _destinationText.numberOfLines = 0;
    
    
}

-(void)setListViewModel:(JDCallCarListViewModel *)listViewModel
{
    _listViewModel = listViewModel;
    
    // 设置数据
    JDCallCarData *data = listViewModel.callCarData;
    _phoneNoText.text = data.passengerPhoneNo;
    
    _goTimeText.text = data.time;
    
    _addressText.text = data.address;
    
    _destinationText.text = data.destination;
    
    // 设置frame
    _phoneNo.frame = listViewModel.phoneNoLabelFrame;
    _phoneNoText.frame = listViewModel.phoneNoFrame;
    
    _goTime.frame = listViewModel.goTimeLabelFrame;
    _goTimeText.frame = listViewModel.goTimeFrame;
    
    _address.frame = listViewModel.addressLabelFrame;
    _addressText.frame = listViewModel.addressFrame;
    
    _destination.frame = listViewModel.destinationLabelFrame;
    _destinationText.frame = listViewModel.destinationFrame;
    
}

@end
