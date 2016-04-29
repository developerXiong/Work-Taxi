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
    
    //整体的按钮view
    CGFloat viewW = (JDScreenSize.width - 2)/3;
    CGFloat btnH = viewW * 0.8;
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, btnH*3 + 2)];
    _mainView = mainView;
    [self addSubview:mainView];
    
    for (int i = 0; i < imageNameArr.count; i ++) {
        
        JDLostButton *btn = [self createBtnWithIndex:i imageName:imageNameArr[i] title:imageNameArr[i]];
        btn.btnAndImageName = imageNameArr[i];
        btn.btnName = _nameArr[i];
        
        [self.btnArr addObject:btn];
        
    }
    
}

/**
 *  创建状态按钮
 *
 *  @param index 第几个
 *  @param image 图片名称
 *  @param title 下方的文字
 */
-(JDLostButton *)createBtnWithIndex:(int)index imageName:(NSString *)image title:(NSString *)title
{
    
    CGFloat btnW = (JDScreenSize.width - 2)/3;
    CGFloat btnH = btnW * 0.8;
    int colon = index % 3; //列
    int row = index / 3; //行
    
    JDLostButton *btn = [[JDLostButton alloc] initWithFrame:CGRectMake(colon * (btnW + 1) , row * (btnH + 1), btnW, btnH)];
    btn.delegate = self;
    btn.tag = index;
    //防止同时点击两个按钮
    [btn setExclusiveTouch:YES];
    [self.mainView addSubview:btn];
   
    return btn;
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
