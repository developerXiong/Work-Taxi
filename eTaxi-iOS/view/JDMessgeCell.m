//
//  JDMessgeCell.m
//  eTaxi-iOS
//
//  Created by jeader on 16/3/10.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDMessgeCell.h"

@implementation JDMessgeCell

- (void)awakeFromNib {
    // Initialization code
    
    self.messPoint.hidden = YES; //红色提醒小点
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
