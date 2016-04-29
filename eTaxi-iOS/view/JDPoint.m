//
//  JDPoint.m
//  eTaxi-iOS
//
//  Created by jeader on 16/1/12.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDPoint.h"

@implementation JDPoint

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString *)t
{
    self = [super init];
    if (self) {
        _coordinate = c;
        _title = t;
    }
    return self;
}

@end
