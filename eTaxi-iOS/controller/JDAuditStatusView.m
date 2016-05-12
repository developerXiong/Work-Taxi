//
//  JDAuditStatusView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/8.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDAuditStatusView.h"
#import "HeadFile.pch"

#define UnSelectColor [[UIColor whiteColor] colorWithAlphaComponent:0.6] // 按钮未选中状态的颜色
#define SelectColor [UIColor whiteColor] // 按钮选中状态的颜色

@interface JDAuditStatusView ()

/**
 *  保存按钮
 */
//@property (nonatomic, strong) NSMutableArray *btnArr;

@end

static NSMutableArray *_btnArr;

@implementation JDAuditStatusView
//
//-(NSMutableArray *)btnArr
//{
//    if (_btnArr == nil) {
//        _btnArr = [NSMutableArray array];
//    }
//    return _btnArr;
//}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpAllChildViews];
        
        _btnArr = [NSMutableArray array];
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

-(void)setUpAllChildViews
{
    
}

-(void)setStatusBtnArr:(NSArray *)statusBtnArr
{
    _statusBtnArr = statusBtnArr;
    
    NSUInteger count = statusBtnArr.count;
    
    CGFloat selfW = self.bounds.size.width,selfH = self.bounds.size.height;
    
    CGFloat w=selfW/count-1,x=0,y=0,h=self.bounds.size.height;
    
    for (int i = 0; i < count; i ++) {
        x=(w+1)*i;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(x, y, w, h)];
        [button setTitle:statusBtnArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickLostStatus:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
        [button setBackgroundColor:UnSelectColor];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = i;
        [self addSubview:button];
        [_btnArr addObject:button];
        if (i==_currentIndex) {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setBackgroundColor:SelectColor];
        }

    }
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, selfH-0.5, JDScreenSize.width, 0.5)];
    line.backgroundColor = LineBackgroundColor;
    [self addSubview:line];
}

-(void)clickLostStatus:(UIButton *)sender
{

    if ([_delegate respondsToSelector:@selector(auditStatusBtnClick:)]) {
        [_delegate auditStatusBtnClick:sender.tag];
    }
    
}

-(void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    
    [self changeBtnStatus:currentIndex];
}

-(void)changeBtnStatus:(NSInteger)tag
{
    
    for (UIButton *btn in _btnArr) {
        
        if (btn.tag!=tag) {
            
            [btn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
            [btn setBackgroundColor:UnSelectColor];
        }else{
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:SelectColor];
            
        }
    }
}

@end
