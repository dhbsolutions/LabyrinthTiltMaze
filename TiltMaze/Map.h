//
//  Map.h
//  Tilt Maze
//
//  Created by Dave Butler on 12/20/13.
//  Copyright (c) 2014 DHB Worlds. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Level.h"

@interface Map : SKNode

@property (nonatomic) CGSize gridSize;
@property (nonatomic, readonly) CGPoint spawnPoint;
@property (nonatomic, readonly) CGPoint exitPoint;
//@property (nonatomic, retain) Level* selectedLevel;

+ (instancetype) mapWithGridSize:(CGSize)gridSize;
- (instancetype) initWithGridSize:(CGSize)gridSize;
- (void) generate;
- (CGPoint) convertMapCoordinateToWorldCoordinate:(CGPoint)mapCoordinate;

@end
