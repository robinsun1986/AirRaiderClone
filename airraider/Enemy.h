//
//  Enemy.h
//  airraider
//
//  Created by wilson on 8/23/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kEnemySmall = 0,
    kEnemyMedium,
    kEnemyBig
} EnemyType;

@interface Enemy : NSObject

#pragma mark - factory method
// continously add enemies, e.g. 3 enemy / sec
+ (id)enemyWithType:(EnemyType)type size:(CGSize)size gameArea:(CGRect)gameArea;

#pragma mark - enemy properties
// type (small, medium, big)
@property (assign, nonatomic) EnemyType type;
// position
@property (assign, nonatomic) CGPoint position;
// health point
@property (assign, nonatomic) NSInteger hp;
// speed
@property (assign, nonatomic) NSInteger speed;
// score
@property (assign, nonatomic) NSInteger score;

// blowup flag, if true, the enemy will explode
@property (assign, nonatomic) BOOL toBlowup;
// frame count to play blowup animation
@property (assign, nonatomic) NSInteger blowupFrameCount;

@end
