//
//  JDSoundPlayer.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/22.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDSoundPlayer.h"

static JDSoundPlayer *soundplayer=nil;

@implementation JDSoundPlayer

+(instancetype)soundPlayerInstance
{
    if (soundplayer==nil) {
        soundplayer = [[self alloc] init];
//        [soundplayer initSoundSet];
    }
    return soundplayer;
}

// 播放声音
-(void)play:(NSString *)text
{
    if (![text isEqualToString:@""]) {
        
        AVSpeechSynthesizer *player = [[AVSpeechSynthesizer alloc] init];
        AVSpeechUtterance *u = [[AVSpeechUtterance alloc] initWithString:text];
        u.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];// 设置语言
        u.volume = 1.0; // 设置音量（0.0~1.0）
        u.rate = 0.5; // 设置语速
        u.pitchMultiplier = 1.0; // 设置语调
        [player speakUtterance:u];
        
    }
}

////初始化配置
//-(void)initSoundSet
//{
//    path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"SoundSet.plist"];
//    soundSet=[NSMutableDictionary dictionaryWithContentsOfFile:path];
//    if(soundSet==nil)
//    {
//        soundSet=[NSMutableDictionary dictionary];
//        [soundplayer setDefault];
//        [soundplayer writeSoundSet];
//    }
//    else
//    {
//        self.autoPlay=[[soundSet valueForKeyPath:@"autoPlay"] boolValue];
//        self.volume=[[soundSet valueForKeyPath:@"volume"] floatValue];
//        self.rate=[[soundSet valueForKeyPath:@"rate"] floatValue];
//        self.pitchMultiplier=[[soundSet valueForKeyPath:@"pitchMultiplier"] floatValue];
//    }
//}
//
//-(void)setDefault
//{
//    self.volume = 0.7;
//    self.rate = 1.0;
//    self.pitchMultiplier = 1.0;
//}
//
//-(void)writeSoundSet
//{
//    [soundSet setValue:[NSNumber numberWithBool:self.autoPlay] forKey:@"autoPlay"];
//    [soundSet setValue:[NSNumber numberWithFloat:self.volume] forKey:@"volume"];
//    [soundSet setValue:[NSNumber numberWithFloat:self.rate] forKey:@"rate"];
//    [soundSet setValue:[NSNumber numberWithFloat:self.pitchMultiplier] forKey:@"pitchMultiplier"];
//    [soundSet writeToFile:path atomically:YES];
//}
//
@end
