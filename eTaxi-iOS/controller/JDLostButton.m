//
//  JDLostButton.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/8.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDLostButton.h"
#import "HeadFile.pch"

#import "UIView+UIView_CYChangeFrame.h"

#define selfW self.bounds.size.width
#define selfH self.bounds.size.height
#define TopTextFont [UIFont systemFontOfSize:13] //顶部label的文字大小

@interface JDLostButton ()

@property (nonatomic, weak) UILabel *label;

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
    
    _imageV.frame = CGRectMake(0, 0, imageS.width, imageS.height);
    _imageV.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    // 图片整体居中
    CGFloat margin = (self.bounds.size.width-imageS.width)/2/2;
    if (self.tag==0||self.tag==3||self.tag==6) {
        _imageV.x += margin;
    }
    if (self.tag==2||self.tag==5||self.tag==8) {
        _imageV.x -= margin;
    }
}


-(void)clickMove:(UIButton *)sender
{
    JDLog(@"点击物品类型");
    if ([_delegate respondsToSelector:@selector(clickBtnWillAnimation:btnName:)]) {
        [_delegate clickBtnWillAnimation:self btnName:_btnAndImageName];
    }

//    [self startAnimation];
    
    if (_highlightImage) {
        _imageV.image = [UIImage imageNamed:_highlightImage];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self delay];
        
    });
    
    
}

-(void)delay
{
    if ([_delegate respondsToSelector:@selector(clickBtnDidAnimation:btnName:)]) {
        [_delegate clickBtnDidAnimation:self btnName:_btnAndImageName];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (_btnAndImageName) {
            _imageV.image = [UIImage imageNamed:_btnAndImageName];
        }
        
    });
}

#pragma mark - 动画效果
-(void)startAnimation
{
    
    CGFloat durtion = 0.3; // 动画时间
    
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
    if ([btnAndImageName length]) { // 如果有值，则设置按钮图片， 没有值就将按钮隐藏
        
        _btnAndImageName = btnAndImageName;
        
        _imageV.image = [UIImage imageNamed:btnAndImageName];
        
        
    }else{
        _btn.enabled = NO;
    }
    
}

-(void)setHighlightImage:(NSString *)highlightImage
{
    _highlightImage = highlightImage;
    JDLog(@"%@",highlightImage);
}

@end
