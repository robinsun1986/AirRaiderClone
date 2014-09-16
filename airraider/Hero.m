//
//  Hero.m
//  airraider
//
//  Created by wilson on 8/22/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "Hero.h"
#import "Bullet.h"

#define kFireCount 3

@implementation Hero

+ (id)heroWithSize:(CGSize)size gameArea:(CGRect)gameArea
{
    Hero *h = [[Hero alloc] init];
    
    CGFloat x = gameArea.size.width / 2;
    // leave the space for half of the hero height
    CGFloat y = gameArea.size.height - size.height;
    h.position = CGPointMake(x, y);
    h.size = size;
    
    h.bombCount = 0;
    h.isEnhancedBullet = NO;
    h.toBlow = NO;
    h.enhancedDuration = 0;
    
    // instantiate bullet set
    h.bulletSet = [NSMutableSet set];
    
    return h;
}

#pragma mark - frame for collision detection
- (CGRect)collisionFrame {
    CGFloat x = self.position.x - self.size.width / 4.0;
    CGFloat y = self.position.y - self.size.height / 2.0;
    CGFloat w = self.size.width / 2.0;
    CGFloat h = self.size.height;
    
    return CGRectMake(x, y, w, h);
}

#pragma mark - public method
- (void)fire
{
    CGSize bulletSize = self.bulletNormalSize;
    if(self.isEnhancedBullet) {
        bulletSize = self.bulletEnhancedSize;
    }
    
    CGFloat y = self.position.y - self.size.height / 2 - bulletSize.height / 2;
    CGFloat x = self.position.x;
    for (NSInteger i = 0; i < kFireCount; i++) {
        CGPoint p = CGPointMake(x, y - i * bulletSize.height * 2);
        Bullet *b = [Bullet bulletWithPosition:p isEnhanced:self.isEnhancedBullet];
        [self.bulletSet addObject:b];
    }
}

@end
