//
//  JDUserManualBtnView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/5/16.
//  Copyright © 2016年 jeader. All rights reserved.
//  按钮的视图界面

#import "JDUserManualBtnView.h"

#import "HeadFile.pch"
#import "JDUserManualButton.h"
#import "UIView+UIView_CYChangeFrame.h"

@interface JDUserManualBtnView ()<JDUserManualButtonDelegate>

@property (nonatomic, strong) NSMutableArray *buttonArr;

@end

@implementation JDUserManualBtnView

-(NSMutableArray *)buttonArr
{
    if (_buttonArr==nil) {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}

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
    // 五个按钮
    
    
    
    // 实线
    UILabel *line = [[UILabel alloc] init];
    [self addSubview:line];
    _line = line;
    line.backgroundColor = BLUECOLOR;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _line.frame = CGRectMake(0, self.bounds.size.height-2, self.bounds.size.width/5, 2);
    
}

-(void)setBtnArr:(NSMutableArray *)btnArr
{
    _btnArr = btnArr;
    
    NSInteger count = btnArr.count;
    
    JDLog(@"%ld",(long)count);
    
    CGFloat width = JDScreenSize.width/count, height = width;
    
    for (int i = 0; i < count; i ++) {
        
        JDUserManualButton *btn = [[JDUserManualButton alloc] initWithFrame:CGRectMake(i*width, 0, width, height)];
        
        btn.btn_tag = i;
        
        btn.delegate = self;
        
        btn.imageName = btnArr[i];
        
        [self addSubview:btn];
        
        [self.buttonArr addObject:btn];
        
    }
    
    self.frame = CGRectMake(0, 0, JDScreenSize.width, height);
    
}

-(void)setHighlightBtnArr:(NSMutableArray *)highlightBtnArr
{
    _highlightBtnArr = highlightBtnArr;
}

-(void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self changeBtnStatusWithIndex:currentIndex];
}

#pragma mark - button的delegate
-(void)userManualButtonClickIndex:(NSInteger)index
{
    JDLog(@"%ld",(long)index);
    
    [self changeBtnStatusWithIndex:index];
    
    if (_userManualClick) {
        
        _userManualClick(index);
    }
    
}

-(void)changeBtnStatusWithIndex:(NSInteger)index
{
    for (int i = 0; i < self.buttonArr.count; i++) {
        
        JDUserManualButton *btn = (JDUserManualButton *)self.buttonArr[i];
        
        if (i==index) {
            
            btn.imageName = _highlightBtnArr[index];
            [UIView animateWithDuration:0 animations:^{
                
                _line.x = index*JDScreenSize.width/5;
                
            }];
            
        }else{
            
            btn.imageName = _btnArr[i];
            
        }
        
    }
    
}

#pragma mark - block
-(void)userManualClickBtn:(UserManualButtonClick)userManualClick
{
    _userManualClick = userManualClick;
    
}

-(void)selectBtnIndex:(NSInteger)index
{
    [self changeBtnStatusWithIndex:index];
}

@end
