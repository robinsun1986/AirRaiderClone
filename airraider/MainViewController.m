//
//  MainViewController.m
//  airraider
//
//  Created by wilson on 8/22/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "MainViewController.h"
#import "LoadingView.h"
#import "TitleView.h"
#import "AirRaiderGameViewController.h"

@interface MainViewController ()

// loading view
@property (weak, nonatomic) LoadingView *loadingView;
// title view
@property (weak, nonatomic) TitleView *titleView;

// game view controller
@property (strong, nonatomic) AirRaiderGameViewController *gameController;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // add loading view
    LoadingView *loadingView = [[LoadingView alloc] initWithFrame:self.view.bounds];
    self.loadingView = loadingView;
    [self.view addSubview:loadingView];

    // load game resources at backend
    [self performSelectorInBackground:@selector(loadResources) withObject:nil];
}

#pragma mark - load resources at backend
- (void)loadResources
{
    // load resources
    // instantiate game view controller
    self.gameController = [[AirRaiderGameViewController alloc] init];
    [self.gameController loadResources];
    
    // remove loading view
    [self.loadingView removeFromSuperview];
    
    // display title view
    TitleView *titleView = [[TitleView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    // 4. call startgame at backend. when the resources are loaded, start game
    [self performSelectorInBackground:@selector(startGame) withObject:nil];
}

- (void)startGame
{
    // 1. remove title view after one second elapsed
    // need to give the user some time to get ready
    // "new game" "continue" "help" "settings" "ranking" "share"
    // "share" is one of the important buzz marketing approaches
    [NSThread sleepForTimeInterval:1.0f];
    [self.titleView removeFromSuperview];
    
    // 3. display game view controller
    [self.view addSubview:self.gameController.view];
}


@end







