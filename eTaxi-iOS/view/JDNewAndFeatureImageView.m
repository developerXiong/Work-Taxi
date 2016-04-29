//
//  JDNewAndFeatureImageView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDNewAndFeatureImageView.h"

#define TextFont [UIFont systemFontOfSize:12]
#define TextColor [UIColor blackColor]

@interface JDNewAndFeatureImageView ()




@end

@implementation JDNewAndFeatureImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpAllChildViews];
        self.userInteractionEnabled = YES;
    }
    return self;
}


-(void)setUpAllChildViews
{
    _phoneNo = [[UILabel alloc] init];
    [self addSubview:_phoneNo];
    _phoneNo.textColor = TextColor;
    _phoneNo.font = TextFont;
    
    _time = [[UILabel alloc] init];
    [self addSubview:_time];
    _time.textColor = TextColor;
    _time.font = TextFont;
    
    _address = [[UILabel alloc] init];
    [self addSubview:_address];
    _address.textColor = TextColor;
    _address.font = TextFont;
    
    _destination = [[UILabel alloc] init];
    [self addSubview:_destination];
    _destination.textColor = TextColor;
    _destination.font = TextFont;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 6;
    CGFloat px = 20, py = 5, pw = self.bounds.size.width*3/4, ph = 15;
    _phoneNo.frame = CGRectMake(px, py, pw, ph);
    
    _time.frame = CGRectMake(px, CGRectGetMaxY(_phoneNo.frame)+margin, pw, ph);
    
    _address.frame = CGRectMake(px, CGRectGetMaxY(_time.frame)+margin, pw, ph);
    
    _destination.frame = CGRectMake(px, CGRectGetMaxY(_address.frame)+margin, pw, ph);
}

@end
