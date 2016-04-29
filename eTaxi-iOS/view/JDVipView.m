//
//  JDVipView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/3/24.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDVipView.h"
#import "HeadFile.pch"

@implementation JDVipView

-(instancetype)init
{
    CGFloat mainX = 0;
    CGFloat mainY = 0;
    CGFloat mainW = JDScreenSize.width;
    CGFloat mainH = mainW*81/64; //比例缩放
    CGRect frame = CGRectMake(mainX, mainY, mainW, mainH);
    
    return [self initWithFrame:frame];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addsubviews];
        
        
        
    }
    return self;
}

-(void)addsubviews
{
    /**
     * 会员中心背景图
     */
    _mainView = [[UIImageView alloc] initWithFrame:self.bounds];
    _mainView.image = [UIImage imageNamed:@"会员中心背景"];
    [self addSubview:_mainView];
    
    /**
     *  标题
     */
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((JDScreenSize.width-81)/2, 36, 81, 24)];
    title.text = @"会员中心";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    [_mainView addSubview:title];
    
    /**
     *  顶部阴影
     */
    UIView *shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, 20)];
    shadow.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.05];
    [_mainView addSubview:shadow];
    
    /**
     *  姓名
     */
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20, 64+20, 80, 25)];
    _nameLabel = name;
    name.textColor = [UIColor whiteColor];
    name.font = [UIFont systemFontOfSize:15];
    [_mainView addSubview:name];
    
    /**
     *  会员等级
     */
    UILabel *memberLevel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(name.frame), 80, 25)];
    _memberLevel = memberLevel;
    memberLevel.textColor = [UIColor whiteColor];
    memberLevel.font = [UIFont systemFontOfSize:18];
    [_mainView addSubview:memberLevel];

    
    CGFloat toBoMargin = 20; //到底部的间距
    if (JDScreenSize.width==320) { // 4s 5s
        toBoMargin = 17;
    }
    /**
     *  推荐乘客
     */
    UILabel *recommend = [[UILabel alloc] initWithFrame:CGRectMake(18, self.bounds.size.height - toBoMargin - 10, 60, 15)];
    recommend.text = @"推荐乘客";
    recommend.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    recommend.font = [UIFont systemFontOfSize:13];
    [_mainView addSubview:recommend];
    
        /**
         *  推荐次数
         */
        UILabel *commendCount = [[UILabel alloc] initWithFrame:CGRectMake(JDScreenSize.width/2-20-40, self.bounds.size.height-12-toBoMargin, 40, 20)];
        _commendCount = commendCount;
        commendCount.textAlignment = NSTextAlignmentRight;
        commendCount.textColor = [UIColor whiteColor];
        commendCount.text = @"17次";
        commendCount.font = [UIFont systemFontOfSize:16];
        [_mainView addSubview:commendCount];
    
    /**
     *  信用积分
     */
    UILabel *credit = [[UILabel alloc] initWithFrame:CGRectMake(JDScreenSize.width/2+20, self.bounds.size.height - toBoMargin - 10, 60, 15)];
    credit.text = @"信用积分";
    credit.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    credit.font = [UIFont systemFontOfSize:13];
    [_mainView addSubview:credit];
    
        /**
         *  信用积分数
         */
        UILabel *creditCount = [[UILabel alloc] initWithFrame:CGRectMake(JDScreenSize.width-20-60, self.bounds.size.height-14-toBoMargin, 60, 20)];
        _creditCount = creditCount;
        creditCount.textColor = [UIColor whiteColor];
        creditCount.text = @"240";
        creditCount.textAlignment = NSTextAlignmentRight;
        creditCount.font = [UIFont systemFontOfSize:16];
        [_mainView addSubview:creditCount];
    
}


@end
