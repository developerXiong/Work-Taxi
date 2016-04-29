//
//  JDLostButton.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/8.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDLostButton.h"
#import "HeadFile.pch"

#define selfW self.bounds.size.width
#define selfH self.bounds.size.height
#define TopTextFont [UIFont systemFontOfSize:13] //顶部label的文字大小

@interface JDLostButton ()

@property (nonatomic, weak) UILabel *label;

@property (nonatomic, weak) UIImageView *imageV;

@property (nonatomic, weak) UIImageView *backgroundImage;


@end

@implementation JDLostButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        [self addAllChildViews];
        
    }
    return self;
}

-(void)addAllChildViews
{
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn = btn;
    [btn setFrame:self.bounds];
    [btn setExclusiveTouch:YES];
    
    //在边缘移动
    [btn addTarget:self action:@selector(clickMove:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:btn.bounds];
    _backgroundImage = backgroundImage;
    backgroundImage.tag  = 1020;
    backgroundImage.userInteractionEnabled = NO;
    [btn addSubview:backgroundImage];

    UILabel *label = [[UILabel alloc] init];
    _label = label;
    
    label.font = TopTextFont;
    label.tag = 1021;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [btn addSubview:label];

    

    UIImageView *imageV = [[UIImageView alloc] init];
    _imageV = imageV;
    imageV.userInteractionEnabled = NO;
    
    imageV.tag = 1022;
    [btn addSubview:imageV];
}

-(void)clickMove:(UIButton *)sender
{
    JDLog(@"点击物品类型");
    if ([_delegate respondsToSelector:@selector(clickBtnWillAnimation:btnName:)]) {
        [_delegate clickBtnWillAnimation:self btnName:_btnAndImageName];
    }
//    [self animationStart:sender durtion:0.6 type:0];
    [self endAnimation];
}

#pragma mark - 动画效果
// 动画结束后调用
-(void)endAnimation
{
    
    CGFloat durtion = 0.5; // 动画时间
    
    [UIView animateWithDuration:durtion animations:^{
        
        self.transform = CGAffineTransformMakeScale(2, 2);
        self.alpha --;
        
        
    } completion:^(BOOL finished) {
        
        if ([_delegate respondsToSelector:@selector(clickBtnDidAnimation:btnName:)]) {
            [_delegate clickBtnDidAnimation:self btnName:_btnAndImageName];
        }
        
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
//        [self animationStart:_btn durtion:0 type:1];
    }];
}


-(void)setEnble:(BOOL)enble
{
    if ([_btnAndImageName length]) {
        _enble = enble;
        
        _btn.enabled = enble;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize imageS = [[UIImage imageNamed:_btnAndImageName] size];
    /**
     *  字和图片到下边框的距离
     */
    CGFloat toBoMagrin = 13;
    if (JDScreenSize.width == 320) {
        toBoMagrin = 3;
    }
    
    if (JDScreenSize.width == 375) {
        toBoMagrin = 10;
    }
    
    _label.frame = CGRectMake((self.bounds.size.width-100)/2, selfH-toBoMagrin-15, 100, 15);
    
    CGFloat imageX = (selfW - imageS.width)/2;
    
    CGFloat toMargin = 5;
    
    if (JDScreenSize.width==414) {
        
        toMargin = 10;
        
    }
    
    _imageV.frame = CGRectMake(imageX, CGRectGetMinY(_label.frame)-toMargin-imageS.height, imageS.width, imageS.height);
    
}

-(void)setBtnAndImageName:(NSString *)btnAndImageName
{
    if ([btnAndImageName length]) {
        
        _btnAndImageName = btnAndImageName;
        
        
        _imageV.image = [UIImage imageNamed:btnAndImageName];
        
        
    }else{
        _btn.enabled = NO;
    }
    
}

-(void)setBtnName:(NSString *)btnName
{
    _btnName = btnName;
    
    _label.text = btnName;
    
}

@end
