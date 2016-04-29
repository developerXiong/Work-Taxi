//
//  JDNowAndFuturaCell.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/21.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDNowAndFuturaCell.h"

#import "HeadFile.pch"
#import "JDNewAndFeatureImageView.h"

#define NowUseImage [UIImage imageNamed:@"现在上车"]
#define FuturaImage [UIImage imageNamed:@"预约用车"]



@interface JDNowAndFuturaCell ()


@end

@implementation JDNowAndFuturaCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        [self setUpChildViews];
        
    }
    return self;
}

-(void)setUpChildViews
{
    // 背景图片
    _backImageView = [[JDNewAndFeatureImageView alloc] init];
    [self addSubview:_backImageView];
    _backImageView.image = NowUseImage;
   
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize imageS = [NowUseImage size];
    CGFloat bw = imageS.width, bh = imageS.height, bx = (JDScreenSize.width-bw)/2, by = 0;
    _backImageView.frame = CGRectMake(bx, by, bw, bh);
    
    
}

-(CGFloat)textHeightWithWidth:(CGFloat)width textFont:(UIFont *)font Sting:(NSString *)str
{
    CGFloat height = 0;
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    height = rect.size.height;
    
    return height;
}

@end
