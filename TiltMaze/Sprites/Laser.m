//
//  Laser.m
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/15/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import "Laser.h"
#import "SpriteCategories.h"

@interface Laser()

@end


@implementation Laser

+(instancetype)initWithSpriteLaserType: (LaserType) laserType withOrientation: (LaserOrientation) laserOrientation withColor: (LaserColor) laserColor
{
    Laser *laser;

    if(laserOrientation==LaserOrientationVertical)
    {
        switch (laserColor)
        {
            case LaserColorRed:
                laser = [Laser spriteNodeWithImageNamed: @"LaserRedV"];
                break;
            case LaserColorBlue:
                laser = [Laser spriteNodeWithImageNamed: @"LaserBlueV"];
                break;
            case LaserColorPurple:
                laser = [Laser spriteNodeWithImageNamed: @"LaserPurpleV"];
                break;
            case LaserColorGreen:
                laser = [Laser spriteNodeWithImageNamed: @"LaserGreenV"];
                break;
            case LaserColorOrange:
                laser = [Laser spriteNodeWithImageNamed: @"LaserOrangeV"];
                break;
        }
        laser.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: CGSizeMake(6,32) ];
    } else{
        switch (laserColor)
        {
            case LaserColorRed:
                laser = [Laser spriteNodeWithImageNamed: @"LaserRedH"];
                break;
            case LaserColorBlue:
                laser = [Laser spriteNodeWithImageNamed: @"LaserBlueH"];
                break;
            case LaserColorPurple:
                laser = [Laser spriteNodeWithImageNamed: @"LaserPurpleH"];
                break;
            case LaserColorGreen:
                laser = [Laser spriteNodeWithImageNamed: @"LaserGreenH"];
                break;
            case LaserColorOrange:
                laser = [Laser spriteNodeWithImageNamed: @"LaserOrangeH"];
                break;
        }
        laser.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: CGSizeMake(32,6) ];
    }
    laser.laserType=laserType;
    laser.laserOrientation = laserOrientation;
    laser.laserColor = laserColor;
    laser.isOn=YES;

    laser.size = CGSizeMake(32,32);
    
    laser.physicsBody.usesPreciseCollisionDetection = YES;
    laser.physicsBody.dynamic = YES;

    laser.physicsBody.categoryBitMask=CollisionTypeLaser;
    laser.physicsBody.collisionBitMask = 0;

    if(laserType==LaserTypeOnOff)
    {
        SKAction *fadeOutAction = [SKAction fadeOutWithDuration: .5];
        SKAction *wait1Action = [SKAction waitForDuration:2];
        SKAction *fadeInAction = [SKAction fadeInWithDuration: .5];
        SKAction *wait2Action = [SKAction waitForDuration:1.5];
        //SKAction *soundAction = [SKAction playSoundFileNamed:@"Laser.m4a" waitForCompletion:NO];
 
        SKAction *laserAnimAction = [SKAction sequence:@[
        [SKAction runBlock:^
        {
            //[self.laserMusicPlayer play];
            laser.isOn=YES;
        }],
        //soundAction,
        fadeInAction,
        wait2Action,
        [SKAction runBlock:^
        {
            //[self.laserMusicPlayer pause];
            laser.isOn=NO;
        }], fadeOutAction,
        wait1Action
        ]];

        [laser runAction: [SKAction repeatActionForever:laserAnimAction]];
    }

    return laser;
}

/*
-(void) laserBumped
{
    
    if(self.isOn)
    {
    
    
    }
      NSMutableArray *images=[NSMutableArray arrayWithCapacity:1];
    
      NSString *fileName=@"PinballBumperOn.png";
      SKTexture *tempTexture=[SKTexture textureWithImageNamed:fileName];
      [images addObject:tempTexture];
      //self.laser.hidden;
      //NSUInteger numberOfFrames = [images count];

      [SKTexture preloadTextures:images withCompletionHandler:^(void)
      {
        //SKAction *bumperImageAction = [SKAction animateWithTextures:images timePerFrame:1.0f/numberOfFrames];
        SKAction *bumperImageAction = [SKAction animateWithTextures: images timePerFrame:0.2 resize:NO restore:YES];

        SKAction *soundAction = [SKAction playSoundFileNamed:@"PinballBumper.m4a" waitForCompletion:NO];

        SKAction *bumperAnimAction = [SKAction sequence:@[[SKAction group:@[bumperImageAction, soundAction]]]];
        [self.laser runAction:bumperAnimAction];
      }];

}
*/
-(void) turnOff
{
        SKAction *fadeOutAction = [SKAction fadeOutWithDuration: .5];
    
        [self runAction: fadeOutAction];
        self.isOn=NO;

}

-(void) updateLaser
{
    if(self.laserType==LaserTypeMoving)
    {
        if(self.laserOrientation==LaserOrientationVertical)
        {
            if(self.position.y >= self.initialPosition.y +32) {self.isMovingForward=NO;}
            if(self.position.y <= self.initialPosition.y -32) {self.isMovingForward=YES;}
        
            if(self.isMovingForward)
            {
                self.physicsBody.velocity=CGVectorMake(0, 50);
            } else
            {
                self.physicsBody.velocity=CGVectorMake(0, -50);
            }
        } else
        {
            if(self.position.x >= self.initialPosition.x +32) {self.isMovingForward=NO;}
            if(self.position.x <= self.initialPosition.x -32) {self.isMovingForward=YES;}
        
            if(self.isMovingForward)
            {
                self.physicsBody.velocity=CGVectorMake(50, 0);
            } else
            {
                self.physicsBody.velocity=CGVectorMake(-50, 0);
            }
        }
    }
    

}

-(void)removeFromParent {
    [super removeFromParent];
}
@end
