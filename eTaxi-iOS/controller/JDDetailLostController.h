//
//  JDDetailLostController.h
//  eTaxi-iOS
//
//  Created by jeader on 16/2/27.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JDLostData;
@protocol JDDetailLostDelegate <NSObject>

-(void)getGoodsDecribe:(NSString *)describe;

@end

@interface JDDetailLostController : UIViewController
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
/**
 *  物品类型
 */
@property (weak, nonatomic) IBOutlet UILabel *goodsType;
/**
 *  发布时间
 */
@property (weak, nonatomic) IBOutlet UILabel *relTime;
/**
 *  占位符
 */
@property (weak, nonatomic) IBOutlet UILabel *addDetail;
/**
 *  textView
 */
@property (weak, nonatomic) IBOutlet UITextView *textView;
/**
 *  确认按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *sure;

/**
 *  失物ID
 */
@property (nonatomic, assign) int returnID;

/**
 *  失物信息
 */
@property (nonatomic, strong) JDLostData *dataDict;

@property (nonatomic, assign) id<JDDetailLostDelegate>delegate;

/**
 *  输入的字符串的长度
 */
@property (weak, nonatomic) IBOutlet UILabel *strLength;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewH;

@end
