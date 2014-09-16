//
//  SoundTool.m
//  airraider
//
//  Created by wilson on 8/24/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "SoundTool.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SoundTool()

// bgm player
@property (strong, nonatomic) AVAudioPlayer *musicPlayer;
// enemy blowup
@property (assign, nonatomic) SystemSoundID enemySoundId1;

// se id maintained by dictionary
@property (strong, nonatomic) NSDictionary *soundDic;

@end

@implementation SoundTool

#pragma mark - private method
#pragma mark - load se
- (SystemSoundID)loadSoundIdWithBundle:(NSBundle *)bundle Name:(NSString *) name
{
    SystemSoundID soundId;

    NSString *path = [bundle pathForResource:name ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundId);
    
    return soundId;
}

#pragma mark - load se to dictionary
- (NSDictionary *)loadSoundsWithBundle:(NSBundle *)bundle
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    // array that stores all file names of se
    NSArray *array = @[@"bullet", @"enemy1_down", @"enemy2_down", @"enemy3_down", @"game_over"];
    // traverse array, create sound id, add to dictionary
    for (NSString *name in array) {
        SystemSoundID soundId = [self loadSoundIdWithBundle:bundle Name:name];
        dictM[name] = @(soundId);
    }
    
    return dictM;
}

#pragma mark - constructor
- (id)init
{
    self = [super init];
    if (self) {
        NSString *bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"sound.bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        NSString *path = [bundle pathForResource:@"game_music" ofType:@"mp3"];
        // fileURLWithPath: get local file
        // URLWithString: get network resource
        NSURL *url = [NSURL fileURLWithPath:path];
        self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        // set player properties
        // 1) set play indefinitely
        self.musicPlayer.numberOfLoops = -1;
        // 2) prepare to play
        [self.musicPlayer prepareToPlay];

        self.soundDic = [self loadSoundsWithBundle:bundle];
    }
    return self;
}

#pragma mark - play bgm
- (void)playMusic
{
    [self.musicPlayer play];
}

#pragma mark - play se by file name
- (void)playSoundByFileName:(NSString *)fileName
{
    SystemSoundID soundId = [self.soundDic[fileName] unsignedLongValue];
    AudioServicesPlaySystemSound(soundId);
}

@end

















