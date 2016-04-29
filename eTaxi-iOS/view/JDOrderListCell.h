//
//  JDOrderListCell.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JDOrderListImageView;
@class JDCallCarListViewModel;
@interface JDOrderListCell : UITableViewCell

@property (nonatomic, strong) JDCallCarListViewModel *viewModel;

@property (nonatomic, strong) JDOrderListImageView *orderImageView;

@end
