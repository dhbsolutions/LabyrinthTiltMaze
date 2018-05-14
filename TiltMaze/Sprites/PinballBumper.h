//
//  PinballBumper.h
//  TiltMaze
//
//  Created by Butler, David {BIS} on 2/22/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PinballBumper : SKSpriteNode

+(instancetype)initWithSpriteImageName:(NSString*)name;
-(void) bumped;

@end
