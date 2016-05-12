//
//  JDMaintenanceButtonView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/27.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMaintenanceButton.h"

#import "HeadFile.pch"

#import "UIView+UIView_CYChangeFrame.h"

@interface JDMaintenanceButton ()

@property (nonatomic, weak) UIButton *btn;

@property (nonatomic, weak) UIImageView *imageV;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIImage *selectImage;

@end

@implementation JDMaintenanceButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpAllChildViews];
        
//        [self setBackgroundColor:[UIColor whiteColor]];
        
    }
    return self;
}

-(void)setUpAllChildViews
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    _btn = btn;
    btn.highlighted = NO;
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.selected = YES;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [btn addSubview:imageV];
    _imageV = imageV;
    
    
//    UILabel *label = [[UILabel alloc] init];
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:15];
//    [btn addSubview:label];
//    _titleLabel = label;
    
}

-(void)setTag_btn:(NSInteger)tag_btn
{
    _tag_btn = tag_btn;
    
    _btn.tag = tag_btn;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    
    _titleLabel.text = title;
    
}

-(void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    
    _image = [UIImage imageNamed:imageName];
    
    _imageV.image = [UIImage imageNamed:imageName];
    
}

-(void)setSelectImageName:(NSString *)selectImageName
{
    _selectImageName = selectImageName;
    
    _selectImage = [UIImage imageNamed:selectImageName];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _btn.frame = self.bounds;
    
    CGSize imageS = [_image size];
    CGFloat btnW = self.bounds.size.width, btnH = self.bounds.size.height;
    _imageV.frame = CGRectMake((btnW - imageS.width)/2, (btnH-imageS.height)/5, imageS.width, imageS.height);
    _imageV.center = CGPointMake(btnW/2, btnH/2);
    
    // 图片整体居中
    CGFloat margin = (self.bounds.size.width-imageS.width)/2/2;
    if (self.tag_btn==0||self.tag_btn==3||self.tag_btn==6) {
        _imageV.x += margin;
    }
    if (self.tag_btn==2||self.tag_btn==5||self.tag_btn==8) {
        _imageV.x -= margin;
    }
    
//    CGFloat labelW = [self getStringWidthWithOriginalString:_title WithStringFontOfSize:15];
//    _titleLabel.frame = CGRectMake((btnW-labelW)/2, CGRectGetMaxY(_imageV.frame)+8, labelW, 20);
    
}

// 点击维修项目调用
-(void)clickBtn:(UIButton *)sender
{
    JDLog(@"点击维修项目%ld",(long)sender.tag);
    if (_repair) {
        _repair(sender);
    }
    sender.selected = !sender.selected;
    if (sender.selected) {
        _imageV.image = _image;
    }else{
        _imageV.image = _selectImage;
    }
}

-(void)clickProject:(RepairProject)repair
{
    _repair = repair;
}

//根据输入的字符串来获取label的宽度
- (NSInteger)getStringWidthWithOriginalString:(NSString *)str WithStringFontOfSize:(CGFloat)size
{
    CGRect rect =[str boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]} context:nil];
    CGFloat width=ceilf(rect.size.width);
    return width;
}

- (NSInteger)getStringHeightWithOriginalString:(NSString *)str WithStringFontOfSize:(CGFloat)size
{
    CGRect rect =[str boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]} context:nil];
    CGFloat height=ceilf(rect.size.height);
    return height;
}


@end
