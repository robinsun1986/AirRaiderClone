//
//  ImageResources.h
//  airraider
//
//  Created by wilson on 8/22/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageResources : NSObject

#pragma mark - background image
@property (strong, nonatomic) UIImage *bgImage;

#pragma mark - hero image
@property (strong, nonatomic) NSArray *heroFlyImages;
@property (strong, nonatomic) NSArray *heroBlowupImages;

#pragma mark - bullet images
// normal bullet
@property (strong, nonatomic) UIImage *bulletNormalImage;
// enhanced bullet
@property (strong, nonatomic) UIImage *bulletEnhancedImage;

#pragma mark - enemy images
// small enemy fly image
@property (strong, nonatomic) UIImage *enemySmallImage;
// small enemy blowup image
@property (strong, nonatomic) NSArray *enemySmallBlowupImages;
// medium enemy fly image
@property (strong, nonatomic) UIImage *enemyMediumImage;
// medium enemy blowup image
@property (strong, nonatomic) NSArray *enemyMediumBlowupImages;
// medium enemy hit image
@property (strong, nonatomic) UIImage *enemyMediumHitImage;
// big enemy fly image
@property (strong, nonatomic) NSArray *enemyBigImages;
// big enemy blowup image
@property (strong, nonatomic) NSArray *enemyBigBlowupImages;
// big enemy hit image
@property (strong, nonatomic) UIImage *enemyBigHitImage;

@end
