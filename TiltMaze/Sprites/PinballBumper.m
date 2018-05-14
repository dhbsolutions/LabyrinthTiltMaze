//
//  PinballBumper.m
//  TiltMaze
//
//  Created by Butler, David {BIS} on 2/22/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import "PinballBumper.h"
#import "SpriteCategories.h"

@interface PinballBumper()


@end

@implementation PinballBumper

+(instancetype)initWithSpriteImageName:(NSString*)name
{
    PinballBumper* pinballBumperSprite = [PinballBumper spriteNodeWithImageNamed: name];
    pinballBumperSprite.size = CGSizeMake(32,32);
    //pinballBumperSprite.blendMode = SKBlendModeReplace;

    pinballBumperSprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:14];
    pinballBumperSprite.physicsBody.usesPreciseCollisionDetection = YES;
    pinballBumperSprite.physicsBody.dynamic = NO;
    //wall.physicsBody.categoryBitMask = CollisionTypeWall;
    pinballBumperSprite.physicsBody.contactTestBitMask = 0;

    pinballBumperSprite.physicsBody.categoryBitMask=CollisionTypePinballBumper;
    pinballBumperSprite.physicsBody.collisionBitMask = 0;
    pinballBumperSprite.physicsBody.restitution=1.5;
    //SKAction* action = [SKAction rotateByAngle:M_PI duration:6];
    //[pinballBumperSprite runAction: [SKAction repeatActionForever:action]];

    
    return pinballBumperSprite;
}

-(void) bumped
{
      NSMutableArray *images=[NSMutableArray arrayWithCapacity:1];
    
      NSString *fileName=@"PinballBumperOn.png";
      SKTexture *tempTexture=[SKTexture textureWithImageNamed:fileName];
      [images addObject:tempTexture];
      
      //NSUInteger numberOfFrames = [images count];

      [SKTexture preloadTextures:images withCompletionHandler:^(void)
      {
        //SKAction *bumperImageAction = [SKAction animateWithTextures:images timePerFrame:1.0f/numberOfFrames];
        SKAction *bumperImageAction = [SKAction animateWithTextures: images timePerFrame:0.2 resize:NO restore:YES];

        SKAction *soundAction = [SKAction playSoundFileNamed:@"PinballBumper.m4a" waitForCompletion:NO];

        SKAction *bumperAnimAction = [SKAction sequence:@[[SKAction group:@[bumperImageAction, soundAction]]]];
        [self runAction:bumperAnimAction];
      }];

}


-(void)removeFromParent {
    [super removeFromParent];
}
@end
