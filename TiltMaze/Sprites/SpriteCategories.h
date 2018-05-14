//
//  SpriteCategories.h
//  Tilt Maze
//
//  Created by Butler, David  on 12/24/13.
//  Copyright (c) 2014 DHB Worlds. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(uint32_t, CollisionType)
{
    CollisionTypePlayer     = 0x1 << 0,
    CollisionTypeWall       = 0x1 << 1,
    CollisionTypeExit       = 0x1 << 2,
    CollisionTypeHole       = 0x1 << 3,
    CollisionTypePinballBumper       = 0x1 << 4,
    CollisionTypeBlackHole       = 0x1 << 5,
    CollisionTypeLaser       = 0x1 << 6,
    CollisionTypeButton       = 0x1 << 7
};
