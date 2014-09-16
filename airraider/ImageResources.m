//
//  ImageResources.m
//  airraider
//
//  Created by wilson on 8/22/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "ImageResources.h"

@implementation ImageResources

#pragma mark - private method
#pragma mark load images from specified bundle
- (UIImage *)loadImageWithBundle:(NSBundle *)bundle imageName:(NSString *)imageName
{
    NSString *path = [bundle pathForResource:imageName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:path];
}

#pragma mark load images from specified bundle
- (NSArray *)loadImagesWithBundle:(NSBundle *)bundle format:(NSString *)format count:(NSInteger)count
{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    for(NSInteger i=1; i<=count; i++) {
        NSString *imageName = [NSString stringWithFormat:format, i];
        UIImage *image = [self loadImageWithBundle:bundle imageName:imageName];
        [arrayM addObject:image];
    }
    
    return arrayM;
}

- (id)init {
    if (self = [super init]) {
        // load image resource
        // in game dev, the image resources used in game view should not use cache
        // ex. do not use [UIImage imageNamed]
        NSString *bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"images.bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        self.bgImage = [self loadImageWithBundle:bundle imageName:@"background_2"];
        // load hero fly images
        self.heroFlyImages = [self loadImagesWithBundle:bundle format:@"hero_fly_%d" count:2];
        // load hero blowup images
        self.heroBlowupImages = [self loadImagesWithBundle:bundle format:@"hero_blowup_%d" count:4];
        
//        self.bgImage = [UIImage imageNamed:@"images.bundle/background_2.png"];
        // 4. bullet image
        self.bulletNormalImage = [self loadImageWithBundle:bundle imageName:@"bullet1"];
        self.bulletEnhancedImage = [self loadImageWithBundle:bundle imageName:@"bullet2"];
        
        // 5. small enemy
        self.enemySmallImage = [self loadImageWithBundle:bundle imageName:@"enemy1_fly_1"];
        self.enemySmallBlowupImages = [self loadImagesWithBundle:bundle format:@"enemy1_blowup_%d" count:4];
        // 6. medium enemy
        self.enemyMediumImage = [self loadImageWithBundle:bundle imageName:@"enemy3_fly_1"];
        self.enemyMediumHitImage = [self loadImageWithBundle:bundle imageName:@"enemy3_hit_1"];
        self.enemyMediumBlowupImages = [self loadImagesWithBundle:bundle format:@"enemy3_blowup_%d" count:4];
        // 7. big enemy
        self.enemyBigImages = [self loadImagesWithBundle:bundle format:@"enemy2_fly_%d" count:2];
        self.enemyBigHitImage = [self loadImageWithBundle:bundle imageName:@"enemy2_hit_1"];
        self.enemyBigBlowupImages = [self loadImagesWithBundle:bundle format:@"enemy2_blowup_%d" count:7];
    }
    
    return self;
}

@end









