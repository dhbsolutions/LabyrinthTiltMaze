//
//  Button.h
//  LabyrinthTiltMaze
//
//  Created by Butler, David {BIS} on 4/17/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Button : SKSpriteNode

    typedef NS_ENUM(NSInteger, ButtonColor)
    {
      ButtonColorBlue = 1,
      ButtonColorGreen = 2,
      ButtonColorRed = 3
    };

    @property (nonatomic) BOOL isOn;
    @property (nonatomic) ButtonColor buttonColor;

    +(instancetype)initWithSpriteButtonColor: (ButtonColor) buttonColor;
    -(void) buttonBumped;

@end
