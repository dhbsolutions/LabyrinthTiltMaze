//
//  BlackHole.m
//  TiltMaze
//
//  Created by Butler, David {BIS} on 2/23/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import "BlackHole.h"
#import "SpriteCategories.h"

@interface BlackHole()

@end

@implementation BlackHole

+(instancetype)initWithSpriteImageName:(NSString*)name
{
    
    BlackHole* blackHole = [BlackHole spriteNodeWithImageNamed: name];
    blackHole.size = CGSizeMake(54,54);
    
    blackHole.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:14];
    blackHole.physicsBody.usesPreciseCollisionDetection = YES;

    blackHole.physicsBody.categoryBitMask=CollisionTypeBlackHole;
    blackHole.physicsBody.collisionBitMask = 0;
    blackHole.physicsBody.dynamic = NO;
    SKAction* action = [SKAction rotateByAngle:M_PI duration:1.1];
    [blackHole runAction: [SKAction repeatActionForever:action]];
    
    return blackHole;
}



-(void)removeFromParent {
    [super removeFromParent];
}
@end
