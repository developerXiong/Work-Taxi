//
//  JDToCarmeView.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/8.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDToCarmeView.h"
#import "HeadFile.pch"

@interface JDToCarmeView ()

@end

@implementation JDToCarmeView

+(UIImagePickerController *)presentToCarmeaViewInVC:(UIViewController *)Vc
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    if (TARGET_IPHONE_SIMULATOR) {
        //            NSLog(@"模拟器");
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//            picker.delegate = self;//设置代理
            picker.editing = NO;//是否为可编辑状态
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//选择获取图片的途径
            [Vc presentViewController:picker animated:NO completion:^{
                
            }];
        }
        
    }else if(TARGET_OS_IPHONE){
        //            NSLog(@"真机");
        
        //    打开摄像头
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            
//            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//            picker.delegate = self;
            picker.allowsEditing = NO;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            //                NSLog(@"overlayView----%@",picker.cameraOverlayView.subviews);
            picker.cameraOverlayView.hidden = YES;
            
            /**
             * 上方的阴影部分
             */
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, JDScreenSize.width, 60)];
            [picker.view addSubview:label];
            label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
            /**
             * 上方白色线条
             */
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 59.5, JDScreenSize.width, 0.5)];
            [label addSubview:line];
            line.backgroundColor = [UIColor whiteColor];
            
            /**
             * 下方的阴影部分
             */
            CGFloat height = 65;
            
            CGFloat margin = 70;
            
            if (JDScreenSize.width == 375) { //6 6s
                
                height = 85;
                
                margin = 82;
                
            }
            
            if (JDScreenSize.width==414&&JDScreenSize.height==736) {
                
                height = 100;
                margin = 90;
                
            }
            
            CGFloat shadowY = JDScreenSize.height-height-margin;
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, shadowY, JDScreenSize.width, height)];
            [picker.view addSubview:label1];
            label1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
            /**
             * 下方白色线条
             */
            UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, 0.5)];
            [label1 addSubview:line1];
            line1.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.75];
            
            /**
             * 标注
             */
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, shadowY+3, JDScreenSize.width, 30)];
            [picker.view addSubview:label2];
            label2.textColor = [UIColor whiteColor];
            label2.text = @"拍照时请将物品置入框内";
            label2.textAlignment = NSTextAlignmentCenter;
            label2.font = [UIFont systemFontOfSize:15];
            
            [Vc presentViewController:picker animated:NO completion:nil];
            
        }else{
            
            [GetData addAlertViewInView:Vc title:@"温馨提示" message:@"你没有摄像头" count:0 doWhat:^{
                
            }];
        }
    }
    
    return picker;

}

/**
 *  压缩图片
 *
 *  @param image   要压缩的图片
 *  @param newSize 要压缩到多大
 *
 *  @return 压缩好的图片
 */
+ ( UIImage *)imageWithImageSimple:( UIImage *)image scaledToSize:( CGSize )newSize

{
    
    // Create a graphics image context
    
    UIGraphicsBeginImageContext (newSize);
    
    // Tell the old image to draw in this new context, with the desired
    
    // new size
    
    [image drawInRect : CGRectMake ( 0 , 0 ,newSize. width ,newSize. height )];
    
    // Get the new image from the context
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext ();
    
    // End the context
    
    UIGraphicsEndImageContext ();
    
    // Return the new image.
    
    return newImage;
    
}

@end
