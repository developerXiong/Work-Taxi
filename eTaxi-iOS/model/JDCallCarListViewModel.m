//
//  JDCallCarListViewModel.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/23.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDCallCarListViewModel.h"

#import "JDCallCarData.h"
#import "HeadFile.pch"

#define TextFont [UIFont systemFontOfSize:15]

@implementation JDCallCarListViewModel

-(void)setCallCarData:(JDCallCarData *)callCarData
{
    _callCarData = callCarData;
    
    NSString *phoneNoText = callCarData.passengerPhoneNo;
    NSString *goTimeText = callCarData.time;
    NSString *addressText = callCarData.address;
    NSString *destinationText = callCarData.destination;
    
    // 联系方式
    CGFloat px = 10, py = 45, pw = 75, ph = 18;
    _phoneNoLabelFrame = CGRectMake(px, py, pw, ph);
    
    _phoneNoFrame = CGRectMake(CGRectGetMaxX(_phoneNoLabelFrame)+10, py, [self textWidthWithHeight:ph textFont:TextFont Sting:phoneNoText], ph);
    
    // 出发时间
    CGFloat gx = px, gy = CGRectGetMaxY(_phoneNoLabelFrame)+10, gw = pw, gh = ph;
    _goTimeLabelFrame = CGRectMake(gx, gy, gw, gh);
    
    _goTimeFrame = CGRectMake(CGRectGetMaxX(_goTimeLabelFrame)+10, gy, [self textWidthWithHeight:gh textFont:TextFont Sting:goTimeText], ph);
    
    // 上车地点
    CGFloat ax = px, ay = CGRectGetMaxY(_goTimeLabelFrame)+10, aw = pw, ah = ph;
    _addressLabelFrame = CGRectMake(ax, ay, aw, ah);
    
    _addressFrame = CGRectMake(CGRectGetMaxX(_addressLabelFrame)+10, ay, 200, [self textHeightWithWidth:200 textFont:TextFont Sting:addressText]);
    
    // 目的地
    CGFloat dx = px, dy = CGRectGetMaxY(_addressFrame)+10, dw = pw, dh = ph;
    _destinationLabelFrame = CGRectMake(dx, dy, dw, dh);
    
    _destinationFrame = CGRectMake(CGRectGetMaxX(_destinationLabelFrame)+10, dy, 200, [self textHeightWithWidth:200 textFont:TextFont Sting:destinationText]);
    
    _cellHeight = CGRectGetMaxY(_destinationFrame)+20;
    
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
