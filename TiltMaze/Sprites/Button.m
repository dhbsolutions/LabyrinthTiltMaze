//
//  Button.m
//  LabyrinthTiltMaze
//
//  Created by Butler, David {BIS} on 4/17/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import "Button.h"
#import "SpriteCategories.h"

@interface Button()

@end


@implementation Button

+(instancetype)initWithSpriteButtonColor: (ButtonColor) buttonColor
{

    Button *button;

    switch (buttonColor)
    {
        case ButtonColorRed:
            button  = [Button spriteNodeWithImageNamed: @"ButtonRed"];
            break;
        case ButtonColorBlue:
            button = [Button spriteNodeWithImageNamed: @"ButtonBlue"];
            break;
        case ButtonColorGreen:
            button = [Button spriteNodeWithImageNamed: @"ButtonGreen"];
            break;
    }

    button.isOn=YES;
    button.buttonColor=buttonColor;
    button.size = CGSizeMake(32,32);
    
    button.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius: 14];
    button.physicsBody.dynamic = NO;
    button.physicsBody.usesPreciseCollisionDetection = YES;

    button.physicsBody.categoryBitMask=CollisionTypeButton;
    button.physicsBody.collisionBitMask = 0;

    return button;
}

-(void) buttonBumped
{
    
    if(self.isOn)
    {
    
        self.isOn=NO;
        NSString *fileName=@"ButtonOff.png";
        SKTexture *offTexture=[SKTexture textureWithImageNamed:fileName];

        [self setTexture: offTexture];


        SKAction *soundAction = [SKAction playSoundFileNamed:@"020073177-switch-button-1.mp3" waitForCompletion:NO];

        SKAction *buttonAction = [SKAction sequence:@[[SKAction group:@[soundAction]]]];
        [self runAction:buttonAction];
    }

}


@end
