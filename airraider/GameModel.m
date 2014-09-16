//
//  GameModel.m
//  airraider
//
//  Created by wilson on 8/22/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "GameModel.h"

@implementation GameModel

#pragma mark - factory method
+ (id)gameModelWithArea:(CGRect)gameArea heroSize:(CGSize)heroSize
{
    GameModel *m = [[GameModel alloc] init];
    m.gameArea = gameArea;
    // background image frame
    m.bgFrame1 = gameArea;
    m.bgFrame2 = CGRectOffset(gameArea, 0, -gameArea.size.height);
    
    // hero (single and unique, can be extended using factory method)
    m.hero = [Hero heroWithSize:heroSize gameArea:gameArea];
    
    m.score = 0;
    
    return m;
}

- (void)bgMoveDown
{
    // two bg images move down by 1
    self.bgFrame1 = CGRectOffset(self.bgFrame1, 0, 1);
    self.bgFrame2 = CGRectOffset(self.bgFrame2, 0, 1);
    
    // if bg image moves out of the bottom of the screen(game area),
    // put it on the top of the game area
    CGRect topFrame = CGRectOffset(self.gameArea, 0, -self.gameArea.size.height);
    
    if (self.bgFrame1.origin.y >= self.gameArea.size.height) {
        self.bgFrame1 = topFrame;
    }
    if (self.bgFrame2.origin.y >= self.gameArea.size.height) {
        self.bgFrame2 = topFrame;
    }
}

- (Enemy *)createEnemyWithType:(EnemyType)type size:(CGSize)size
{
    Enemy *enemy = [Enemy enemyWithType:type size:size gameArea:self.gameArea];
    return enemy;
}

@end







