//
//  MyScene.h
//  Tilt Maze
//
//  Created by Dave Butler on 01/01/2014.
//  Copyright (c) 2014 DHB Worlds. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>
#import "Level.h"

#define kUpdateInterval (1.0f / 90.0f)

@interface GameScene : SKScene

//@property (nonatomic, retain) Level* currentLevel;
@property (nonatomic) SKSpriteNode *pauseGameButton;
@property (nonatomic) SKSpriteNode *backButton;
@property (nonatomic) NSMutableArray *arrayOfBlackHoleIndexes;
@property (nonatomic) NSMutableArray *arrayOfLaserIndexes;
@property (nonatomic) NSString* completedMessageText;

/** A custom image to use behind the map tiles. The default behavior is to show the default `backgroundView` and not a static image. */
- (void)setBackgroundImage:(UIImage *)backgroundImage;

-(void) loadLevel;

@end
