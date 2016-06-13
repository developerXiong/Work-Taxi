//
//  JDUserManualButton.m
//  eTaxi-iOS
//
//  Created by jeader on 16/5/16.
//  Copyright © 2016年 jeader. All rights reserved.
//  单独的一个按钮

#import "JDUserManualButton.h"

@interface JDUserManualButton ()
/**
 *  按钮
 */
@property (nonatomic, weak) UIButton *mainBtn;
/**
 *  按钮上的imageView
 */
@property (nonatomic, weak) UIImageView *btnImageV;


@end

@implementation JDUserManualButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpChildViews];
        
    }
    return self;
}

-(void)setUpChildViews
{
    // 整体的按钮
    UIButton *mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:mainBtn];
    [mainBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    _mainBtn = mainBtn;
    
    // 图片
    UIImageView *btnImageV = [[UIImageView alloc]init];
    [mainBtn addSubview:btnImageV];
    _btnImageV = btnImageV;
    
    
}

// 点击按钮
-(void)clickBtn:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(userManualButtonClickIndex:)]) {
        [_delegate userManualButtonClickIndex:sender.tag];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _mainBtn.frame = self.bounds;
    
    
}

-(void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    
    // 按钮上的图片
    UIImage *btnImage = [UIImage imageNamed:imageName];
    // 按钮的大小
    CGSize imageS = [btnImage size];
    // 按钮上图片的frame
    _btnImageV.frame = CGRectMake(0, 0, imageS.width, imageS.height);
    _btnImageV.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    _btnImageV.image = btnImage;
    
    
}

-(void)setBtn_tag:(NSInteger)btn_tag
{
    _btn_tag = btn_tag;
    
    _mainBtn.tag = btn_tag;
}

@end
