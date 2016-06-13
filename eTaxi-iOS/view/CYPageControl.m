//
//  CYPageControl.m
//  CustomePageControlTest2
//
//  Created by jeader on 16/1/27.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "CYPageControl.h"

//不是当前的pagecontrol图片
#define NoCurrentImage [UIImage imageNamed:@"shape26"]

//是当前的pageControl图片
#define CurrentImage [UIImage imageNamed:@"shape27"]


#define SWidth self.bounds.size.width
#define SHeight self.bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

#define PageColor [UIColor blueColor]

#define PageWidth 8 // page width

@interface CYPageControl ()

@property (nonatomic, weak) UIView *mainView;

/**
 *  放每个小的图片的数组
 */
@property (nonatomic, strong) NSMutableArray *smallPageArr;

@end

@implementation CYPageControl

-(NSMutableArray *)smallPageArr
{
    if (_smallPageArr==nil) {
        _smallPageArr = [NSMutableArray array];
    }
    return _smallPageArr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpChildViews];
        

    }
    return self;
}

#pragma mark - 设置所有视图
-(void)setUpChildViews
{
    // 整体的视图
    UIView *mainView = [[UIView alloc] init];
    [self addSubview:mainView];
    _mainView = mainView;
    
    
}

// 设置所有控件的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _mainView.frame = self.bounds;
    
}


#pragma mark - all property
-(void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    
    for (int i = 0; i < numberOfPages; i++) {
        
        CGFloat x = i*SWidth/numberOfPages, y = 0, w = SWidth/numberOfPages, h = SHeight;
        UIView *bigPage = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_mainView addSubview:bigPage];
        
        UIView *smallPage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PageWidth, PageWidth)];
        [self setUpSmallPage:smallPage];
        [bigPage addSubview:smallPage];
        [self.smallPageArr addObject:smallPage];
        
    }
    
}

-(void)setCurrentCount:(NSInteger)currentCount
{
    _currentCount = currentCount;
    
    [self changePageIndex:currentCount];
    
}

#pragma mark - other
-(void)changePageIndex:(NSInteger)index
{
    // 放page的数组
    NSArray *pageArr = (NSArray *)self.smallPageArr;
    // page的总数量
    NSInteger count = pageArr.count;
    
    for (int i = 0; i < count; i++) {
        
        UIView *smallPage = (UIView *)pageArr[i];
        
        if (index == i) {
            
            smallPage.backgroundColor = PageColor;
            
        }else{
            
            [self setUpSmallPage:smallPage];
            
        }
        
    }
    
}

-(void)setUpSmallPage:(UIView *)smallPage
{
    smallPage.backgroundColor = [UIColor whiteColor];
    smallPage.layer.borderWidth = 0.5;
    smallPage.layer.borderColor = [PageColor CGColor];
    smallPage.layer.cornerRadius = PageWidth/2;
    smallPage.layer.masksToBounds = YES;
}

@end
