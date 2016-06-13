//
//  JDUsingRecordMainView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/5/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDUsingRecordMainView.h"

#import "JDUsingRecordData.h"

#import "HeadFile.pch"

#import "JDUsingRecordViewModel.h"

#import "UIImageView+WebCache.h"

#define TextFont [UIFont systemFontOfSize:12]

@interface JDUsingRecordMainView ()

@property (nonatomic, weak) UIView *topView;

@property (nonatomic, weak) UIView *botView;


/**
 *  图片
 */
@property (nonatomic, weak) UIImageView *imageV;
/**
 *  名字
 */
@property (nonatomic, weak) UILabel *name;
/**
 *  兑换数量
 */
@property (nonatomic, weak) UILabel *costNumber;
/**
 *  单价
 */
@property (nonatomic, weak) UILabel *cost;
/**
 *  总价
 */
@property (nonatomic, weak) UILabel *costs;
/**
 *  兑换码label
 */
@property (nonatomic, weak) UILabel *costCodeLabel;
/**
 *  兑换码
 */
@property (nonatomic, weak) UILabel *costCode;

@property (nonatomic, weak) UIView *addView;
/**
 *  兑换地址
 */
@property (nonatomic, weak) UILabel *addressLabel;

@property (nonatomic, weak) UILabel *address;

@property (nonatomic, weak) UILabel *beUse;

@end

@implementation JDUsingRecordMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpChildViews];

        self.backgroundColor = ViewBackgroundColor;
    }
    return self;
}

-(void)setUpChildViews
{
    UIView *topView = [[UIView alloc] init];
    [self addSubview:topView];
    _topView = topView;
    topView.backgroundColor = [UIColor whiteColor];
    
    // 图片
    UIImageView *imageV = [[UIImageView alloc] init];
    [topView addSubview:imageV];
    _imageV = imageV;
    
    // 名字
    UILabel *name = [[UILabel alloc] init];
    [topView addSubview:name];
    name.numberOfLines = 0;
    _name = name;
    name.font = [UIFont systemFontOfSize:15];
    name.textColor = [UIColor blackColor];
    
    // 数量
    UILabel *costNumber = [[UILabel alloc] init];
    [topView addSubview:costNumber];
    _costNumber = costNumber;
    costNumber.font = TextFont;
    costNumber.textColor = BLACKCOLOR;
    
    // 单价
    UILabel *cost = [[UILabel alloc] init];
    [topView addSubview:cost];
    _cost = cost;
    cost.font = TextFont;
    cost.textColor = BLACKCOLOR;
    
    // 总价
    UILabel *costs = [[UILabel alloc] init];
    [topView addSubview:costs];
    _costs = costs;
    costs.font = TextFont;
    costs.textColor = BLACKCOLOR;
    
    UIView *botView = [[UIView alloc] init];
    [self addSubview:botView];
    _botView = botView;
    botView.backgroundColor = [UIColor whiteColor];
    
    // 兑换码label
    UILabel *costCodeLabel = [[UILabel alloc] init];
    [botView addSubview:costCodeLabel];
    _costCodeLabel = costCodeLabel;
    costCodeLabel.font = [UIFont systemFontOfSize:15];
    costCodeLabel.textAlignment = NSTextAlignmentCenter;
    
    // 兑换码number
    UILabel *costCode = [[UILabel alloc] init];
    [botView addSubview:costCode];
    _costCode = costCode;
    costCode.font = [UIFont systemFontOfSize:24];
    costCode.textColor = COLORWITHRGB(0, 91, 201, 1);
    costCode.textAlignment = NSTextAlignmentCenter;
    
    // 已使用
    UILabel *beUse = [[UILabel alloc] init];
    [botView addSubview:beUse];
    _beUse = beUse;
    beUse.numberOfLines = 0;
    beUse.textColor = COLORWITHRGB(128, 128, 128, 1);
    beUse.textAlignment = NSTextAlignmentCenter;
    beUse.font = [UIFont systemFontOfSize:12];
    
    // 兑换地址视图
    UIView *addView = [[UIView alloc] init];
    [botView addSubview:addView];
    _addView = addView;
    
    // 线
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, JDScreenSize.width-40, 1)];
    [addView addSubview:line];
    line.backgroundColor = ViewBackgroundColor;
    
    
    // 兑换地址
    UILabel *addressLabel = [[UILabel alloc] init];
    [addView addSubview:addressLabel];
    _addressLabel = addressLabel;
    addressLabel.font = [UIFont systemFontOfSize:15];
    addressLabel.textColor = BLACKCOLOR;
    
    // 兑换地址1111
    UILabel *address = [[UILabel alloc] init];
    [addView addSubview:address];
    _address = address;
    address.font = [UIFont systemFontOfSize:15];
    address.textColor = BLACKCOLOR;
    address.numberOfLines = 0;
}

-(void)setViewModel:(JDUsingRecordViewModel *)viewModel
{
    _viewModel = viewModel;
    
    JDUsingRecordData *data = viewModel.data;
    
    _topView.frame = viewModel.topViewFrame;
    _botView.frame = viewModel.botViewFrame;
    
    _imageV.frame = viewModel.imageVFrame;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:data.imageUrl]];
    
    _name.frame = viewModel.nameFrame;
    _name.text = data.costName;
    
    _costNumber.frame = viewModel.costNumberFrame;
    _costNumber.text = data.count;
    
    _cost.frame = viewModel.costFrame;
    _cost.text = data.price;
    
    _costs.frame = viewModel.costsFrame;
    _costs.text = data.total;
    
    _costCodeLabel.frame = viewModel.costCodeLabelFrame;
    _costCodeLabel.text = @"兑换码";
    
    _costCode.frame = viewModel.costCodeFrame;
    _costCode.text = data.orderNo;
    
    if ([data.useStatus intValue]==1) { //已被兑换
        
        _beUse.frame = viewModel.beUseFrame;
        _beUse.text = [NSString stringWithFormat:@"%@ 已使用",data.useDate];
        
        _costCodeLabel.textColor = [UIColor blackColor];
        _costCodeLabel.backgroundColor = COLORWITHRGB(205, 205, 205, 1);
    }else {
        _costCodeLabel.textColor = [UIColor whiteColor];
        _costCodeLabel.backgroundColor = COLORWITHRGB(82, 162, 255, 1);
    }
    
    _addView.frame = viewModel.addViewFramel;
    
    _addressLabel.frame = viewModel.addressLabelFrame;
    _addressLabel.text = @"兑换地址：";
    
    _address.frame = viewModel.addressFrame;
    _address.text = data.shopAddress;
    
    
}

@end
