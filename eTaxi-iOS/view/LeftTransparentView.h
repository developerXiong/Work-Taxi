//
//  LeftTransparentView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/2/15.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyData.h"

@protocol LeftViewDelegate <NSObject>

- (void)selectRow:(NSInteger)row;

@end

@interface LeftTransparentView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id <LeftViewDelegate> delegate;
@property (nonatomic, strong) MyData * data ;

@end
