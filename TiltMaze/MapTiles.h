//
//  MapTiles.h
//  Tilt Maze
//
//  Created by Dave Butler on 12/20/13.
//  Copyright (c) 2014 DHB Worlds. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MapTileType)
{
  MapTileTypeInvalid = -1,
  MapTileTypeNone = 0,
  MapTileTypeFloor = 1,
  MapTileTypeWall = 2,
  MapTileTypeWallCornerLowerLeft = 3,  //wall_corner_lower_left
  MapTileTypeWallCornerLowerRight = 4,  //wall_corner_lower_right
  MapTileTypeWallCornerUpperLeft = 5,  //wall_corner_upper_left
  MapTileTypeWallCornerUpperRight = 6,  //wall_corner_upper_right
  MapTileTypeWallEndBottom = 7,    // wall_end_bottom
  MapTileTypeWallEndLeft = 8,
  MapTileTypeWallEndRight = 9,
  MapTileTypeWallEndTop = 10,
  MapTileTypeWallHorizontal = 11,
  MapTileTypeWallVerical = 12,
  MapTileTypeWallT_TopFlat = 13,
  MapTileTypeWallT_RightFlat = 14,
  MapTileTypeWallT_BottomFlat = 15,
  MapTileTypeWallT_LeftFlat = 16,
  MapTileTypeWallFatCornerLowerLeft = 17,
  MapTileTypeWallFatCornerLowerRight = 18,
  MapTileTypeWallFatCornerUpperLeft = 19,
  MapTileTypeWallFatCornerUpperRight = 20
  
};

@interface MapTiles : NSObject

@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) CGSize gridSize;

- (instancetype) initWithGridSize:(CGSize)size;
- (MapTileType) tileTypeAt:(CGPoint)tileCoordinate;
- (void) setTileType:(MapTileType)type at:(CGPoint)tileCoordinate;
- (BOOL) isEdgeTileAt:(CGPoint)tileCoordinate;
- (BOOL) isValidTileCoordinateAt:(CGPoint)tileCoordinate;

@end
