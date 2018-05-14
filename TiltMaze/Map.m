//
//  Map.m
//  Tilt Maze
//
//  Created by Dave Butler on 12/20/13.
//  Copyright (c) 2014 DHB Worlds. All rights reserved.
//

#import "Map.h"
#import "MapTiles.h"
#import "GameScene.h"
#import "SpriteCategories.h"
#import "Hole.h"
#import "FileUtil.h"
#import "AppDelegate.h"

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface Map ()
@property (nonatomic) MapTiles *tiles;
@property (nonatomic) SKTextureAtlas *tileAtlas;
@property (nonatomic) CGFloat tileSize;
@property (nonatomic) NSMutableArray *floorMakers;

@end

@implementation Map

+ (instancetype) mapWithGridSize:(CGSize)gridSize
{
  return [[self alloc] initWithGridSize:gridSize];
}

- (instancetype) initWithGridSize:(CGSize)gridSize
{
  if (( self = [super init] ))
  {
    self.gridSize = gridSize;
  
    _spawnPoint = CGPointZero;
    _exitPoint = CGPointZero;
    self.tileAtlas = [SKTextureAtlas atlasNamed:@"tiles"];
    
    NSArray *textureNames = [self.tileAtlas textureNames];
    SKTexture *tileTexture = [self.tileAtlas textureNamed:(NSString *)[textureNames firstObject]];
    self.tileSize = tileTexture.size.width;
  }
  return self;
}


- (SKTextureAtlas *)textureAtlasNamed:(NSString *)fileName
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
 
        if (IS_WIDESCREEN) {
            // iPhone Retina 4-inch
            fileName = [NSString stringWithFormat:@"%@-568", fileName];
        } else {
            // iPhone Retina 3.5-inch
            fileName = fileName;
        }
 
    } else {
        fileName = [NSString stringWithFormat:@"%@-ipad", fileName];
    }
 
    SKTextureAtlas *textureAtlas = [SKTextureAtlas atlasNamed:fileName];
 
    return textureAtlas;
}

- (CGPoint)convertPoint:(CGPoint)point
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return CGPointMake(32 + point.x, 0 + point.y);
    } else {
        //DHB CHANGED THIS LINE******
        return CGPointMake(32 + point.x, 0 + point.y);
        return point;
    }
}



- (void) generateTileGrid
{

  AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
  
  Level *level = [appDelegate levelFromLevelSetIndex: appDelegate.currentLevelSetIndex levelIndex:appDelegate.currentLevelIndex];
  

  FileUtil* fu = [[FileUtil alloc] init];
  
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
        
            //If it is not a wall, make it a floor for now
            if (chr!='W')
            {
                [self.tiles setTileType:MapTileTypeFloor at: CGPointMake(x, y) ];
            }
        
        
            //If it is not a wall, make it a floor for now
            if (chr=='F')
            {
                //[self.tiles setTileType:MapTileTypeFloor at: CGPointMake(x, y) ];
                _exitPoint = [self convertMapCoordinateToWorldCoordinate: CGPointMake(x, y)];
            }

            //If it is not a wall, make it a floor for now
            if (chr=='S')
            {
                //[self.tiles setTileType:MapTileTypeFloor at: CGPointMake(x, y) ];
                _spawnPoint = [self convertMapCoordinateToWorldCoordinate: CGPointMake(x, y)];
            }
        }
    
    
        //[data replaceObjectAtIndex: i withObject: [[data objectAtIndex: i] componentsSeparatedByString: @","]];
    }
  
  //NSLog(@"%@", mapText);
  
    //_exitPoint = [self convertMapCoordinateToWorldCoordinate: CGPointMake(2, 27)];

    //_spawnPoint = [self convertMapCoordinateToWorldCoordinate:CGPointMake(1.1,1.1)];
  
  //NSLog(@"%@", [self.tiles description]);
}

- (void) generate
{
  self.tiles = [[MapTiles alloc] initWithGridSize:self.gridSize];
  [self generateTileGrid];
  [self generateWalls];
  [self generateTiles];
  [self generateCollisionWalls];
//  [self generateHoles];
}

- (NSInteger) randomNumberBetweenMin:(NSInteger)min andMax:(NSInteger)max
{
  return min + arc4random() % (max - min);
}

- (void) generateTiles
{
  // 1
  for ( NSInteger y = 0; y < self.tiles.gridSize.height; y++ )
  {
    for ( NSInteger x = 0; x < self.tiles.gridSize.width; x++ )
    {
      // 2
      CGPoint tileCoordinate = CGPointMake(x, y);
      // 3
      MapTileType tileType = [self.tiles tileTypeAt:tileCoordinate];
      // 4
      if ( tileType != MapTileTypeNone )
      {
        // 5
        SKTexture *tileTexture;
      
        if (tileType==MapTileTypeWall)
        {
            // DHB If its a wall we need to determine is it a corner, end, etc.
        
            CGPoint coordinateXMinusOne = CGPointMake(x - 1, y);
            CGPoint coordinateXPlusOne = CGPointMake(x + 1, y);
            CGPoint coordinateYMinusOne = CGPointMake(x, y - 1);
            CGPoint coordinateYPlusOne = CGPointMake(x, y + 1);

            BOOL hasLeftWall = [self.tiles tileTypeAt:coordinateXMinusOne] == MapTileTypeWall;
            BOOL hasRightWall = [self.tiles tileTypeAt:coordinateXPlusOne] == MapTileTypeWall;
            BOOL hasTopWall = [self.tiles tileTypeAt:coordinateYMinusOne] == MapTileTypeWall;
            BOOL hasBottomWall = [self.tiles tileTypeAt:coordinateYPlusOne] == MapTileTypeWall;

            BOOL hasUpperLeftWall = [self.tiles tileTypeAt: CGPointMake(x - 1, y -1)] == MapTileTypeWall;
            BOOL hasUpperRightWall = [self.tiles tileTypeAt: CGPointMake(x + 1, y - 1)] == MapTileTypeWall;
            BOOL hasLowerLeftWall = [self.tiles tileTypeAt: CGPointMake(x - 1, y + 1)] == MapTileTypeWall;
            BOOL hasLowerRightWall = [self.tiles tileTypeAt: CGPointMake(x + 1, y + 1)] == MapTileTypeWall;



            // Oddball walls

            if (!hasBottomWall && !hasLeftWall && hasTopWall && hasRightWall && hasUpperRightWall)
            {
                tileType = MapTileTypeWallFatCornerLowerLeft;
            } else
            if (!hasBottomWall && hasLeftWall && hasTopWall && !hasRightWall && hasUpperLeftWall)
            {
                tileType = MapTileTypeWallFatCornerLowerRight;
            } else
            if (hasBottomWall && !hasLeftWall && !hasTopWall && hasRightWall && hasLowerRightWall)
            {
                tileType = MapTileTypeWallFatCornerUpperLeft;
            } else
            if (hasBottomWall && hasLeftWall && !hasTopWall && !hasRightWall && hasLowerLeftWall)
            {
                tileType = MapTileTypeWallFatCornerUpperRight;
            } else

            // T walls
            if (hasBottomWall && hasLeftWall && !hasTopWall && hasRightWall)
            {
                tileType = MapTileTypeWallT_TopFlat;
            } else
            if (hasBottomWall && hasLeftWall && hasTopWall && !hasRightWall)
            {
                tileType = MapTileTypeWallT_RightFlat;
            } else
            if (!hasBottomWall && hasLeftWall && hasTopWall && hasRightWall)
            {
                tileType = MapTileTypeWallT_BottomFlat;
            } else
            if (hasBottomWall && !hasLeftWall && hasTopWall && hasRightWall)
            {
                tileType = MapTileTypeWallT_LeftFlat;
            } else

            //Basic Walls
            if (!hasBottomWall && !hasLeftWall && hasTopWall && hasRightWall)
            {
                tileType = MapTileTypeWallCornerLowerLeft;
            } else
            if (!hasBottomWall && hasLeftWall && hasTopWall && !hasRightWall)
            {
                tileType = MapTileTypeWallCornerLowerRight;
            } else
            if (hasBottomWall && !hasLeftWall && !hasTopWall && hasRightWall)
            {
                tileType = MapTileTypeWallCornerUpperLeft;
            } else
            if (hasBottomWall && hasLeftWall && !hasTopWall && !hasRightWall)
            {
                tileType = MapTileTypeWallCornerUpperRight;
            } else
            if (!hasBottomWall && !hasLeftWall && hasTopWall && !hasRightWall)
            {
                tileType = MapTileTypeWallEndBottom;
            } else
            if (!hasBottomWall && !hasLeftWall && !hasTopWall && hasRightWall)
            {
                tileType = MapTileTypeWallEndLeft;
            } else
            if (!hasBottomWall && hasLeftWall && !hasTopWall && !hasRightWall)
            {
                tileType = MapTileTypeWallEndRight;
            } else
            if (hasBottomWall && !hasLeftWall && !hasTopWall && !hasRightWall)
            {
                tileType = MapTileTypeWallEndTop;
            } else
            if (!hasBottomWall && hasLeftWall && !hasTopWall && hasRightWall)
            {
                tileType = MapTileTypeWallHorizontal;
            } else
            if (hasBottomWall && !hasLeftWall && hasTopWall && !hasRightWall)
            {
                tileType = MapTileTypeWallVerical;
            }

            tileTexture = [self.tileAtlas textureNamed:[NSString stringWithFormat:@"%i", (int) tileType]];
        } else
        {
            tileTexture = [self.tileAtlas textureNamed:[NSString stringWithFormat:@"%i", (int) tileType]];
        }
      
        SKSpriteNode *tile = [SKSpriteNode spriteNodeWithTexture:tileTexture];
        // 6
        tile.position = [self convertMapCoordinateToWorldCoordinate:CGPointMake(tileCoordinate.x, tileCoordinate.y)];
        // 7
        [self addChild:tile];
      }
    }
  }
}



- (CGPoint) convertMapCoordinateToWorldCoordinate:(CGPoint)mapCoordinate
{
  return CGPointMake(mapCoordinate.x * self.tileSize,  (self.tiles.gridSize.height - mapCoordinate.y) * self.tileSize);
}


- (void) generateWalls
{
  // 1
  for ( NSInteger y = 0; y < self.tiles.gridSize.height; y++ )
  {
    for ( NSInteger x = 0; x < self.tiles.gridSize.width; x++ )
    {
      CGPoint tileCoordinate = CGPointMake(x, y);
      
      // 2
      if ( [self.tiles tileTypeAt:tileCoordinate] == MapTileTypeFloor )
      {
        for ( NSInteger neighbourY = -1; neighbourY < 2; neighbourY++ )
        {
          for ( NSInteger neighbourX = -1; neighbourX < 2; neighbourX++ )
          {
            if ( !(neighbourX == 0 && neighbourY == 0) )
            {
              CGPoint coordinate = CGPointMake(x + neighbourX, y + neighbourY);
              
              // 3
              if ( [self.tiles tileTypeAt:coordinate] == MapTileTypeNone )
              {
                [self.tiles setTileType:MapTileTypeWall at:coordinate];
              }
            }
          }
        }
      }
    }
  }
}

- (void) addCollisionWallAtPosition:(CGPoint)position withSize:(CGSize)size
{
  SKNode *wall = [SKNode node];
  
  wall.position = CGPointMake(position.x + size.width * 0.5f - 0.5f * self.tileSize,
                              position.y - size.height * 0.5f + 0.5f * self.tileSize);
  wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
  wall.physicsBody.dynamic = NO;
  wall.physicsBody.categoryBitMask = CollisionTypeWall;
  wall.physicsBody.contactTestBitMask = 0;
  wall.physicsBody.collisionBitMask = CollisionTypePlayer;
  
  [self addChild:wall];
}

- (void) generateCollisionWalls
{
  for ( NSInteger y = 0; y < self.tiles.gridSize.height; y++ )
  {
    CGFloat startPointForWall = 0;
    CGFloat wallLength = 0;
    for ( NSInteger x = 0; x <= self.tiles.gridSize.width; x++ )
    {
      CGPoint tileCoordinate = CGPointMake(x, y);
      // 1
      if ( [self.tiles tileTypeAt:tileCoordinate] == MapTileTypeWall )
      {
        if ( startPointForWall == 0 && wallLength == 0 )
        {
          startPointForWall = x;
        }
        wallLength += 1;
      }
      // 2
      else if ( wallLength > 0 )
      {
        CGPoint wallOrigin = CGPointMake(startPointForWall, y);
        CGSize wallSize = CGSizeMake(wallLength * self.tileSize, self.tileSize);
        [self addCollisionWallAtPosition:[self convertMapCoordinateToWorldCoordinate:wallOrigin] withSize:wallSize];
        startPointForWall = 0;
        wallLength = 0;
      }
    }
  }
}


@end
