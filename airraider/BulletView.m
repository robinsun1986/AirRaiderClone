//
//  BulletView.m
//  airraider
//
//  Created by wilson on 8/23/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "BulletView.h"

@implementation BulletView

- (id)initWithImage:(UIImage *)image bullet:(Bullet *)bullet
{
    if (self = [super initWithImage:image]) {
        self.bullet = bullet;
    }
    
    return self;
}

@end
