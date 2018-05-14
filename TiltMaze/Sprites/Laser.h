//
//  Laser.h
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/15/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Laser : SKSpriteNode

typedef NS_ENUM(NSInteger, LaserType)
{
  LaserTypeOnOff = 1,
  LaserTypeMoving = 2,
  LaserTypeButtonOnOff = 3
};

typedef NS_ENUM(NSInteger, LaserOrientation)
{
  LaserOrientationVertical = 1,
  LaserOrientationHorizontal = 2
};

typedef NS_ENUM(NSInteger, LaserColor)
{
  LaserColorBlue = 1,
  LaserColorGreen = 2,
  LaserColorRed = 3,
  LaserColorPurple = 4,
  LaserColorOrange = 5
  
};

@property (nonatomic) BOOL isOn;
@property(nonatomic) CGPoint initialPosition;
@property(nonatomic) BOOL isMovingForward;
@property (nonatomic) LaserOrientation laserOrientation;
@property (nonatomic) LaserType laserType;
@property (nonatomic) LaserColor laserColor;

+(instancetype)initWithSpriteLaserType: (LaserType) laserType withOrientation: (LaserOrientation) laserOrientation withColor: (LaserColor) laserColor;

-(void) updateLaser;
-(void) turnOff;

@end
