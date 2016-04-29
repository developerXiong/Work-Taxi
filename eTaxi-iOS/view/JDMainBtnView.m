//
//  JDMainBtnView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/20.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMainBtnView.h"

#import "JDMainButton.h"

#define RoadImage [UIImage imageNamed:@"路况申报_main"]
#define OtherScale [RoadImage size].height/[RoadImage size].width // 其他图片的高宽比例

@interface JDMainBtnView ()

@property (nonatomic, strong) UIImageView *backImage;



@end

@implementation JDMainBtnView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpChildViews];
        
    }
    
    return self;
}

-(void)setUpChildViews
{
    // 背景
    _backImage = [[UIImageView alloc] init];
    [self addSubview:_backImage];
    _backImage.image = [UIImage imageNamed:@"背景"];
    _backImage.contentMode = UIViewContentModeScaleAspectFill;
    
    // 整体的按钮视图
    _mainButton = [[JDMainButton alloc] init];
    [self addSubview:_mainButton];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _backImage.frame = self.bounds;
    
    CGFloat bw = self.bounds.size.width-73, imagew = bw/2;
    _mainButton.frame = CGRectMake(73/2, 22, bw, imagew*OtherScale*4);
    
}

@end
