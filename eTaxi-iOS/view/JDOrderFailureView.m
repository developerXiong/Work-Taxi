//
//  JDOrderFailureView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDOrderFailureView.h"

#import "HeadFile.pch"

#define TextFont [UIFont systemFontOfSize:18]
#define Text @"很抱歉，此预约已被抢单，去看看其他预约吧"

#define FailureImage [UIImage imageNamed:@"查看其它预约"]

@interface JDOrderFailureView ()

@property (nonatomic, strong) UILabel *text;

@property (nonatomic, strong) UIButton *lookOther;

@property (nonatomic, strong) UIControl *control;

@end

@implementation JDOrderFailureView

//+(instancetype)shareView
//{
//    static JDOrderFailureView *orderView;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        orderView = [[self alloc] initWithFrame:CGRectMake(0, 64, JDScreenSize.width, JDScreenSize.height-64)];
//        
//    });
//    
//    return orderView;
//}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpAllChildViews];
        self.alpha = 0;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
        self.frame = CGRectMake(0, 64, JDScreenSize.width, JDScreenSize.height-64);
        
    }
    return self;
}

-(void)setUpAllChildViews
{
    
    _control = [[UIControl alloc] init];
    [self addSubview:_control];
    [_control addTarget:self action:@selector(clickControl) forControlEvents:UIControlEventTouchUpInside];
    
    // text
    _text = [[UILabel alloc] init];
    [self addSubview:_text];
    _text.font = TextFont;
    _text.textColor = [UIColor whiteColor];
    _text.text = Text;
    _text.textAlignment = NSTextAlignmentCenter;
    _text.numberOfLines = 0;
    
    
    // btn image
    _lookOther = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_lookOther];
    [_lookOther setBackgroundImage:FailureImage forState:UIControlStateNormal];
    [_lookOther addTarget:self action:@selector(clickLookOther) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)clickControl
{
    [self hidden];
}

-(void)clickLookOther
{
    [self hidden];
    if ([_delegate respondsToSelector:@selector(clickLookOtherBtn)]) {
        [_delegate clickLookOtherBtn];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    _control.frame = self.bounds;

    CGFloat tw = 375-80*2, tx = (JDScreenSize.width-tw)/2, ty = 232/2, th = [self textHeightWithWidth:tw textFont:TextFont Sting:Text];
    _text.frame = CGRectMake(tx, ty, tw, th);
    
    CGSize imageS = [FailureImage size];
    CGFloat lw = imageS.width, lh = imageS.height, lx = (JDScreenSize.width-lw)/2, ly = CGRectGetMaxY(_text.frame)+34;
    _lookOther.frame = CGRectMake(lx, ly, lw, lh);
}

-(void)showInView:(UIView *)view
{
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
       
        self.alpha ++;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)hidden
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha --;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
    
}

-(CGFloat)textHeightWithWidth:(CGFloat)width textFont:(UIFont *)font Sting:(NSString *)str
{
    CGFloat height = 0;
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    height = rect.size.height;
    
    return height;
}

@end
