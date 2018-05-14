//
//  Hole.m
//  Tilt Maze
//
//  Created by Butler, David  on 12/24/13.
//

#import "Hole.h"
#import "SpriteCategories.h"

//#import "SpriteCategories.h"

@implementation Hole {}

+(instancetype)initWithSpriteImageName:(NSString*)name {
    
        Hole *holeSprite = [Hole spriteNodeWithImageNamed: name];
        holeSprite.size = CGSizeMake(32,32);
        
        holeSprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:14];
        holeSprite.physicsBody.usesPreciseCollisionDetection = YES;
        holeSprite.physicsBody.categoryBitMask=CollisionTypeHole;
        holeSprite.physicsBody.dynamic = NO;
        holeSprite.physicsBody.collisionBitMask = 0;
        
    return holeSprite;
}


-(void)removeFromParent {
    [super removeFromParent];
}

@end