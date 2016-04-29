//
//  JDCallCarMessageViewFrame.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDCallCarMessageViewFrame.h"

#import "JDCallCarData.h"

#define TextFont [UIFont systemFontOfSize:12]

@implementation JDCallCarMessageViewFrame

-(void)setCallCarData:(JDCallCarData *)callCarData
{
    _callCarData = callCarData;
    
    NSString *phoneNoText = callCarData.passengerPhoneNo;
    NSString *goTimeText = callCarData.time;
    NSString *addressText = callCarData.address;
    NSString *destinationText = callCarData.destination;
    
    CGFloat totalW = [UIScreen mainScreen].bounds.size.width-40;
    
    // 订单状态
    _orderStatuFrame = CGRectMake(0, 0, totalW, 25);
    
    // 线
    _lineFrame = CGRectMake(0, CGRectGetMaxY(_orderStatuFrame), totalW, 1);
    
    // 联系方式
    CGFloat px = 10, py = CGRectGetMaxY(_lineFrame)+14, pw = 60, ph = 15;
    _phoneNoLabelFrame = CGRectMake(px, py, pw, ph);
    
    _phoneNoFrame = CGRectMake(CGRectGetMaxX(_phoneNoLabelFrame)+5, py, [self textWidthWithHeight:ph textFont:TextFont Sting:phoneNoText], ph);
    
    // 时间
    CGFloat tx = px, ty = CGRectGetMaxY(_phoneNoFrame)+10, tw = pw, th = ph;
    _goTimeLabelFrame = CGRectMake(tx, ty, tw, th);
    
    _goTimeFrame = CGRectMake(CGRectGetMaxX(_goTimeLabelFrame)+5, ty, [self textWidthWithHeight:th textFont:TextFont Sting:goTimeText], th);
    
    
    CGFloat ax = px, ay = CGRectGetMaxY(_goTimeFrame)+10, aw = pw, ah = ph;
    CGFloat adW = totalW-ax-aw-5-10;
    
    // 地点
    _addressLabelFrame = CGRectMake(ax, ay, aw, ah);
    
    _addressFrame = CGRectMake(CGRectGetMaxX(_addressLabelFrame)+5, ay, adW, [self textHeightWithWidth:adW textFont:TextFont Sting:addressText]);
    
    // 目的地
    CGFloat dx = px, dy = CGRectGetMaxY(_addressFrame)+10, dw = pw, dh = ph;
    _destinationLabelFrame = CGRectMake(dx, dy, dw, dh);
    
    _destinationFrame = CGRectMake(CGRectGetMaxX(_destinationLabelFrame)+5, dy, adW, [self textHeightWithWidth:adW textFont:TextFont Sting:destinationText]);
    
    // 整体视图
    _totalViewFrame = CGRectMake(20, 13, totalW, CGRectGetMaxY(_destinationFrame)+14);
    
    _cellHeight = CGRectGetMaxY(_destinationFrame) + 13 + 14;
    
}


-(CGFloat)textHeightWithWidth:(CGFloat)width textFont:(UIFont *)font Sting:(NSString *)str
{
    CGFloat height = 0;
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    height = rect.size.height;
    
    return height;
}

-(CGFloat)textWidthWithHeight:(CGFloat)height textFont:(UIFont *)font Sting:(NSString *)str
{
    CGFloat width = 0;
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    width = rect.size.width;
    
    return width;
}

@end
