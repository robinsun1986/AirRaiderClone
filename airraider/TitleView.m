//
//  TitleView.m
//  airraider
//
//  Created by wilson on 8/22/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. display the background image
        UIImage *image = [UIImage imageNamed:@"images.bundle/background_2.png"];
        UIImageView *bg = [[UIImageView alloc] initWithImage:image];
        // display the whole image with streching
        bg.frame = self.frame;
        [self addSubview:bg];
        
        // 2. display the title image
        UIImage *titleImage = [UIImage imageNamed:@"images.bundle/BurstAircraftLogo.png"];
        UIImageView *titleView = [[UIImageView alloc] initWithImage:titleImage];
        titleView.center = self.center;
        [self addSubview:titleView];
    }
    return self;
}


@end
