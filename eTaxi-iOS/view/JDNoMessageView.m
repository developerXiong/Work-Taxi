//
//  JDNoMessageView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/9.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDNoMessageView.h"

#import "HeadFile.pch"

@interface JDNoMessageView ()

@property (nonatomic, weak) UILabel *textLabel;

@end

@implementation JDNoMessageView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self showHaveNoMessage];
        
    }
    return self;
}

/**
 *  设置没有消息的界面
 */
-(void)showHaveNoMessage
{
    
    /**
     *  图标的大小
     */
    UIImage *image = [UIImage imageNamed:@"喇叭"];
    CGSize imageS = [image size];
    
    /**
     *   没有消息的时候的图标
     */
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageS.width, imageS.height)];
    imageV.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/3);
    [self addSubview:imageV];
    imageV.image = image;
    
    /**
     *  没有消息时候的label
     */
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame)+10, self.bounds.size.width, 30)];
    _textLabel = textLabel;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.textColor = TextLightColor;
    textLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:textLabel];
    
}

-(void)setMessage:(NSString *)message
{
    _message = message;
    
    _textLabel.text = message;
    
}

@end
