//
//  MyData.h
//  E+TAXI
//
//  Created by jeader on 15/12/26.
//  Copyright © 2015年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief 集发送请求和解析数据功能为一起的请求类
 */

@interface MyData : NSObject


//获取个人信息
@property (strong, nonatomic) NSString * driverStatus;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * avataraUrl;
@property (strong, nonatomic) NSString * serviceNo;
@property (strong, nonatomic) NSString * taxiCompany;
@property (strong, nonatomic) NSString * plateNo;
@property (strong, nonatomic) NSString * engineNo;
@property (strong, nonatomic) NSString * miles;
@property (strong, nonatomic) NSString * pushNo;
@property (strong, nonatomic) NSMutableArray * contents;


//获取积分管理
@property (strong, nonatomic) NSString * scoreLeft;
@property (strong, nonatomic) NSString * datetime;
@property (strong, nonatomic) NSString * score;
@property (strong, nonatomic) NSString * goods;
@property (strong, nonatomic) NSString * number;
@property (strong, nonatomic) NSString * address;
@property (strong, nonatomic) NSString * in_datetime;
@property (strong, nonatomic) NSString * in_score;
@property (strong, nonatomic) NSString * in_name;
@property (strong, nonatomic) NSString * imageUrl;


//获取违章查询信息
@property (strong, nonatomic) NSString * pecc_status;
@property (strong, nonatomic) NSString * pecc_totalPoint;
@property (strong, nonatomic) NSString * pecc_totalMoney;
@property (strong, nonatomic) NSString * pecc_count;
@property (strong, nonatomic) NSString * pecc_handle;
@property (strong, nonatomic) NSString * pecc_point;
@property (strong, nonatomic) NSString * pecc_officer;
@property (strong, nonatomic) NSString * pecc_money;
@property (strong, nonatomic) NSString * pecc_info;
@property (strong, nonatomic) NSString * pecc_date;
@property (strong, nonatomic) NSString * pecc_address;
@property (strong, nonatomic) NSString * pecc_provinceName;
@property (strong, nonatomic) NSString * pecc_cityName;


//获取预约信息
@property (strong, nonatomic) NSString * addressName;
@property (strong, nonatomic) NSString * dateStart;
@property (strong, nonatomic) NSString * startTime;
@property (strong, nonatomic) NSString * optionName;
@property (strong, nonatomic) NSString * addressId;
@property (strong, nonatomic) NSString * optioinTel;
@property id delFlg;
@property (strong, nonatomic) NSString * wholeTime;

/**
 *  个人信息数据返回
 *
 *  @param block 返回代码的block
 */
+(void)getPersonInfoWithCompletion:(void(^)(NSString * returnCode,NSString * msg,NSMutableDictionary * dic))block;

///**
// *  手动登陆
// */
//+(void)

/**
 *  积分查询数据返回
 *
 *  @param begin 设置查询的开始时间
 *  @param over  设置查询的截止时间
 *  @param block 返回代码的block
 */
+(void)getScoreInfoWithBeginDate:(NSString *)begin WithOverDate:(NSString *)over withType:(NSString *)type Completion:(void(^)(NSString * returnCode,NSString * msg,NSMutableDictionary * dic))block;

/**
 *  登陆
 *
 *  @param phone 登陆时使用的手机号
 *  @param psw   登陆时使用的密码
 *  @param block 返回代码的block
 */
-(void)goLoginWithloginWithPhoneNo:(NSString *)phone WithPsw:(NSString *)psw withPostType:(NSString *)type withManual:(NSString *)manual withMiles:(NSString *)miles withCompletion:(void(^)(NSString * returnCode,NSString * msg,NSString * checkFlg,NSInteger role))block;

/**
 *  获取验证码接口
 *
 *  @param phone 验证使用的手机号
 *  @param block 返回代码
 */
- (void)getconfirmCodeWithPhoneNo:(NSString *)newphone WithType:(NSString *)type WithCompletion:(void(^)(NSString * returnCode,NSString * number,NSString * msg))block;

/**
 *  获取找回密码的接口
 *
 *  @param phone    用户的手机号码
 *  @param password 用户的密码
 *  @param block    返回代码的block
 */
- (void)getFindNewPasswordWithPhoneNo:(NSString *)phone WithNewPassword:(NSString *)password WithCompletion:(void(^)(NSString * returnCode,NSString * msg))block;

/**
 *  获取修改密码接口
 *
 *  @param phone    用户的手机号码
 *  @param password 用户的原密码
 *  @param newP     用户的新密码
 *  @param block    返回代码的block
 */
- (void)getChangeNewPasswordWithPhoneNo:(NSString * )phone WithPassword:(NSString *)password WithNewPassword:(NSString *)newP WithCompletion:(void(^)(NSString * returnCode,NSString *msg))block;

/**
 *  获取查询违章信息接口
 *
 *  @param phone    用户的手机号
 *  @param password 用户的密码
 *  @param plate    车牌号
 *  @param engineNo 发动机后六位
 *  @param block    返回代码的block
 */
- (void)getPeccWithPhoneNo:(NSString *)phone WithPassword:(NSString *)password WithPlateNo:(NSString *)plate WithEngineNo:(NSString *)engineNo WithCompletion:(void(^)(NSString * returnCode,NSString * msg,NSMutableDictionary * dic))block;

/**
 *  获取设置界面接口
 *
 *  @param income 营收统计推送的开关
 *  @param breakR 违章查询推送的开关
 *  @param time   营收统计推送的时间
 *  @param block  返回代码的block
 */
- (void)getSetWithIncomeSwitch:(NSString *)income WithBreakRulesSwitch:(NSString *)breakR WithIncomeTime:(NSString *)time WithCompletion:(void(^)(NSString * str,NSString * msg))block;

/**
 *  上传个人信息(三种照片)
 *
 *  @param image 存储三种照片您的字典
 *  @param block 返回代码的block
 */
- (void)getEditPersonInfoWithCompletion:(void(^)(NSString * str,NSString * msg))block;

/**
 *  更换手机号码
 *
 *  @param phone  原来的手机号码
 *  @param nPhone 新的手机号码
 *  @param type   上传的接口的类型
 *  @param block  返回代码的block
 */
- (void)getChangeNewPhoneWithPhoneNo:(NSString *)phone WithNewPhoneNo:(NSString *)nPhone WithType:(NSString *)type WithCompletionBlock:(void(^)(NSString * returnCode,NSString * msg))block;

/**
 *  查询预约信息
 *
 *  @param block 返回代码的block
 */
- (void)getOrderTableWithType:(NSString *)type withCompletionBlock:(void(^)(NSMutableDictionary * dict,NSString * returnCode,NSString * msg))block;

/**
 *  取消预约
 *
 *  @param block 返回代码的block
 */
- (void)getCancelOrderWithOptionID:(NSString *)optionID withType:(NSString *)type withCompletionBlock:(void(^)(NSString * returnCode,NSString * msg))block;

/**
 *  违章积分处理的接口
 *
 *  @param point     处理所需的积分
 *  @param violation 处理的违章记录
 */
- (void)getSubmitePeccInfoWithSpendPoint:(NSString *)point withViolations:(NSMutableString *)violation withCompletionBlock:(void(^)(NSString * returnCode,NSString * msg))block;

@end
