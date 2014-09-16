//
//  BackgroundView.h
//  airraider
//
//  Created by wilson on 8/22/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgroundView : UIView

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image;

#pragma mark - update bg image position
- (void)changeBGPositionWith:(CGRect)frame1 andWith:(CGRect)frame2;

@end
