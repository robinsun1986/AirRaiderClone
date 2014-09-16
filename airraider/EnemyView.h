//
//  EnemyView.h
//  airraider
//
//  Created by wilson on 8/23/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageResources.h"
#import "Enemy.h"

@interface EnemyView : UIImageView

// blowup images
@property (strong, nonatomic) NSArray *blowupImages;
// hit image
@property (strong, nonatomic) UIImage *hitImage;
// enemy model
@property (strong, nonatomic) Enemy *enemy;


// 1. enemy size varies
// 2. enemy has single image and animation images
// 3. enemy has image for being hit
// 4. enemy has blowup images
- (id)initWithEnemy:(Enemy *)enemy imageRes:(ImageResources *)imageRes;

@end
