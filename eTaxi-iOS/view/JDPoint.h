//
//  JDPoint.h
//  eTaxi-iOS
//
//  Created by jeader on 16/1/12.
//  Copyright © 2016年 jeader. All rights reserved.
//  地图大图针

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface JDPoint : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

//标题
@property (nonatomic, copy) NSString *title;

//初始化方法
-(id)initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString *)t;

@end
