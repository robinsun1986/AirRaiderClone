//
//  Bullet.m
//  airraider
//
//  Created by wilson on 8/23/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "Bullet.h"

#define kDamageNormal 1
#define kDamageEnhanced 2

@implementation Bullet

#pragma mark - factory method
+ (id)bulletWithPosition:(CGPoint)position isEnhanced:(BOOL)isEnhanced
{
    Bullet *b = [[Bullet alloc] init];
    
    b.position = position;
    b.isEnhanced = isEnhanced;
    
    b.damage = (isEnhanced ? kDamageEnhanced : kDamageNormal);
    
    return b;
}




@end
