//
//  MainScreenScene.m
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/12/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import "MainScreenScene.h"
#import "ScaleUtil.h"

@interface MainScreenScene()

@property (nonatomic) SKNode *world;
@property (nonatomic) SKSpriteNode *background;
@property (nonatomic) SKTextureAtlas *spriteAtlas;

@end

@implementation MainScreenScene

- (id)initWithSize:(CGSize)size
{
    if (( self = [super initWithSize:size] ))
    {
    
        self.backgroundColor = [UIColor clearColor];

        self.background = [SKSpriteNode spriteNodeWithImageNamed:@"woodBackground@2x"];
        self.background.blendMode = SKBlendModeReplace;
    
        //background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        //NSLog(@"WIDTH=%f HEIGHT=%f", self.frame.size.width, self.frame.size.height);
    
        //Set Background Center Pt
        self.background.position = [ScaleUtil getMenuCenterPoint:self.frame];
        self.background.size= [ScaleUtil getMenuSize];;
    
        //self.background.position = CGPointMake(0, 0);
        self.background.name = @"background";
    
        [self addChild:self.background];
    
    
        // Add a node for the world - this is where sprites and tiles are added
        self.world = [SKNode node];
        
        // Load the atlas that contains the sprites
        self.spriteAtlas = [SKTextureAtlas atlasNamed:@"sprites"];

        self.playGameButton = [SKSpriteNode spriteNodeWithTexture:[self.spriteAtlas textureNamed:@"PlayButton"]];
        self.playGameButton.position = CGPointMake(self.background.position.x, 650);
        self.playGameButton.name = @"playGameButton";
        [self.world addChild: self.playGameButton];

        /*self.optionsButton = [SKSpriteNode spriteNodeWithTexture:[self.spriteAtlas textureNamed:@"OptionsButton"]];
        self.optionsButton.position = CGPointMake(self.background.position.x, 450);
        self.optionsButton.name = @"buttonOptionsPressed";
        [self.world addChild: self.optionsButton];*/

        self.creditsButton = [SKSpriteNode spriteNodeWithTexture:[self.spriteAtlas textureNamed:@"CreditsButton"]];
        self.creditsButton.position = CGPointMake(self.background.position.x, 250);
        self.creditsButton.name = @"buttonCreditsPressed";
        [self.world addChild: self.creditsButton];
    
        [self addChild:self.world];
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if ([node.name isEqualToString:@"playGameButton"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonPlayGamePressed" object:nil]; //Sends message to viewcontroller to show ad.
    }

    if ([node.name isEqualToString:@"buttonOptionsPressed"]) {
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"buttonOptionsPressed" object:nil]; //Sends message to viewcontroller to show ad.
    }

    if ([node.name isEqualToString:@"buttonCreditsPressed"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonCreditsPressed" object:nil]; //Sends message to viewcontroller to show ad.
    }
}


@end
