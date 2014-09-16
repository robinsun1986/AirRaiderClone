//
//  Enemy.m
//  airraider
//
//  Created by wilson on 8/23/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

+ (id)enemyWithType:(EnemyType)type size:(CGSize)size gameArea:(CGRect)gameArea
{
    Enemy *e = [[Enemy alloc] init];
    
    e.type = type;
    
    // enemy appear position
    CGFloat x = arc4random_uniform(gameArea.size.width - size.width) + size.width / 2.0;
    CGFloat y = -size.height / 2.0;
    e.position = CGPointMake(x, y);
    
    // set other properties based on type
    // actual score = score times 1000
    // speed can not be 1 as the background is moving too
    switch (type) {
        case kEnemySmall:
            e.hp = 1;
            e.speed = arc4random_uniform(4) + 2;
            e.score = 1;
            break;
        case kEnemyMedium:
            e.hp = 10;
            e.speed = arc4random_uniform(3) + 2;
            e.score = 10;
            break;
        case kEnemyBig:
            e.hp = 50;
            e.speed = arc4random_uniform(2) + 2;
            e.score = 30;
            break;
    }
    
    e.toBlowup = NO;
    e.blowupFrameCount = 0;
    
    return e;
}

@end
