//
//  JDCallCarMessageCell.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/25.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDCallCarMessageCell.h"

#import "JDCallCarMessageTotalView.h"

#import "JDCallCarMessageViewFrame.h"

@interface JDCallCarMessageCell ()

/**
 *  整体的View
 */
@property (nonatomic, weak) JDCallCarMessageTotalView *totalView;

@end

@implementation JDCallCarMessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpAllChildViews];
        
    }
    return self;
}


-(void)setUpAllChildViews
{
    // 整体的view
    JDCallCarMessageTotalView *totalView = [[JDCallCarMessageTotalView alloc] init];
    [self addSubview:totalView];
    _totalView = totalView;
    totalView.layer.masksToBounds = YES;
    totalView.layer.cornerRadius = 5.0;
    
}

-(void)setViewFrame:(JDCallCarMessageViewFrame *)ViewFrame
{
    _ViewFrame = ViewFrame;
    
    _totalView.frame = ViewFrame.totalViewFrame;
    
    _totalView.ViewFrame = ViewFrame;
    
}


@end
