//
//  EnemyView.m
//  airraider
//
//  Created by wilson on 8/23/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "EnemyView.h"

@implementation EnemyView

- (id)initWithEnemy:(Enemy *)enemy imageRes:(ImageResources *)imageRes
{
    if (self = [super init]) {
        self.enemy = enemy;
        
        switch (self.enemy.type) {
            case kEnemySmall:
                self.image = imageRes.enemySmallImage;
                self.blowupImages = imageRes.enemySmallBlowupImages;
                break;
            case kEnemyMedium:
                self.image = imageRes.enemyMediumImage;
                self.blowupImages = imageRes.enemyMediumBlowupImages;
                self.hitImage = imageRes.enemyMediumHitImage;
                break;
            case kEnemyBig:
                self.image = imageRes.enemyBigImages[0];
                // big enemy has animation images
                self.animationImages = imageRes.enemyBigImages;
                self.animationDuration = 0.5f;
                [self startAnimating];
                self.blowupImages = imageRes.enemyBigBlowupImages;
                self.hitImage = imageRes.enemyBigHitImage;
                break;
        }
        
        // set frame and center
        self.frame = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
        self.center = enemy.position;
    }
    
    return self;
}

@end
