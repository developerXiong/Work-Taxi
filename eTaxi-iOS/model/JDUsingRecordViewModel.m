//
//  JDUsingRecordViewModel.m
//  eTaxi-iOS
//
//  Created by jeader on 16/5/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDUsingRecordViewModel.h"

#import "JDUsingRecordData.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

#define TextFont 12

@implementation JDUsingRecordViewModel

-(void)setData:(JDUsingRecordData *)data
{
    _data = data;
    
    CGFloat ix = 10, iy = 10, iw = 170/2, ih = 0; // 图片
    
    // 名字
    CGFloat nx = ix+iw+11, ny = 20, nw = Width-nx-ix, nh = [self getStringHeightWithOriginalString:data.costName width:nw WithStringFontOfSize:15];
    _nameFrame = CGRectMake(nx, ny, nw, nh);
    
    // 数量
    CGFloat cnx = nx, cny = CGRectGetMaxY(_nameFrame)+38/2, cnh = 15, cnw = [self getStringWidthWithOriginalString:data.count height:cnh WithStringFontOfSize:12];
    _costNumberFrame = CGRectMake(cnx, cny, cnw, cnh);
    
    // 单价
    CGFloat cx = CGRectGetMaxX(_costNumberFrame)+20, cy = cny, ch = cnh, cw = [self getStringWidthWithOriginalString:data.price height:ch WithStringFontOfSize:12];
    _costFrame = CGRectMake(cx, cy, cw, ch);
    
    // 总价
    CGFloat csx = cnx, csy = CGRectGetMaxY(_costNumberFrame)+38/2, csh = ch, csw = [self getStringWidthWithOriginalString:data.total height:csh WithStringFontOfSize:12];
    _costsFrame = CGRectMake(csx, csy, csw, csh);
    
    // 图片
    ih = CGRectGetMaxY(_costsFrame);
    _imageVFrame = CGRectMake(ix, iy, iw, ih);
    
    // 上半部分总体的视图
    CGFloat tx = 0, ty = 0, tw = Width, th = CGRectGetMaxY(_imageVFrame)+10;
    _topViewFrame = CGRectMake(tx, ty, tw, th);
    
    
    
    // 兑换码 label
    CGFloat ccx = 0, ccy = 0, ccw = Width, cch = 30;
    _costCodeLabelFrame = CGRectMake(ccx, ccy, ccw, cch);
    
    // 兑换码
    CGFloat cfx = 0, cfy = CGRectGetMaxY(_costCodeLabelFrame), cfw = Width, cfh = 60;
    _costCodeFrame = CGRectMake(cfx, cfy, cfw, cfh);
    
    CGFloat ux = 0, uy = CGRectGetMaxY(_costCodeFrame)-10, uw = Width, uh = 15;
    _beUseFrame = CGRectMake(ux, uy, uw, uh);
    
    // 地址视图
    CGFloat avx = 0, avy = CGRectGetMaxY(_beUseFrame), avw = Width, avh = 0;
    
    //  兑换地址
    CGFloat ax = 20, ay = 20, aw = 75, ah = 18;
    _addressLabelFrame = CGRectMake(ax, ay, aw, ah);
    
    // 地址
    CGFloat adx = CGRectGetMaxX(_addressLabelFrame), ady = ay, adw = Width-adx-20, adh = [self getStringHeightWithOriginalString:data.shopAddress width:adw WithStringFontOfSize:15];
    _addressFrame = CGRectMake(adx, ady, adw, adh);
    
    avh = adh+20*2;
    _addViewFramel = CGRectMake(avx, avy, avw, avh); // 兑换视图
    
    
    // 下半部分视图
    CGFloat bx = 0, by = CGRectGetMaxY(_topViewFrame)+5, bw = Width, bh = CGRectGetMaxY(_addViewFramel);
    _botViewFrame = CGRectMake(bx, by, bw, bh);
    
    
}

- (CGFloat)getStringHeightWithOriginalString:(NSString *)str width:(CGFloat)width WithStringFontOfSize:(CGFloat)size
{
    CGRect rect =[str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]} context:nil];
    CGFloat height=ceilf(rect.size.height);
    return height;
}

- (CGFloat)getStringWidthWithOriginalString:(NSString *)str height:(CGFloat)height WithStringFontOfSize:(CGFloat)size
{
    CGRect rect =[str boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]} context:nil];
    CGFloat width=ceilf(rect.size.width);
    return width;
}

@end
