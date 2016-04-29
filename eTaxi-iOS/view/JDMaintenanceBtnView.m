//
//  JDMaintenanceBtnView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMaintenanceBtnView.h"

#import "HeadFile.pch"

#import "JDMaintenanceButton.h"

@interface JDMaintenanceBtnView ()

@end

@implementation JDMaintenanceBtnView

-(NSMutableArray *)btnArr
{
    if (_btnArr==nil) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpAllChildViews];
        
    }
    return self;
}

-(void)setUpAllChildViews
{
    NSArray *titleArr = @[@"更换机油",@"常规检修",@"电路检修",@"变速箱检修",@"电瓶检修",@"发动机修理",@"钣金做漆",@"机械修理",@"胎压"];
    
    NSArray *imageArr = @[@"更换机油1",@"常规检修1",@"电路检修1",@"变速箱检修1",@"电瓶检修1",@"发动机修理1",@"钣金喷漆1",@"机械修理1",@"胎压1"];
    NSArray *selectImageArr = @[@"更换机油高亮",@"常规检修高亮",@"电路检修高亮",@"变速箱检修高亮",@"电瓶检修高亮",@"发动机修理高亮",@"钣金喷漆高亮",@"机械修理高亮",@"胎压高亮"];
    for (int i = 0; i < 9; i ++) {
        
        JDMaintenanceButton *btn = [[JDMaintenanceButton alloc] init];
        
        // 按钮点击回调
        [btn clickProject:^(UIButton *sender) {
            
            if (_repair) {
                _repair(sender);
            }
            
        }];
        
        btn.title = titleArr[i];
        
        btn.imageName = imageArr[i];
        btn.selectImageName = selectImageArr[i];
        
        btn.tag_btn = i;
        
        [self addSubview:btn];
        
        [self.btnArr addObject:btn];
        
    }
    
    for (int i = 0; i < 6; i++) {
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = TextLightColor;
        [self addSubview:line];
        line.tag = i;
    }
    
}

-(void)clickRepairPro:(RepairProject)repair
{
    _repair = repair;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = (self.bounds.size.width-2)/3;
    CGFloat btnH = btnW * 0.8;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[JDMaintenanceButton class]]) {
            
            JDMaintenanceButton *btn = (JDMaintenanceButton *)view;
            
            NSInteger index = btn.tag_btn;
            
            NSInteger colon = index % 3; //列
            NSInteger row = index / 3; //行
            
            [btn setFrame:CGRectMake(colon * (btnW+1) , row * (btnH+1), btnW, btnH)];
            
        }
    }
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            
            UILabel *line = (UILabel *)view;
            
            NSInteger i = line.tag;
            
            NSInteger row = i%4; // 横着的4条线
            
            NSInteger col = i%3; // 竖着的两条线
            if (i<4) {
                line.frame = CGRectMake(0, row*btnH, self.bounds.size.width, 0.5);
            }else{
                line.frame = CGRectMake(col*btnW, 0, 0.5, self.bounds.size.height);
            }
        }
    }
    
}




@end
