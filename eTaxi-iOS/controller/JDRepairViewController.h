//
//  JDRepairViewController.h
//  eTaxi-iOS
//
//  Created by jeader on 15/12/29.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JDRepairDelegate <NSObject>
@optional

-(void)setRepairName:(NSString *)repairName repairID:(NSString *)repairID;

@end

@interface JDRepairViewController : UIViewController

@property (nonatomic, assign) id <JDRepairDelegate> delegate;

@end
