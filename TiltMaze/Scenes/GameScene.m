//
//  MyScene.m
//  Tilt Maze
//
//  Created by Dave Butler on 01/01/2014.
//  Copyright (c) 2014 DHB Worlds. All rights reserved.
//

#import "GameScene.h"
#import "Map.h"
#import "SpriteCategories.h"
#import "Hole.h"
#import "BlackHole.h"
#import "PinballBumper.h"
#import "Button.h"
#import "Laser.h"
#import "FileUtil.h"
#import "ScaleUtil.h"
#import "AppDelegate.h"

@import AVFoundation;

@interface GameScene() <SKPhysicsContactDelegate>
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) SKNode *world;
@property (nonatomic) Map *map;
@property (nonatomic) SKSpriteNode *background;
@property (nonatomic) SKSpriteNode *exit;
@property (nonatomic) SKTextureAtlas *spriteAtlas;
@property (nonatomic) SKSpriteNode *player;
@property (strong) CMMotionManager* motionManager;
@property (assign, nonatomic) CGFloat angle;
@property (assign, nonatomic) CFTimeInterval timeSinceLast;
@property (nonatomic) SKTextureAtlas *bumperAtlas;
@property (nonatomic) SKNode *holeLayer;

@end


@implementation GameScene

#pragma mark -
#pragma mark Load / Setup Screen
- (id)initWithSize:(CGSize)size
{
    if (( self = [super initWithSize:size] ))
    {
    
        self.scaleMode = SKSceneScaleModeAspectFit;
        self.backgroundColor = [UIColor clearColor];
        
        self.background = [SKSpriteNode spriteNodeWithImageNamed:@"woodBackground@2x"];
        self.background.blendMode = SKBlendModeReplace;
    
    
    
        //background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        //NSLog(@"WIDTH=%f HEIGHT=%f", self.frame.size.width, self.frame.size.height);
    
        //Set Background Center Pt
        self.background.position = [ScaleUtil getGameSceneCenterPoint: self.frame];
    
        //self.background.position = CGPointMake(0, 0);
        self.background.name = @"background";
    
        [self addChild:self.background];
    
        // Add a node for the world - this is where sprites and tiles are added
        self.world = [SKNode node];

        self.world.position = [ScaleUtil positionGameScene];

        // Load the atlas that contains the sprites
        self.spriteAtlas = [SKTextureAtlas atlasNamed:@"sprites"];
    }


    return self;
}

-(void) loadLevel
{
    // Create a new map
    self.map = [[Map alloc] initWithGridSize:CGSizeMake(20, 30)];
    //self.map.selectedLevel = self.currentLevel;
    
    self.view.backgroundColor= [UIColor whiteColor];

    [self.map generate];

    // Create the exit
    self.exit = [SKSpriteNode spriteNodeWithTexture:[self.spriteAtlas textureNamed:@"exit"]];
    self.exit.blendMode = SKBlendModeReplace;
    self.exit.position = self.map.exitPoint;
    self.exit.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.exit.texture.size.width - 16, self.exit.texture.size.height - 16)];
    self.exit.physicsBody.categoryBitMask = CollisionTypeExit;
    self.exit.physicsBody.collisionBitMask = 0;
    
    // Create a player node
    self.player = [SKSpriteNode spriteNodeWithTexture:[self.spriteAtlas textureNamed:@"GreyOrb"]];
    self.player.position = self.map.spawnPoint;

    [self.player.physicsBody setAllowsRotation: NO];
    self.player.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:  15];
    self.player.physicsBody.categoryBitMask = CollisionTypePlayer;
    self.player.physicsBody.contactTestBitMask = CollisionTypeExit | CollisionTypeHole | CollisionTypeWall | CollisionTypePinballBumper  | CollisionTypeBlackHole  | CollisionTypeLaser  | CollisionTypeButton;
    self.player.physicsBody.collisionBitMask = CollisionTypeWall | CollisionTypePinballBumper;
    self.player.physicsBody.mass=.05;
    self.player.physicsBody.usesPreciseCollisionDetection=YES;
    //2
    self.player.physicsBody.dynamic = YES;
    //3
    self.player.physicsBody.affectedByGravity = NO;
    //4

    _holeLayer = [SKNode node];

    FileUtil* fu = [[FileUtil alloc] init];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];

    Level* level = [appDelegate levelFromLevelSetIndex:appDelegate.currentLevelSetIndex levelIndex:appDelegate.currentLevelIndex];

    NSString* mapText = [fu getFileContents: level.fileName];

    // grab level file
    NSMutableArray *data = [[mapText componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]] mutableCopy];
    // Then mark anything that is not a wall as a Floor
    for (int y = 0; y < [data count]; y++)
    {
        NSString* row = (NSString*) data[y];
    
        for (int x = 0; x < [row length]; x++)
        {
            unichar chr = [row characterAtIndex:x];
        
            //HOLD
            if (chr=='O')
            {
                [self createHoleFromX: x andY: y];
            }
        
            //PINBALLBUMPER
            if (chr=='P')
            {
                [self createPinballBumperFromX: x andY: y];
            }

            //BLACKHOLE
            if (chr=='B')
            {
                [self createBlackHoleFromX: x andY: y];
            }


            // BUTTONS
            // Green Button
            if (chr=='g')
            {
                [self createButtonFromX: x andY: y withColor: ButtonColorGreen];
            }

            // Blue Button
            if (chr=='b')
            {
                [self createButtonFromX: x andY: y withColor: ButtonColorBlue];
            }

            // Red Button
            if (chr=='r')
            {
                [self createButtonFromX: x andY: y withColor: ButtonColorRed];
            }

            //LASER
            //Laser On Off Vert
            if (chr=='|')
            {
                [self createLaserFromX: x andY: y withLaserType: LaserTypeOnOff withOrientation: LaserOrientationVertical withColor: LaserColorOrange];
            }
            //Laser On Off Horizontal
            if (chr=='-')
            {
                [self createLaserFromX: x andY: y withLaserType: LaserTypeOnOff withOrientation: LaserOrientationHorizontal withColor: LaserColorOrange];
            }
            //Laser Moving Vert
            if (chr=='!')
            {
                [self createLaserFromX: x andY: y withLaserType: LaserTypeMoving withOrientation: LaserOrientationVertical withColor: LaserColorPurple];
            }
            //Laser Moving Horizontal
            if (chr=='=')
            {
                [self createLaserFromX: x andY: y withLaserType: LaserTypeMoving withOrientation: LaserOrientationHorizontal withColor: LaserColorPurple];
            }

            //Laser Blue With Button Vert
            if (chr=='l')
            {
                [self createLaserFromX: x andY: y withLaserType: LaserTypeButtonOnOff withOrientation: LaserOrientationVertical withColor: LaserColorBlue];
            }
            //Laser Blue With Button Horizontal
            if (chr=='~')
            {
                [self createLaserFromX: x andY: y withLaserType: LaserTypeButtonOnOff withOrientation: LaserOrientationHorizontal withColor: LaserColorBlue];
            }

            //Laser Green With Button Vert
            if (chr=='[')
            {
                [self createLaserFromX: x andY: y withLaserType: LaserTypeButtonOnOff withOrientation: LaserOrientationVertical withColor: LaserColorGreen];
            }
            //Laser Green With Button Horizontal
            if (chr=='_')
            {
                [self createLaserFromX: x andY: y withLaserType: LaserTypeButtonOnOff withOrientation: LaserOrientationHorizontal withColor: LaserColorGreen];
            }

            //Laser Red With Button Vert
            if (chr==']')
            {
                [self createLaserFromX: x andY: y withLaserType: LaserTypeButtonOnOff withOrientation: LaserOrientationVertical withColor: LaserColorRed];
            }
            //Laser Red With Button Horizontal
            if (chr=='`')
            {
                [self createLaserFromX: x andY: y withLaserType: LaserTypeButtonOnOff withOrientation: LaserOrientationHorizontal withColor: LaserColorRed];
            }
        }
    }

    
    [self.world addChild:self.map];
    [self.world addChild:self.exit];
    [self.world addChild:self.player];
    [self.world addChild:_holeLayer];


    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.backButton = [SKSpriteNode spriteNodeWithTexture:[self.spriteAtlas textureNamed:@"BackSlim"]];
    } else {
        if(IS_WIDESCREEN)
        {
            self.backButton = [SKSpriteNode spriteNodeWithTexture:[self.spriteAtlas textureNamed:@"BackBig2"]];
        } else
        {
            self.backButton = [SKSpriteNode spriteNodeWithTexture:[self.spriteAtlas textureNamed:@"backSmall"]];
        }
    }

    self.backButton.position = [ScaleUtil positionGameSceneBackButton: self.background.position];
    self.backButton.name = @"backButton";
    [self.world addChild: self.backButton];


    
    // Add the world and hud nodes to the scene
    [self addChild:self.world];
    //[self addChild:self.hud];
    
    // Initialize physics
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;

    self.motionManager = [[CMMotionManager alloc] init];
    [self.motionManager startAccelerometerUpdates];
    //[self.motionManager startDeviceMotionUpdates];
    //[self.motionManager setShowsDeviceMovementDisplay:YES];
    
    self.arrayOfBlackHoleIndexes = [[NSMutableArray alloc] init];
    self.arrayOfLaserIndexes = [[NSMutableArray alloc] init];
    
    
    //DHB LOADED ARRAYS OF THE OBJECTS I WILL NEED TO SEARCH FOR IN THE UPDATE METHOD BECAUSE Call the isKindOfClass
    // Class i  the update loop was dropping the FPS by 20+.  Preloading this had much better performance
    NSUInteger worldChildren = [self.world.children count] ;
    
    for ( NSInteger i = 0; i < worldChildren; i++ )
    {
        // Is this a BlackHole???
        if([[self.world.children objectAtIndex:i] isKindOfClass: [BlackHole class]])
        {
            [self.arrayOfBlackHoleIndexes addObject: [NSNumber numberWithInt: (int) i]];
        }
    
        if([[self.world.children objectAtIndex:i] isKindOfClass: [Laser class]])
        {
            [self.arrayOfLaserIndexes addObject: [NSNumber numberWithInt: (int) i]];
        }
    }

}


#pragma mark -
#pragma mark create Sprites
-(void)createHoleFromX:(CGFloat)xPos andY:(CGFloat)yPos
{
    Hole *hole = [Hole initWithSpriteImageName:@"hole"];
    hole.position = [self.map convertMapCoordinateToWorldCoordinate: CGPointMake(xPos, yPos)];

    [self.world addChild: hole];
}

-(void)createPinballBumperFromX:(CGFloat)xPos andY:(CGFloat)yPos
{
    PinballBumper *pinballBumper = [PinballBumper initWithSpriteImageName:@"PinballBumper"];
    pinballBumper.position = [self.map convertMapCoordinateToWorldCoordinate: CGPointMake(xPos, yPos)];

    [self.world addChild: pinballBumper];
}

-(void)createBlackHoleFromX:(CGFloat)xPos andY:(CGFloat)yPos
{
    BlackHole *hole = [BlackHole initWithSpriteImageName:@"BlackHole"];
    hole.position = [self.map convertMapCoordinateToWorldCoordinate: CGPointMake(xPos, yPos)];

    [self.world addChild: hole];
}

-(void)createLaserFromX:(CGFloat)xPos andY:(CGFloat)yPos withLaserType:(LaserType) laserType withOrientation:(LaserOrientation) laserOrientation withColor: (LaserColor) laserColor
{
    
    Laser *laser;
    
    laser = [Laser initWithSpriteLaserType: laserType withOrientation: laserOrientation withColor: laserColor];

    laser.position = [self.map convertMapCoordinateToWorldCoordinate: CGPointMake(xPos, yPos)];
    laser.initialPosition = laser.position;
    [self.world addChild: laser];
}

-(void)createButtonFromX:(CGFloat)xPos andY:(CGFloat)yPos withColor: (ButtonColor) buttonColor
{
    
    Button *button;
    
    button = [Button initWithSpriteButtonColor: buttonColor];

    button.position = [self.map convertMapCoordinateToWorldCoordinate: CGPointMake(xPos, yPos)];
    
    [self.world addChild: button];
}


#pragma mark -
#pragma mark - Properties
/*** END DHB ****/


- (void)setBackgroundImage:(UIImage *)backgroundImage
{
 
}

/*** END DHB ****/

- (void) handleRotation:(UIRotationGestureRecognizer *) rotationrecognizer{

}


#pragma mark -
#pragma mark actions
- (void) update:(CFTimeInterval)currentTime
{
    /*
    // Calculate the time since last update
    self.timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    
    self.lastUpdateTimeInterval = currentTime;
    
    if ( self.timeSinceLast > 1 )
    {
        self.timeSinceLast = 1.0f / 60.0f;
        self.lastUpdateTimeInterval = currentTime;
    }
    */
    
    [self processUserMotionForUpdate:currentTime];
    
    
    // Move "camera" so the player is in the middle of the screen
    //  self.world.position = CGPointMake(-self.player.position.x + CGRectGetMidX(self.frame),
    //                                    -self.player.position.y + CGRectGetMidY(self.frame));
    //NSLog(@"%d", self.frame );

    
}

-(void)processUserMotionForUpdate:(NSTimeInterval)currentTime {
    //
    BOOL isAnyLaserOn=NO;
    
    CMAccelerometerData* data = self.motionManager.accelerometerData;
    //
    if (fabs(data.acceleration.x) > 0.1 || fabs(data.acceleration.y) > 0.1) {
      
      [self.player.physicsBody applyForce:CGVectorMake(80.0 * data.acceleration.x, 80.0 * data.acceleration.y)];
      
    }


    AppDelegate* appDelegate=[[UIApplication sharedApplication] delegate];
    
    if (fabs(self.player.physicsBody.velocity.dx) > 0.1 || fabs(self.player.physicsBody.velocity.dy) > 0.1)
    {

        appDelegate.sharedActions.rollingSound.volume = (fabs(self.player.physicsBody.velocity.dx) + fabs(self.player.physicsBody.velocity.dy)) / 1000;
        //NSLog(@"velX=%f   velY=%f    volume=%f",fabs(self.player.physicsBody.velocity.dx) , fabs(self.player.physicsBody.velocity.dy),delegate.rollingSound.volume);
        if(!appDelegate.sharedActions.rollingSound.playing)
        {
            [appDelegate.sharedActions.rollingSound play];
        }
    } else
    {
        [appDelegate.sharedActions.rollingSound pause];
    }
    
    //BLACK HOLE FORCE
    //F=M1M2 / r2
    //Check Black Holes
    NSUInteger blackHoleCnt = [self.arrayOfBlackHoleIndexes count] ;
    
    for ( NSInteger i = 0; i < blackHoleCnt; i++ )
    {
        NSNumber *blackHoleIndex = (NSNumber*) [self.arrayOfBlackHoleIndexes objectAtIndex:i];
   
        BlackHole* hole = (BlackHole*) [self.world.children objectAtIndex: [blackHoleIndex intValue]];
    
        double xDiff = ((hole.position.x) - (self.player.position.x));
        double yDiff = ((hole.position.y) - (self.player.position.y));
        double distance = sqrt((pow(fabs(xDiff), 2)) + (pow(fabs(yDiff), 2)));
        //NSLog(@"xDiff= %f yDiff=%f Distance=%f  x=%f   y=%f",xDiff, yDiff, distance, hole.position.x, self.player.position.x);
    
        // if we are within 200 pixels then apply a force if this is the closest Black hole
        if(distance < 300)
        {
            double xDirForce;
            double yDirForce;

            if (xDiff < 0)
            {
                xDirForce = -300 - xDiff;
            } else
            {
                xDirForce = 300 - xDiff;
            }
            //My own magnet math, I'm too old to remember how to do this correctly.

            if (yDiff < 0)
            {
                yDirForce = -300 - yDiff;
            } else
            {
                yDirForce = 300 - yDiff;
            }
            [self.player.physicsBody applyForce: CGVectorMake(( xDirForce * 150) / pow(distance, 2), (yDirForce * 150) / pow(distance, 2))];
            //[self.player.physicsBody applyForce: CGVectorMake((( (1/xDiff) )*10350) / pow(distance, 2), (( (1/yDiff)) * 10350) / pow(distance, 2))];
        }
    
    }
    
    
    //Check Lasers
    NSUInteger laserCnt = [self.arrayOfLaserIndexes count] ;
    
    for ( NSInteger i = 0; i < laserCnt; i++ )
    {
        NSNumber *laserIndex = (NSNumber*) [self.arrayOfLaserIndexes objectAtIndex:i];
   
        Laser* laser = (Laser*) [self.world.children objectAtIndex: [laserIndex intValue]];
    
        [laser updateLaser];
    
        // If any of the Lasers are on, play or resume playing the laser sound
        if(laser.isOn && laser.laserType==LaserTypeOnOff)
        {
            isAnyLaserOn=YES;
        }
       
    }

    if(isAnyLaserOn)
    {
        //Resume playing laser sound
        if(!appDelegate.sharedActions.laserSound.playing)
        {
            [appDelegate.sharedActions.laserSound play];
        }
    } else
    {
        [appDelegate.sharedActions.laserSound pause];
    }

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if ([node.name isEqualToString:@"pauseGameButton"] || [node.name isEqualToString:@"backButton"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonBackPressed" object:nil]; //Sends message to viewcontroller to show ad.
    }
}


- (void) didSimulatePhysics
{
    self.player.zRotation = 0.0f;
}



- (void) didBeginContact:(SKPhysicsContact *)contact
{
    // 1
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    // 2
    if ((firstBody.categoryBitMask & CollisionTypePlayer) != 0 && (secondBody.categoryBitMask & CollisionTypeExit) != 0)
    {
        // Player reached exit
        //NSLog(@"Player reached exit");
        
        [self resolvePlayerReachedFinish];
    }

    // 2
    if ((firstBody.categoryBitMask & CollisionTypePlayer) != 0 && (secondBody.categoryBitMask & CollisionTypeHole) != 0)
    {
        // Player reached exit
        //NSLog(@"Player reached hole");
    
        
        [self resolveHole: secondBody.node];
    }

    // 2
    if ((firstBody.categoryBitMask & CollisionTypePlayer) != 0 && (secondBody.categoryBitMask & CollisionTypeBlackHole) != 0)
    {
        // Player reached exit
        //NSLog(@"Player BLACK HOLE");
        
        [self resolveBlackHole: secondBody.node];
    }

    if ((firstBody.categoryBitMask & CollisionTypePlayer) != 0 && (secondBody.categoryBitMask & CollisionTypePinballBumper) != 0)
    {
        // Player reached exit
        //NSLog(@"Player reached Pinball Bumper");
    
        [self resolveBumper: secondBody.node];
    
    }

    if ((firstBody.categoryBitMask & CollisionTypePlayer) != 0 && (secondBody.categoryBitMask & CollisionTypeLaser) != 0)
    {
        // Player reached exit
        //NSLog(@"Player HIT Laser");
    
       [self resolveLaser: secondBody.node];
    
    }


    if ((firstBody.categoryBitMask & CollisionTypePlayer) != 0 && (secondBody.categoryBitMask & CollisionTypeButton) != 0)
    {
        // Player reached exit
        //NSLog(@"Player HIT Button");
    
       [self resolveButton: secondBody.node];
    
    }

    if ((firstBody.categoryBitMask & CollisionTypePlayer) != 0 && (secondBody.categoryBitMask & CollisionTypeWall) != 0)
    {
        // Player reached exit
        //[self.bounceSound play];
        //NSLog(@"HIT WALL");
        
        //[self.player runAction:[SKAction playSoundFileNamed:@"bounce.m4a" waitForCompletion:NO]];
        //Setup the rolling sound
    
    }
}

#pragma mark -
#pragma mark RESOLVE ACTIONS

- (void) resolveBumper: (SKNode*) bumper
{
    
    PinballBumper* pb = (PinballBumper*) bumper;
    
    [pb bumped];

}

- (void) resolveLaser: (SKNode*) node
{
    
    Laser* laser = (Laser*) node;
    
    if(laser.isOn)
    {

      NSMutableArray *images=[NSMutableArray arrayWithCapacity:1];
    
      NSString *fileName=@"ball-lasered";
      SKTexture *tempTexture=[SKTexture textureWithImageNamed:fileName];
      [images addObject:tempTexture];
      
      //NSUInteger numberOfFrames = [images count];

      self.player.physicsBody.velocity=CGVectorMake(0, 0);
      self.player.physicsBody.resting=YES;
      [SKTexture preloadTextures:images withCompletionHandler:^(void)
      {
        //SKAction *bumperImageAction = [SKAction animateWithTextures:images timePerFrame:1.0f/numberOfFrames];
        SKAction *soundAction = [self playElectrocutionSound];//[SKAction playSoundFileNamed:@"006142270-electrical-burst-02.mp3" waitForCompletion:NO];
        SKAction *laseredImageAction = [SKAction animateWithTextures: images timePerFrame:0.2 resize:NO restore:YES];

        SKAction *fadeOutAction = [SKAction fadeOutWithDuration: .5];
        SKAction *blockAction = [self restartLevelActionBlock];

        SKAction *laseredAction = [SKAction sequence:@[[SKAction group:@[laseredImageAction, soundAction, fadeOutAction]], blockAction]];
        [self.player runAction:laseredAction];
      }];
    
    }

}

-(SKAction*) playElectrocutionSound
{
    SKAction *blockAction = [SKAction runBlock:^
    {
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
        [appDelegate.sharedActions.electrocutionSound play];
    }];
    
    return blockAction;

}

- (void) resolveButton: (SKNode*) node
{
    
    Button* button = (Button*) node;
    
    if(button.isOn)
    {
        [button buttonBumped];

        NSUInteger worldChildren = [self.world.children count] ;

        for ( NSInteger i = 0; i < worldChildren; i++ )
        {
            // Is this a Laser????
            if([[self.world.children objectAtIndex:i] isKindOfClass: [Laser class]])
            {
                Laser* laser = (Laser*) [self.world.children objectAtIndex:i];
            
                //If the laser turns on/off with a button then if it is the same color turn if off
                if(laser.laserType==LaserTypeButtonOnOff && laser.isOn)
                {
                    if (button.buttonColor==ButtonColorBlue && laser.laserColor==LaserColorBlue)
                    {
                        [laser turnOff];
                    }
                    if (button.buttonColor==ButtonColorGreen && laser.laserColor==LaserColorGreen)
                    {
                        [laser turnOff];
                    }
                    if (button.buttonColor==ButtonColorRed && laser.laserColor==LaserColorRed)
                    {
                        [laser turnOff];
                    }
                }
            }
        }
    
    }

}

- (void) resolveHole: (SKNode*) hole
{
    // Animations
    SKAction *moveAction = [SKAction moveTo: hole.position duration:0.5f];
    //SKAction *rotateAction = [SKAction rotateByAngle:(M_PI  2) duration:0.5f];
    SKAction *fadeAction = [SKAction fadeOutWithDuration:0.5f];//  AlphaTo:0.0f duration:1.0f];
    //SKAction *scaleAction = [SKAction scaleTo: 0.0 duration:1.0];
    SKAction *scaleAction = [SKAction scaleBy: 0.1 duration:0.5f];
    SKAction *soundAction = [SKAction playSoundFileNamed:@"ball_hole.m4a" waitForCompletion:NO];
    SKAction *blockAction = [self restartLevelActionBlock];
    SKAction *holeAnimAction = [SKAction sequence:@[[SKAction group:@[moveAction, soundAction, /*rotateAction, */fadeAction, scaleAction]], blockAction]];
    
    [self.player runAction:holeAnimAction];
}

-(SKAction*) playBlackHoleSound
{
    SKAction *blockAction = [SKAction runBlock:^
    {
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
        [appDelegate.sharedActions.blackHoleSound play];
    }];
    
    return blockAction;

}

- (void) resolveBlackHole: (SKNode*) hole
{
    
    // Animations
    SKAction *moveAction = [SKAction moveTo: hole.position duration:0.5f];
    //SKAction *rotateAction = [SKAction rotateByAngle:(M_PI  2) duration:0.5f];
    SKAction *fadeAction = [SKAction fadeOutWithDuration:0.5f];//  AlphaTo:0.0f duration:1.0f];
    //SKAction *scaleAction = [SKAction scaleTo: 0.0 duration:1.0];
    SKAction *scaleAction = [SKAction scaleBy: 0.1 duration:0.5f];
    SKAction *soundAction = [self playBlackHoleSound]; //[SKAction playSoundFileNamed:@"008900349-vortex.mp3" waitForCompletion:NO];
    SKAction *blockAction = [self restartLevelActionBlock];
    
    SKAction *holeAnimAction = [SKAction sequence:@[[SKAction group:@[moveAction, soundAction, /*rotateAction, */fadeAction, scaleAction]], blockAction]];
    
    [self.player runAction:holeAnimAction];
}


- (void) resolvePlayerReachedFinish
{
    //Stop playing sounds
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate.sharedActions stopAllSounds];
    [appDelegate.sharedActions.backgroundMusicPlayer pause];

    Level* level = [appDelegate levelFromLevelSetIndex:appDelegate.currentLevelSetIndex levelIndex:appDelegate.currentLevelIndex];
    
    // Animations
    SKAction *moveAction = [SKAction moveTo:self.map.exitPoint duration:0.5f];
    //SKAction *rotateAction = [SKAction rotateByAngle:(M_PI * 2) duration:0.5f];
    SKAction *fadeAction = [SKAction fadeAlphaTo:0.0f duration:1.0f];
    SKAction *scaleAction = [SKAction scaleTo: 0.0 duration:1.0];
    SKAction *soundAction = [SKAction playSoundFileNamed:@"012727074-tada-fanfare.mp3" waitForCompletion:NO];
    SKAction *blockAction = [SKAction runBlock:^{
        [self.view presentScene:[[GameScene alloc] initWithSize:self.size] transition:[SKTransition flipHorizontalWithDuration:0.5f]];
    }];
    
    SKAction *exitAnimAction = [SKAction sequence:@[[SKAction group:@[moveAction, /*rotateAction, */fadeAction, scaleAction, soundAction]], blockAction]];
    
    [self.player runAction:exitAnimAction];

    //LevelSet* levelSet = [appDelegate levelSetFromLevelSetIndex: appDelegate.currentLevelSetIndex];
    LevelSet* levelSetNext;
    
    if([appDelegate.arrayOfLevelSets count] > appDelegate.currentLevelSetIndex + 1)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        levelSetNext = [appDelegate levelSetFromLevelSetIndex: appDelegate.currentLevelSetIndex + 1];
        BOOL isUnlocked = [defaults boolForKey:[NSString stringWithFormat:@"%@-unlocked", levelSetNext.identifier]];
    
        if(!isUnlocked)
        {
            [level setIsCompleted: YES];

            if([self canUnlockNextLevelPack])
            {
                //return;
            }
        }
    }
    
    [level setIsCompleted: YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshProgressViews" object:nil]; //Sends message to viewcontroller to show ad.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonBackPressed" object:nil]; //Sends message to viewcontroller to show ad.

}

#pragma mark -
#pragma mark Level Actions

- (BOOL) canUnlockNextLevelPack
{
    //Stop playing sounds
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];

    LevelSet* levelSet = [appDelegate levelSetFromLevelSetIndex: appDelegate.currentLevelSetIndex];
    LevelSet* levelSetNext;
    
    if([appDelegate.arrayOfLevelSets count] > appDelegate.currentLevelSetIndex + 1)
    {
        levelSetNext = [appDelegate levelSetFromLevelSetIndex: appDelegate.currentLevelSetIndex + 1];
    } else
    {
        //There is no other level pack so we cannot unlock it
        return NO;
    }
    
    
    // Now that we no the  next levelSet has not yet been unlocked, check if we can unlock it
    int totalLevels = (int) [levelSet.levels count];
    int totalCompletedLevels = 0;

    for(int i = 0; i<[levelSet.levels count];i++)
    {
        Level* level = [levelSet.levels objectAtIndex:i];
    
        if(level.isCompleted)
        {
            totalCompletedLevels++;
        }
    }

    // If you complete all but 1 levelSet is unlocked.
    if(totalCompletedLevels >= totalLevels)
    {
        [levelSetNext setIsUnlocked: YES];
        self.completedMessageText = [NSString stringWithFormat: @"%@ has been Unlocked!", levelSetNext.name];
    
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!"
                                                        message: self.completedMessageText
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
            [alert show];
 
    
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"completedLevelPackSegue" object:nil]; //Sends message to viewcontroller to show ad.

        //WINHERE
        return YES;
    }


    return NO;
}


-(SKAction*) restartLevelActionBlock
{
    //Stop playing sounds
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate.sharedActions stopAllSounds];
    

    SKAction *blockAction = [SKAction runBlock:^
    {
        /*GameScene* scene = [[GameScene alloc] initWithSize:self.size];

    
        [scene loadLevel];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        [self.view presentScene: scene transition: [SKTransition fadeWithDuration:0.5f]];//doorsCloseVerticalWithDuration:0.5f]];
         */
         [[NSNotificationCenter defaultCenter] postNotificationName:@"layoutScene" object:nil]; //Sends message to viewcontroller to show ad.


    }];
    
    return blockAction;

}

@end
