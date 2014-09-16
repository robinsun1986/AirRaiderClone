//
//  BackgroundView.m
//  airraider
//
//  Created by wilson on 8/22/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "BackgroundView.h"

@interface BackgroundView()

@property (weak, nonatomic) UIImageView *bg1;
@property (weak, nonatomic) UIImageView *bg2;

@end

@implementation BackgroundView

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    
    if(self) {
        // instantiate image
        UIImageView *bg1 = [[UIImageView alloc] initWithImage:image];
        [self addSubview:bg1];
        self.bg1 = bg1;
        
        UIImageView *bg2 = [[UIImageView alloc] initWithImage:image];
        [self addSubview:bg2];
        self.bg2 = bg2;
    }
    
    return self;
}

#pragma mark - update bg image position
- (void)changeBGPositionWith:(CGRect)frame1 andWith:(CGRect)frame2;
{
    self.bg1.frame = frame1;
    self.bg2.frame = frame2;
}

@end
