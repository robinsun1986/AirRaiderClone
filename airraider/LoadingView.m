//
//  LoadingView.m
//  airraider
//
//  Created by wilson on 8/22/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. load 4 images
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:4];
        
        for (NSInteger i=0; i<4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"images.bundle/loading%d.png", i];
            UIImage *image = [UIImage imageNamed:imageName];
            
            [arrayM addObject:image];
        }
        
        // 2. create image view
        UIImageView *imageView = [[UIImageView alloc] initWithImage:arrayM[0]];
        // 3. put UIImageView in the center of the screen
        imageView.center = self.center;
        [self addSubview:imageView];
        
        // 4. play frame animation
        // 4.1 create frame animation array
        imageView.animationImages = arrayM;
        // 4.2 create frame animation duration
        imageView.animationDuration = 1.0f;
        // 4.3 start animation
        [imageView startAnimating];
        
    }
    return self;
}


@end
