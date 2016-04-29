//
//  JDSoundPlayer.h
//  eTaxi-iOS
//
//  Created by jeader on 16/4/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface JDSoundPlayer : NSObject
{
    NSMutableDictionary *soundSet; // 声音设置
    NSString *path; // 配置文件路径
}

@property (nonatomic, assign) float rate; // 语速
@property (nonatomic, assign) float volume; // 音量
@property (nonatomic, assign) float pitchMultiplier; // 音调
@property (nonatomic, assign) BOOL autoPlay; // 自动播放

+(instancetype)soundPlayerInstance;

/**
 *  播报
 *
 *  @param text 播什么
 */
-(void)play:(NSString *)text;

/**
 *  恢复默认设置
 */
//-(void)setDefault;
//
///**
// *  将设置写入配置文件
// */
//-(void)writeSoundSet;

@end
