//
//  JDGoodsTools.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/27.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDGoodsTools.h"

#import "JDTopLayerWindow.h"

#import "UMSocial.h"

//分享的标题
#define ShareTitle @"加入E+taxi服务体验计划"
//分享的文字
#define ShareContent @"车辆保养一建预约，免费机油先到先得！海量特权尽在E+taxi！"
//分享的图片
#define ShareImage [UIImage imageNamed:@"LOGO_ET"]
//分享的url地址
#define ShareURL @"http://itunes.apple.com/cn/app/id1087312070?mt=8"
//短信分享的内容
#define ShareSnsContent @"加入E+taxi服务体验计划，车辆保养一建预约，免费机油先到先得！海量特权尽在E+taxi！http://itunes.apple.com/cn/app/id1087312070?mt=8"

@implementation JDGoodsTools

+(void)shareUMInVc:(UIViewController *)VC
{
    [[JDTopLayerWindow sharedInstance] show];
    
    [[JDTopLayerWindow sharedInstance]shareDuanxin:^{
        
        [[JDTopLayerWindow sharedInstance] hidden];
        
        NSMutableString *title = [NSMutableString string];
        [title appendFormat:@"%@,%@,%@",ShareTitle,ShareContent,ShareURL];
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSms] content:ShareSnsContent image:nil location:nil urlResource:nil presentedController:VC completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                //            NSLog(@"分享成功！");
            }
        }];
        
        
    } Wechat:^{
        
        [[JDTopLayerWindow sharedInstance] hidden];
        
        [UMSocialData defaultData].extConfig.title = ShareTitle;
        [UMSocialData defaultData].extConfig.wechatSessionData.url = ShareURL;
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:ShareContent image:ShareImage location:nil urlResource:nil presentedController:VC completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                //            NSLog(@"分享成功！");
            }
        }];
        
        
        
        
    } QQ:^{
        
        [[JDTopLayerWindow sharedInstance] hidden];
        
        [UMSocialData defaultData].extConfig.title = ShareTitle;
        [UMSocialData defaultData].extConfig.qqData.url = ShareURL;
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:ShareContent image:ShareImage location:nil urlResource:nil presentedController:VC completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                //            NSLog(@"分享成功！");
            }
        }];
        
        
    }];
}

@end
