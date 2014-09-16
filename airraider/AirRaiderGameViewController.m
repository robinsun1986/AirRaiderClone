//
//  AirRaiderGameViewController.m
//  airraider
//
//  Created by wilson on 8/22/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "AirRaiderGameViewController.h"
#import "ImageResources.h"
#import "SoundTool.h"
#import "BackgroundView.h"
#import "GameModel.h"
#import "HeroView.h"
#import "BulletView.h"
#import "EnemyView.h"

static long steps;

@interface AirRaiderGameViewController ()

// game timer
@property (strong, nonatomic) CADisplayLink *gameTimer;

// image resource cache
@property (strong, nonatomic) ImageResources *imagesRes;

// sound tool
@property (strong, nonatomic) SoundTool *soundTool;

// game model
@property (strong, nonatomic) GameModel *gameModel;

// game view
@property (weak, nonatomic) UIView *gameView;

// bg view
@property (weak, nonatomic) BackgroundView *bgView;

// hero fighter view
@property (weak, nonatomic) HeroView *heroView;

// bullet view set that stores all bullet views on the screen
@property (strong, nonatomic) NSMutableSet *bulletViewSet;

// enemy set that stores all enemy views on the screen
@property (strong, nonatomic) NSMutableSet *enemyViewSet;

// score label
@property (weak, nonatomic) UILabel *scoreLabel;

@end

@implementation AirRaiderGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // play music
    [self.soundTool playMusic];
    steps = 0;
    
    self.bulletViewSet = [NSMutableSet set];
    self.enemyViewSet = [NSMutableSet set];
    
    // 1. inistantiate game model
    CGSize heroSize = [self.imagesRes.heroFlyImages[0] size];
    self.gameModel = [GameModel gameModelWithArea:self.view.bounds heroSize:heroSize];
    self.gameModel.hero.bulletNormalSize = self.imagesRes.bulletNormalImage.size;
    self.gameModel.hero.bulletEnhancedSize = self.imagesRes.bulletEnhancedImage.size;
    
    // create game view and add all elements to this view
    UIView *gameView = [[UIView alloc] initWithFrame:self.gameModel.gameArea];
    [self.view addSubview:gameView];
    self.gameView = gameView;
    
    // add pause button and score label
    // 1) pause button
    UIButton *pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"images.bundle/BurstAircraftPause.png"];
    [pauseButton setImage:image forState:UIControlStateNormal];
    UIImage *imageHL = [UIImage imageNamed:@"images.bundle/BurstAircraftPauseHL.png"];
    [pauseButton setImage:imageHL forState:UIControlStateHighlighted];
    pauseButton.frame = CGRectMake(20, 20, image.size.width, image.size.height);
    [pauseButton addTarget:self action:@selector(tapPauseButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseButton];
    
    // 2) score label
    CGFloat labelX = pauseButton.frame.origin.x + pauseButton.frame.size.width;
    CGFloat labelY = 20;
    CGFloat labelW = self.gameModel.gameArea.size.width - labelX;
    CGFloat labelH = pauseButton.frame.size.height;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    [self.view addSubview:label];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Marker Felt" size:18];
    label.textColor = [UIColor darkGrayColor];
    self.scoreLabel = label;
    //label.text = @"1000";
    
    // 2. inistantiate bg view
    BackgroundView *bgView = [[BackgroundView alloc] initWithFrame:self.gameModel.gameArea image:self.imagesRes.bgImage];
    [self.gameView addSubview:bgView];
    self.bgView = bgView;
    
    // 3. instantiate hero view
    HeroView *heroView = [[HeroView alloc] initWithImages:self.imagesRes.heroFlyImages];
    heroView.center = self.gameModel.hero.position;
    [self.gameView addSubview:heroView];
    self.heroView = heroView;
    
    // start game timer
    [self startGameTimer];

    //self.view.backgroundColor = [UIColor redColor];
}

#pragma mark - button listener
- (void)tapPauseButton:(UIButton *)button
{
    button.tag = !button.tag;
    UIImage *image = nil;
    UIImage *imageHL = nil;
    // if game is running, switch the button status to start, stop the game timer
    if (button.tag) {
        image = [UIImage imageNamed:@"images.bundle/BurstAircraftStart.png"];
        imageHL = [UIImage imageNamed:@"images.bundle/BurstAircraftStartHL.png"];
        
        [self stopGameTimer];
    } else {
        // if game is paused, switch the button status to pause, start game timer
        image = [UIImage imageNamed:@"images.bundle/BurstAircraftPause.png"];
        imageHL = [UIImage imageNamed:@"images.bundle/BurstAircraftPauseHL.png"];
        
        [self startGameTimer];
    }
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:imageHL forState:UIControlStateHighlighted];
}

#pragma mark - touch event
#pragma mark touch move
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1. get touch object
    UITouch *touch = [touches anyObject];
    // 2. get current touch point
    CGPoint location = [touch locationInView:self.gameView];
    // 3. get previous touch point
    CGPoint preLocation = [touch previousLocationInView:self.gameView];
    // 4. work out offset
    CGPoint offset = CGPointMake(location.x - preLocation.x, location.y - preLocation.y);
    // 5. update hero location
    CGPoint position = self.gameModel.hero.position;
    self.gameModel.hero.position = CGPointMake(position.x + offset.x , position.y + offset.y);
}

#pragma mark - private method
#pragma mark timer trigger method
- (void)step
{
    steps++;
    [self.gameModel bgMoveDown];
    [self.bgView changeBGPositionWith:self.gameModel.bgFrame1 andWith:self.gameModel.bgFrame2];
    // update hero location
    self.heroView.center = self.gameModel.hero.position;
    
    // fire 3 bullets per second
    // if the hero is blowing up, stop firing
    if(steps % 20 == 0 && !self.gameModel.hero.toBlow) {
        // only bullet data, no image is added to the screen
        [self.gameModel.hero fire];
        [self.soundTool playSoundByFileName:@"bullet"];
    }
    
    // update bullet position
    [self checkBullets];
}

- (void)checkBullets {
    //NSLog(@"bullet count: %d", self.bulletViewSet.count);
    
    // buffer set to store the item to be removed
    NSMutableSet *toRemoveSet = [NSMutableSet set];
    
    // move bullet up by 5
    for (BulletView *bulletView in self.bulletViewSet) {
        CGPoint position = CGPointMake(bulletView.center.x, bulletView.center.y - 5.0);
        bulletView.center = position;
        
        // check if the bullet moves out of the screen
        if (CGRectGetMaxY(bulletView.frame) < 0) {
            [toRemoveSet addObject:bulletView];
        }
    }
    
    // traverse the toRomovedSet and remove
    for(BulletView *bulletView in toRemoveSet) {
        [bulletView removeFromSuperview];
        [self.bulletViewSet removeObject:bulletView];
    }
    [toRemoveSet removeAllObjects];
    
    // 1. add bullet view according to bullet model
    for (Bullet *bullet in self.gameModel.hero.bulletSet) {
        // create bullet view
        UIImage *image = self.imagesRes.bulletNormalImage;
        if(bullet.isEnhanced) {
            image = self.imagesRes.bulletEnhancedImage;
        } 
        BulletView *bulletView = [[BulletView alloc] initWithImage:image bullet:bullet];
        bulletView.center = bullet.position;
        [self.gameView addSubview:bulletView];
        // add into bullet view set
        [self.bulletViewSet addObject:bulletView];
    }
    // empty bullet set in hero
    [self.gameModel.hero.bulletSet removeAllObjects];
    
    // create enemies
    // create 3 small enemies per second and medium or big enemy per 10 second
    if (steps % 20 == 0) {
        // 1) create model
        Enemy *enemy = nil;
        // create one big or medium enemy per 5 second
        if (steps % (5 * 60) == 0) {
            // randomise big or medium enemy
            EnemyType type = (arc4random_uniform(2) ? kEnemyMedium :kEnemyBig);
            CGSize size = self.imagesRes.enemyMediumImage.size;
            
            if (type == kEnemyBig) {
                size = [self.imagesRes.enemyBigImages[0] size];
            }
            
            enemy = [self.gameModel createEnemyWithType:type size:size];
        } else {
            // small enemy
            enemy = [self.gameModel createEnemyWithType:kEnemySmall size:self.imagesRes.enemySmallImage.size];
        }
        
        // 2) create model
        EnemyView *enemyView = [[EnemyView alloc] initWithEnemy:enemy imageRes:self.imagesRes];
        // 3) add enemy view to set
        [self.enemyViewSet addObject:enemyView];
        [self.gameView addSubview:enemyView];
    }
    
    // update enemy positions
    [self updateEnemyPositions];
    
    // collision detection
    [self collisionDetect];
}

#pragma mark - update score label
- (void)updateScoreLabel
{
    // check score in gameModel, if 0, clear label
    if (self.gameModel.score == 0) {
        self.scoreLabel.text = @"";
    } else {
        NSString *str = [NSString stringWithFormat:@"%d000", self.gameModel.score];
        self.scoreLabel.text = str;
    }
}

#pragma mark - collision detector
- (void)collisionDetect
{
    // blowup animation plays too fast, can be adjusted by steps
    if (steps % 10 == 0) {

        // traverse enemy set and check if any enemy begin to blowup
        NSMutableSet *toRemovedSet = [NSMutableSet set];
        
        for (EnemyView *enemyView in self.enemyViewSet) {
            Enemy *enemy = enemyView.enemy;
            
            if(enemy.toBlowup) {
                enemyView.image = enemyView.blowupImages[enemy.blowupFrameCount++];
                // play blowup se
                NSString *soundFileName;
                if (enemy.type == kEnemySmall) {
                    soundFileName = @"enemy1_down";
                } else if (enemy.type == kEnemyMedium) {
                    soundFileName = @"enemy3_down";
                } else if (enemy.type == kEnemyBig) {
                    soundFileName = @"enemy2_down";
                }
                [self.soundTool playSoundByFileName:soundFileName];
            }
            
            // check if the blowup animation is completed
            if (enemy.blowupFrameCount == enemyView.blowupImages.count) {
                // need to remove from set
                [toRemovedSet addObject:enemyView];
            }
        }
        
        for(EnemyView *enemyView in toRemovedSet) {
            // 1. update score in gameModel
            self.gameModel.score += enemyView.enemy.score;
            // 2. update score label text
            [self updateScoreLabel];
            
            [self.enemyViewSet removeObject:enemyView];
            [enemyView removeFromSuperview];
        }
        [toRemovedSet removeAllObjects];
    }
    
    // buffer set to store the item to be removed
    NSMutableSet *toRemoveSet = [NSMutableSet set];
    // resources: bullets, enemies
    for(BulletView *bulletView in self.bulletViewSet) {
        Bullet *bullet = bulletView.bullet;
        
        for (EnemyView *enemyView in self.enemyViewSet) {
            Enemy *enemy = enemyView.enemy;
            
            // check if bullet and enemy collide on frames
            // if the enemy is blowing up, do not check
            if(!enemy.toBlowup && CGRectIntersectsRect(bulletView.frame, enemyView.frame)) {
                
                [toRemoveSet addObject:bulletView];
                
                // reduce enemy hp with bullet damage
                enemy.hp -= bullet.damage;
                
                if(enemy.hp <=0) {
                    enemy.toBlowup = YES;
                    // 
                } else {
                    // display hit image if hp > 0
                    // stop animation for big enemy
                    if (enemy.type == kEnemyBig) {
                        [enemyView stopAnimating];
                    }
                    
                    enemyView.image = enemyView.hitImage;
                }
            }
        }
    }
    
    // removed the consumed bullets from screen
    for (BulletView *bulletView in toRemoveSet) {
        [bulletView removeFromSuperview];
    }
    [toRemoveSet removeAllObjects];
    
    // hero and enemy collision detection
    for (EnemyView *enemyView in self.enemyViewSet) {
        if(!enemyView.enemy.toBlowup && CGRectIntersectsRect(enemyView.frame, self.gameModel.hero.collisionFrame)) {
            self.gameModel.hero.toBlow = YES;
            [self.soundTool playSoundByFileName:@"game_over"];
            
            //NSLog(@"hero is dead");
            // play hero blowup animation
            // no need for timer animation, use frame animation
            // 1) stop the current hero frame animation
            [self.heroView stopAnimating];
            // set the last image after hero blowup
            self.heroView.image = [self.imagesRes.heroBlowupImages lastObject];
            // 2) update the current hero frame animation
            self.heroView.animationImages = self.imagesRes.heroBlowupImages;
            // 3) set animation duration
            self.heroView.animationDuration = 1.0f;
            self.heroView.animationRepeatCount = 1;
            // 4) start animation
            [self.heroView startAnimating];
            // 5) stop the timer at the last play
            [self performSelector:@selector(stopGameTimer) withObject:nil afterDelay:1.0f];
            // break the loop
            break;
        }
    }
}

#pragma mark - start game timer
- (void)startGameTimer
{
    // instantiate game timer
    self.gameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    // add to main run loop
    [self.gameTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

#pragma mark - stop game timer
- (void)stopGameTimer
{
    [self.gameTimer invalidate];
}


#pragma mark - update enemy positions
- (void)updateEnemyPositions
{
    // 1. move down with speed in each frame
    for (EnemyView *enemyView in self.enemyViewSet) {
        Enemy *enemy = enemyView.enemy;
        
        // 1) update position
        enemy.position = CGPointMake(enemy.position.x, enemy.position.y + enemy.speed);
        // 2) update center
        enemyView.center = enemy.position;
    }
    
    // traverse set to remove the enemy outside the screen
    NSMutableSet *toRemoveSet = [NSMutableSet set];
    
    for (EnemyView *enemyView in self.enemyViewSet) {
        if (enemyView.frame.origin.y >= self.gameModel.gameArea.size.height) {
            [toRemoveSet addObject:enemyView];
            // play se if big enemy moves out
            if(enemyView.enemy.type == kEnemyBig) {
                [self.soundTool playSoundByFileName:@"enemy2_out"];
            }
        }
    }
    
    for (EnemyView *enemyView in toRemoveSet) {
        [self.enemyViewSet removeObject:enemyView];
        [enemyView removeFromSuperview];
    }
    [toRemoveSet removeAllObjects];
}

#pragma mark - public method
#pragma mark load image and sound resources
- (void)loadResources
{
    self.imagesRes = [[ImageResources alloc] init];
    self.soundTool = [[SoundTool alloc] init];
}

@end



















