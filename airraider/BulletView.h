//
//  BulletView.h
//  airraider
//
//  Created by wilson on 8/23/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bullet.h"

@interface BulletView : UIImageView

// bullet model
@property (strong, nonatomic) Bullet *bullet;

- (id)initWithImage:(UIImage *)image bullet:(Bullet *)bullet;

@end
