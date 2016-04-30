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
    [btn setExclusiveTouch:YES];
    [btn addTarget:self action:@selector(clickMove:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];

    UILabel *label = [[UILabel alloc] init];
    _label = label;
    label.font = TopTextFont;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [btn addSubview:label];

    
    UIImageView *imageV = [[UIImageView alloc] init];
    _imageV = imageV;
    imageV.userInteractionEnabled = NO;
    [btn addSubview:imageV];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_btn setFrame:self.bounds];
    
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
    
    CGFloat toMargin = 10;
    
    if (JDScreenSize.width==414) {
        
        toMargin = 13;
        
    }
    
    _imageV.frame = CGRectMake(imageX, CGRectGetMinY(_label.frame)-toMargin-imageS.height, imageS.width, imageS.height);
    
}


-(void)clickMove:(UIButton *)sender
{
    JDLog(@"点击物品类型");
    if ([_delegate respondsToSelector:@selector(clickBtnWillAnimation:btnName:)]) {
        [_delegate clickBtnWillAnimation:self btnName:_btnAndImageName];
    }

    [self startAnimation];
}

#pragma mark - 动画效果
-(void)startAnimation
{
    
    CGFloat durtion = 0.3; // 动画时间
    
    // 图片会往上跑一段距离，很奇怪
//    self.transform = CGAffineTransformMakeTranslation(0, 12);
    [UIView animateWithDuration:durtion animations:^{
        
        _imageV.transform = CGAffineTransformMakeScale(2.0, 2.0);
        _imageV.alpha --;
        
        
    } completion:^(BOOL finished) {
        
        if ([_delegate respondsToSelector:@selector(clickBtnDidAnimation:btnName:)]) {
            [_delegate clickBtnDidAnimation:self btnName:_btnAndImageName];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            _imageV.transform = CGAffineTransformIdentity;
            _imageV.alpha = 1;
            
        });
        

    }];
}


-(void)setEnble:(BOOL)enble
{
    if ([_btnAndImageName length]) {
        _enble = enble;
        
        _btn.enabled = enble;
    }
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
