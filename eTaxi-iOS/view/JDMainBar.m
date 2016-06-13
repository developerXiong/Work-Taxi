//
//  JDMainBar.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/20.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMainBar.h"

#define Swidth self.bounds.size.width
#define Sheight self.bounds.size.height

#define TitleFont [UIFont systemFontOfSize:18] // 主页标题文字的大小
#define Title @"E+TAXI" 

@interface JDMainBar ()

/**
 *  个人信息图片
 */
@property (nonatomic, strong) UIImageView *personInfoImage;

/**
 *   标题
 */
@property (nonatomic, strong) UIImageView *title;

@end

@implementation JDMainBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpChildViews];
        
        self.backgroundColor = COLORWITHRGB(0, 91, 201, 1);
    }
    
    return self;
}

-(void)setUpChildViews
{
    // 个人信息图片
    _personInfoImage = [[UIImageView alloc] init];
    [self addSubview:_personInfoImage];
    _personInfoImage.image = [UIImage imageNamed:@"主页头像1"];
    
    // 个人信息按钮
    _personInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_personInfoBtn];
    [_personInfoBtn addTarget:self action:@selector(clickPersonInfo) forControlEvents:UIControlEventTouchUpInside];
    
    // 标题
    _title = [[UIImageView alloc] init];
    [self addSubview:_title];
    _title.image = [UIImage imageNamed:@"E+TAXI"];
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIImage *image = [UIImage imageNamed:@"主页头像1"];
    CGSize imageS = [image size];
    CGFloat px = 20 ,pw = imageS.width , ph = imageS.height , py = (Sheight-20-ph)/2+20;
    _personInfoImage.frame = CGRectMake(px, py, pw, ph);
    
    _personInfoBtn.frame = CGRectMake(0, 20, 80, 44);
    
    // 标题
    UIImage *tImage = [UIImage imageNamed:@"E+TAXI"];
    CGSize tImageS = [tImage size];
    CGFloat tx = (Swidth-tImageS.width)/2 , tw = tImageS.width , th = tImageS.height , ty = py;
    _title.frame = CGRectMake(tx, ty, tw, th);
    
}

#pragma mark - 点击个人信息
-(void)clickPersonInfo
{
    if ([_delegate respondsToSelector:@selector(clickPersonInfo)]) {
        [_delegate clickPersonInfo];
    }
}

-(CGFloat)textWidthWithHeight:(CGFloat)height textFont:(UIFont *)font Sting:(NSString *)str
{
    CGFloat width = 0;
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    width = rect.size.width;
    
    return width;
}

@end
