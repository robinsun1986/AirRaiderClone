//
//  SoundTool.h
//  airraider
//
//  Created by wilson on 8/24/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundTool : NSObject

#pragma mark - play bgm
- (void)playMusic;

#pragma mark - play se by file name
- (void)playSoundByFileName:(NSString *)fileName;

@end
