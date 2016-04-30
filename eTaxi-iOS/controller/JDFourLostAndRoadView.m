//
//  JDFourLostAndRoadCell.m
//  eTaxi-iOS
//
//  Created by jeader on 16/3/3.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDFourLostAndRoadView.h"

#import "HeadFile.pch"
#import "JDLostButton.h"

#define TopTextFont [UIFont systemFontOfSize:13] //顶部label的文字大小

@interface JDFourLostAndRoadView ()<JDLostButtonDelegate>



@end

@implementation JDFourLostAndRoadView

-(NSMutableArray *)btnArr
{
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        
    }
    return self;
}

-(void)setNameArr:(NSArray *)nameArr
{
    _nameArr = nameArr;
    
}

-(void)setImageNameArr:(NSArray *)imageNameArr
{
    _imageNameArr = imageNameArr;
    
    
    // 按钮
    for (int i = 0; i < imageNameArr.count; i ++) {
        
        JDLostButton *btn = [[JDLostButton alloc] init];
        
        btn.tag = i;
        
        btn.btnAndImageName = imageNameArr[i];
        btn.btnName = _nameArr[i];
        
        btn.delegate = self;
        //防止同时点击两个按钮
        [btn setExclusiveTouch:YES];
        
        [self addSubview:btn];
        
        [self.btnArr addObject:btn];
        
    }
    
    // 添加白线
    for (int i = 0; i < 5; i++) {
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = TextLightColor;
        [self addSubview:line];
        line.tag = i;
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = (JDScreenSize.width - 2)/3;
    CGFloat btnH = btnW * 0.8;
    
    // 按钮
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[JDLostButton class]]) {
            
            JDLostButton *btn = (JDLostButton *)view;
            
            NSInteger index = btn.tag;
            
            NSInteger col = index % 3; //列
            NSInteger row = index / 3; //行
            
            btn.frame = CGRectMake(col * (btnW + 1) , row * (btnH + 1), btnW, btnH);
            
        }
    }
    
    // 线
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            
            UILabel *line = (UILabel *)view;
            
            NSInteger i = line.tag;
            
            NSInteger row = i%3; // 横着的3条线
            
            NSInteger col = i%2; // 竖着的2条线
            if (i<3) {
                line.frame = CGRectMake(0, row*btnH, self.bounds.size.width, 0.5);
            }else{
                line.frame = CGRectMake(col*btnW+btnW, 0, 0.5, self.bounds.size.height);
            }
        }
    }
}

#pragma mark - lostButton delegate
-(void)clickBtnDidAnimation:(UIButton *)sender btnName:(NSString *)str
{
    JDLog(@"four 点击 did animation %@",_nameArr);
    if ([_delegate respondsToSelector:@selector(clickBtnDidAnimation:btnName:)]) {
        [_delegate clickBtnDidAnimation:sender btnName:str];
    }
}

-(void)clickBtnWillAnimation:(UIView *)sender btnName:(NSString *)str
{
//    JDLostButton *btnView = (JDLostButton *)sender;
    JDLog(@"four 点击 will animation %@",_nameArr);
    if ([_delegate respondsToSelector:@selector(clickBtnWillAnimation:btnName:)]) {
        [_delegate clickBtnWillAnimation:sender btnName:str];
    }
    // 防止连续点击多个按钮
    for (JDLostButton *btn in self.btnArr) {
        
        // 防止同时点击两个按钮
        [btn.btn setExclusiveTouch:YES];
        
        btn.enble = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            btn.enble = YES;
            
        });
        
    }
    
}

@end
