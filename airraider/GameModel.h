//
//  GameModel.h
//  airraider
//
//  Created by wilson on 8/22/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hero.h"
#import "Enemy.h"

@interface GameModel : NSObject

#pragma mark - factory method
+ (id)gameModelWithArea:(CGRect)gameArea heroSize:(CGSize)heroSize;

#pragma mark - game area
@property (assign, nonatomic) CGRect gameArea;

#pragma mark - game score
@property (assign, nonatomic) NSInteger score;

#pragma mark - position and method of bg image
@property (assign, nonatomic) CGRect bgFrame1;
@property (assign, nonatomic) CGRect bgFrame2;

#pragma mark - public method
#pragma mark - move down the bg image
- (void)bgMoveDown;

#pragma mark - properties and methods of hero

@property (strong, nonatomic) Hero *hero;

#pragma mark - create enemy
// enemy and bullet are different. 3 bullets are fired one time while enemy only once
- (Enemy *)createEnemyWithType:(EnemyType)type size:(CGSize)size;

@end
