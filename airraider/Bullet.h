//
//  Bullet.h
//  airraider
//
//  Created by wilson on 8/23/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bullet : NSObject

// 1. work out bullet position 
+ (id)bulletWithPosition:(CGPoint)position isEnhanced:(BOOL)isEnhanced;

// position
@property (assign, nonatomic) CGPoint position;
// damage
@property (assign, nonatomic) NSInteger damage;
// whether the bullet is enhanced
@property (assign, nonatomic) BOOL isEnhanced;


@end
