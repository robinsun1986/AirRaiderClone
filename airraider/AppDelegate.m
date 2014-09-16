//
//  AppDelegate.m
//  airraider
//
//  Created by wilson on 8/22/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
    MainViewController *mainVC = [[MainViewController alloc] init];
    self.window.rootViewController = mainVC;
    [self.window makeKeyAndVisible];
    return YES;
}



@end
