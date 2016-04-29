//
//  JDCallCarAlertViewFrame.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/23.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDCallCarAlertViewFrame.h"

#import "JDCallCarData.h"
#import "HeadFile.pch"

#define TextFont [UIFont systemFontOfSize:15]

@implementation JDCallCarAlertViewFrame

-(void)setCallCarData:(JDCallCarData *)callCarData
{
    _callCarData = callCarData;
    
    NSString *phoneNoText = callCarData.passengerPhoneNo;
    NSString *goTimeText = callCarData.time;
    NSString *addressText = callCarData.address;
    NSString *destinationText = callCarData.destination;
    
    CGFloat tw = 230, th = 0, tx = (JDScreenSize.width-tw)/2, ty = 40;
    
    
    // 联系方式
    CGFloat px = 10, py = 15, pw = 75, ph = 18;
    _phoneNoLabelFrame = CGRectMake(px, py, pw, ph);
    
    _phoneNoFrame = CGRectMake(CGRectGetMaxX(_phoneNoLabelFrame)+5, py, [self textWidthWithHeight:ph textFont:TextFont Sting:phoneNoText], ph);
    
    // 出发时间
    CGFloat gx = px, gy = CGRectGetMaxY(_phoneNoLabelFrame)+15, gw = pw, gh = ph;
    _goTimeLabelFrame = CGRectMake(gx, gy, gw, gh);
    
    _goTimeFrame = CGRectMake(CGRectGetMaxX(_goTimeLabelFrame)+5, gy, [self textWidthWithHeight:gh textFont:TextFont Sting:goTimeText], ph);
    
    CGFloat hWidth = tw-pw-px*3;
    
    // 上车地点
    CGFloat ax = px, ay = CGRectGetMaxY(_goTimeLabelFrame)+15, aw = pw, ah = ph;
    _addressLabelFrame = CGRectMake(ax, ay, aw, ah);
    
    _addressFrame = CGRectMake(CGRectGetMaxX(_addressLabelFrame)+5, ay, hWidth, [self textHeightWithWidth:hWidth textFont:TextFont Sting:addressText]);
    
    // 目的地
    CGFloat dx = px, dy = CGRectGetMaxY(_addressFrame)+15, dw = pw, dh = ph;
    _destinationLabelFrame = CGRectMake(dx, dy, dw, dh);
    
    _destinationFrame = CGRectMake(CGRectGetMaxX(_destinationLabelFrame)+5, dy, hWidth, [self textHeightWithWidth:hWidth textFont:TextFont Sting:destinationText]);
    
    
    // 线1
    _lineFrame1 = CGRectMake(0, CGRectGetMaxY(_destinationFrame)+15, tw, 1);
    
    // 确认按钮
    _sureFrame = CGRectMake(0, CGRectGetMaxY(_lineFrame1), tw, 40);
    
    // 线2
    _lineFrame2 = CGRectMake(0, CGRectGetMaxY(_sureFrame), tw, 1);
    
    // 取消按钮
    _cancelFrame = CGRectMake(0, CGRectGetMaxY(_lineFrame2), tw, 40);
    
    
    // bottomView
    _bottomViewFrame = CGRectMake(0, 45, tw, CGRectGetMaxY(_cancelFrame));
    
    // 整体的view
    th = CGRectGetMaxY(_bottomViewFrame);
    _totalViewFrame = CGRectMake(tx, ty, tw, th);
    
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
