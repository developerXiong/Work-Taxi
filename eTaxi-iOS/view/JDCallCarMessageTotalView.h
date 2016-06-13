//
//  JDCallCarMessageTotalView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JDCallCarMessageDelegate <NSObject>

@optional
-(void)messageClickLookDetail:(NSInteger)row;

@end

@class JDCallCarMessageViewFrame;
@interface JDCallCarMessageTotalView : UIView

@property (nonatomic, strong) JDCallCarMessageViewFrame *ViewFrame;

@property (nonatomic, assign) NSInteger tag_mess;

@property (nonatomic, weak) id<JDCallCarMessageDelegate>delegate;

@end
