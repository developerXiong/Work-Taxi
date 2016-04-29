//
//  Serialize.m
//  eTaxi-iOS
//
//  Created by jeader on 16/1/11.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "Serialize.h"

@implementation Serialize

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.headImg forKey:@"headPic"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ([super init])
    {
        self.headImg=[aDecoder decodeObjectForKey:@"headPic"];
    }
    return self;
}

@end
