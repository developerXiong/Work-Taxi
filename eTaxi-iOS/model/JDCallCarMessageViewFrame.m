//
//  JDCallCarMessageViewFrame.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDCallCarMessageViewFrame.h"

#import "JDCallCarData.h"


#define PhoneNoImage [UIImage imageNamed:@"dz_电话"]
#define GoTimeImage [UIImage imageNamed:@"dz_预约时间"]
#define GoAddressImage [UIImage imageNamed:@"dz_起点"]
#define DestinationImage [UIImage imageNamed:@"dz_终点"]

#define TextFont [UIFont systemFontOfSize:14] // 灰体字大小
#define StatusTextFont [UIFont systemFontOfSize:14] // 订单状态字体大小
#define TimeTextFont [UIFont systemFontOfSize:12] // 上面的时间的字体大小

#define GrayTextHeight 17

@implementation JDCallCarMessageViewFrame

-(void)setCallCarData:(JDCallCarData *)callCarData
{
    _callCarData = callCarData;
    
    NSString *phoneNoText = callCarData.passengerPhoneNo;
    NSString *goTimeText = callCarData.time;
    NSString *addressText = callCarData.address;
    NSString *destinationText = callCarData.destination;
    NSString *orderStatusText = @"";
    if ([callCarData.orderStatus integerValue]==0) { // 订单已完成
        orderStatusText = @"订单已完成";
    }else {
        orderStatusText = @"订单已取消";
    }
    
    CGSize phoneSize = [PhoneNoImage size], goTimeSize = [GoTimeImage size], goaddSize = [GoAddressImage size], desSize = [DestinationImage size];
    
    CGFloat totalW = [UIScreen mainScreen].bounds.size.width-40,margin = 10,juli = 3;
    
    // 订单状态
    _orderStatuFrame = CGRectMake(margin, 0, [self textWidthWithHeight:17 textFont:StatusTextFont Sting:orderStatusText], 30);
    
    // 查看详情
    CGFloat lw = 50, lh = 30, lx = totalW-12-lw, ly = 0;
    _lookDetailFrame = CGRectMake(lx, ly, lw, lh);
    
    // 线
    _lineFrame = CGRectMake(margin, CGRectGetMaxY(_orderStatuFrame), totalW-2*margin, 1);
    
    // 联系方式
    CGFloat px = margin, py = CGRectGetMaxY(_lineFrame)+8, pw = phoneSize.width, ph = phoneSize.height;
    _phoneNoLabelFrame = CGRectMake(px, py, pw, ph);
    
    _phoneNoFrame = CGRectMake(CGRectGetMaxX(_phoneNoLabelFrame)+5, py-juli, [self textWidthWithHeight:GrayTextHeight textFont:TextFont Sting:phoneNoText], GrayTextHeight);
    
    // 时间
    CGFloat tx = px-2, ty = CGRectGetMaxY(_phoneNoFrame)+10, tw = goTimeSize.width, th = goTimeSize.height;
    _goTimeLabelFrame = CGRectMake(tx, ty, tw, th);
    
    _goTimeFrame = CGRectMake(CGRectGetMaxX(_goTimeLabelFrame)+3, ty-juli, [self textWidthWithHeight:GrayTextHeight textFont:TextFont Sting:goTimeText], GrayTextHeight);
    
    
    CGFloat ax = px, ay = CGRectGetMaxY(_goTimeFrame)+10, aw = goaddSize.width, ah = goaddSize.height;
    CGFloat adW = totalW-ax-aw-5-10;
    
    // 地点
    _addressLabelFrame = CGRectMake(ax, ay, aw, ah);
    
    _addressFrame = CGRectMake(CGRectGetMaxX(_addressLabelFrame)+5, ay-juli, adW, [self textHeightWithWidth:adW textFont:TextFont Sting:addressText]);
    
    // 目的地
    CGFloat dx = px, dy = CGRectGetMaxY(_addressFrame)+10, dw = desSize.width, dh = desSize.height;
    _destinationLabelFrame = CGRectMake(dx, dy, dw, dh);
    
    _destinationFrame = CGRectMake(CGRectGetMaxX(_destinationLabelFrame)+5, dy-juli, adW, [self textHeightWithWidth:adW textFont:TextFont Sting:destinationText]);
    
    // 整体视图
    _totalViewFrame = CGRectMake(20, 13, totalW, CGRectGetMaxY(_destinationFrame)+14);
    
    _cellHeight = CGRectGetMaxY(_totalViewFrame);
    
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
