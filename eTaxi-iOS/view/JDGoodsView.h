//
//  JDGoodsView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/26.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JDGoodsData.h"

@protocol JDGoodsViewDelegate <NSObject>

@optional
-(void)goodsViewSelectItem:(NSInteger)index;

@end

@interface JDGoodsView : UIView

@property (nonatomic, weak) id<JDGoodsViewDelegate>delegate;

@property (nonatomic, strong)NSMutableArray *modelArr;

@end
