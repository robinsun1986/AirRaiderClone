//
//  Hero.h
//  airraider
//
//  Created by wilson on 8/22/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero : NSObject

#pragma mark - factory method
// work out the position where a hero should appear with its size and game area
+ (id)heroWithSize:(CGSize)size gameArea:(CGRect)gameArea;

// position(center)
@property (assign, nonatomic) CGPoint position;
// size
@property (assign, nonatomic) CGSize size;

// frame for collision detection
@property (assign, nonatomic, readonly) CGRect collisionFrame;

// bomb count
@property (assign, nonatomic) NSInteger bombCount;
// enhanced bullet
@property (assign, nonatomic) BOOL isEnhancedBullet;
// duration for enhanced bullet
@property (assign, nonatomic) NSInteger enhancedDuration;
// whether is blowing up
@property (assign, nonatomic) BOOL toBlow;

#pragma mark - bullet properties
// normal bullet size
@property (assign, nonatomic) CGSize bulletNormalSize;
// enhanced bullet size
@property (assign, nonatomic) CGSize bulletEnhancedSize;
// bullet set (unordered)
@property (strong, nonatomic) NSMutableSet *bulletSet;

#pragma mark - public method
#pragma mark fire
- (void)fire;

@end
