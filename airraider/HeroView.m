//
//  HeroView.m
//  airraider
//
//  Created by wilson on 8/22/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "HeroView.h"

@implementation HeroView

- (id)initWithImages:(NSArray *)images
{
    if (self = [super initWithImage:images[0]]) {
        self.animationImages = images;
        self.animationDuration = 1.0;
        [self startAnimating];
    }
    
    return self;
}

@end
