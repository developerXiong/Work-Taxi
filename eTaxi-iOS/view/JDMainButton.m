//
//  JDMainButton.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/20.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMainButton.h"
#import "HeadFile.pch"
#import "JDIndependentBtn.h"

#define Swidth self.bounds.size.width
#define Sheight self.bounds.size.height

/**
 *  正常的图片
 */
#define DianZImage [UIImage imageNamed:@"电召_main"]
#define RepairImage [UIImage imageNamed:@"预约维修_main"]
#define RoadImage [UIImage imageNamed:@"路况申报_main"]
#define BreakImage [UIImage imageNamed:@"违章查询_main"]
#define LostImage [UIImage imageNamed:@"失物招领_main"]
#define MyScoreImage [UIImage imageNamed:@"我的积分_main"]
#define MoreImage [UIImage imageNamed:@"更多_main"]

/**
 *  翻转的图片
 */
#define DianZZImage [UIImage imageNamed:@"电召_main"]
#define RepairZImage [UIImage imageNamed:@"预约反面"]
#define RoadZImage [UIImage imageNamed:@"路况申报_main"]
#define BreakZImage [UIImage imageNamed:@"违章查询（反面）"]
#define LostZImage [UIImage imageNamed:@"失物招领_main"]
#define MyScoreZImage [UIImage imageNamed:@"我的积分（反面）"]
#define MoreZImage [UIImage imageNamed:@"更多_main"]


#define RepairScale [RepairImage size].height/[RepairImage size].width // 维修预约图片的高宽比例
#define OtherScale [RoadImage size].height/[RoadImage size].width // 其他图片的高宽比例

@interface JDMainButton ()<JDIndependentBtnDelegate>

/**
 *  存放JDIndependentBtn的数组
 */
@property (nonatomic, strong) NSMutableArray *btnArr;

@property (nonatomic, strong) UIView *firstLine;

@property (nonatomic, strong) UIView *secondLine;

@property (nonatomic, strong) UIView *thirdLine;

@property (nonatomic, strong) UIView *fourthLine;

@end

@implementation JDMainButton

-(NSMutableArray *)btnArr
{
    if (_btnArr == nil) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpChildViews];
        
    }
    
    return self;
}

-(void)setUpChildViews
{
    
    // 原始图片的数组
    NSArray *imageArr = @[RepairImage,DianZImage,RoadImage,BreakImage,LostImage,MyScoreImage,MoreImage];
    // 翻转图片的数组
    NSArray *zImageArr = @[RepairZImage,DianZZImage,RoadZImage,BreakZImage,LostZImage,MyScoreZImage,MoreZImage];
    
    // 7个大按钮
    for (int i = 0; i < 7; i++) {
        
        JDIndependentBtn *btn = [self buttonWithImage:imageArr[i] zImage:zImageArr[i] tag:i inView:self];
        
        [self.btnArr addObject:btn];
        
    }
    
    // 第一条分割线
    _firstLine = [[UIView alloc] init];
    _firstLine.backgroundColor = COLORWITHRGB(224, 184, 112, 0.5);
    [self addSubview:_firstLine];
    
    // 第二条分割线
    _secondLine = [[UIView alloc] init];
    _secondLine.backgroundColor = COLORWITHRGB(224, 184, 112, 0.24);
    [self addSubview:_secondLine];
    
    // 第三条分割线
    _thirdLine = [[UIView alloc] init];
    _thirdLine.backgroundColor = COLORWITHRGB(224, 184, 112, 0.24);
    [self addSubview:_thirdLine];
    
    // 第四条分割线
    _fourthLine = [[UIView alloc] init];
    _fourthLine.backgroundColor = COLORWITHRGB(224, 184, 112, 0.24);
    [self addSubview:_fourthLine];
    
}

#pragma mark - 设置子控件位置
-(void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat rx = 0, ry = 0, rw = 0, rh = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[JDIndependentBtn class]]) {
            
            JDIndependentBtn *btn = (JDIndependentBtn *)view;
            
            NSInteger tag = btn.tag_main;
            
            //    NSInteger rows = 3; // 除了第一行的总行数
            NSInteger cols = 2; // 除了第一行的总列数
            
            NSInteger row = (tag-1)/cols; // 当前btn在第几行
            NSInteger col = (tag-1)%cols; // 当前btn在第几列
            
            rw = Swidth/2, rh = rw*OtherScale, rx = col*rw, ry = rh + row*rh + 0.5;
            
            if (tag==0) {
                // 第一个btn的frame
                rx = 0, ry = 0, rw = Swidth, rh = rw*RepairScale;
            }
            
            btn.frame = CGRectMake(rx, ry, rw, rh);
            
        }
    }
    
    
    rw = Swidth/2+0.5, rh = rw*OtherScale;
    
    CGFloat lw = Swidth-4, lh = 4;
    
    _firstLine.frame = CGRectMake(2, rh-1, lw, lh);
    
    _secondLine.frame = CGRectMake(2, rh*2-2, lw, lh);
    
    _thirdLine.frame = CGRectMake(2, rh*3-3, lw, lh);
    
    _fourthLine.frame = CGRectMake(rw-2, rh, 4, 3*rh-4);
    
    
}

#pragma mark - 快速创建自定义按钮
-(JDIndependentBtn *)buttonWithImage:(UIImage *)image zImage:(UIImage *)zImage tag:(NSInteger)tag inView:(UIView *)view
{
    JDIndependentBtn *btn = [[JDIndependentBtn alloc] init];
    
    btn.delegate = self;
    btn.normalImage = image;
    btn.zImage = zImage;
    btn.tag_main = tag;
    [self addSubview:btn];
    
    return btn;
}

#pragma mark - 按钮的delgate
-(void)clickBtnDidAnimation:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(mainButtonDidAnimation:)]) {
        [_delegate mainButtonDidAnimation:sender];
    }
}

-(void)clickBtnWillAnimation:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(mainButtonWillAnimation:)]) {
        [_delegate mainButtonWillAnimation:sender];
    }
    // 防止连续点击多个按钮
    for (JDIndependentBtn *btn in self.btnArr) {
        
        // 防止同时点击两个按钮
        [btn.button setExclusiveTouch:YES];
        
        btn.enble_main = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            btn.enble_main = YES;
            
        });
        
    }
    
}

@end
