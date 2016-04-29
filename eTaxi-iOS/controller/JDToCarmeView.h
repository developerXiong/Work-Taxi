//
//  JDToCarmeView.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/8.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface JDToCarmeView : NSObject

+(UIImagePickerController *)presentToCarmeaViewInVC:(UIViewController *)Vc;

/**
 *  压缩图片
 */
+ ( UIImage *)imageWithImageSimple:( UIImage *)image scaledToSize:( CGSize )newSize;

@end
