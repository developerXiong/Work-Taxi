//
//  JDCallCarMessageCell.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JDCallCarMessageViewFrame;
@class JDCallCarMessageTotalView;
@interface JDCallCarMessageCell : UITableViewCell

@property (nonatomic, strong) JDCallCarMessageViewFrame *ViewFrame;

/**
 *  整体的View
 */
@property (nonatomic, weak) JDCallCarMessageTotalView *totalView;

@end
