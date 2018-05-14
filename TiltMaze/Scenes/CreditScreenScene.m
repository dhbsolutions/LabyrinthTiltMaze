//
//  CreditScreenScene.m
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/20/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import "CreditScreenScene.h"
#import "ScaleUtil.h"

@interface CreditScreenScene()

@property (nonatomic) SKNode *world;
@property (nonatomic) SKSpriteNode *background;
@property (nonatomic) SKTextureAtlas *spriteAtlas;


@end

@implementation CreditScreenScene

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
        self.background.size= [ScaleUtil getMenuSize];;
        self.background.position = [ScaleUtil getMenuCenterPoint:self.frame];

        //self.background.position = CGPointMake(0, 0);
        self.background.name = @"background";
    
        [self addChild:self.background];
    
    
        // Add a node for the world - this is where sprites and tiles are added
        self.world = [SKNode node];
        
        // Load the atlas that contains the sprites
        self.spriteAtlas = [SKTextureAtlas atlasNamed:@"sprites"];

        self.creditsImage = [SKSpriteNode spriteNodeWithTexture:[self.spriteAtlas textureNamed:@"Credits"]];
    
        CGPoint pt = [ScaleUtil getMenuCenterPoint:self.frame];
        pt.y= pt.y - 60;
    
        self.creditsImage.position = pt;
        // NOT SURE WHY I HAD TO DO THIS
         CGSize s= CGSizeMake(self.creditsImage.size.width *.85, self.creditsImage.size.height *.85) ;
    //    CGSize s2= self.background.size;
        self.creditsImage.size = s;
        //self.creditsImage.position.y = self.creditsImage.position.y-80;
        [self.world addChild: self.creditsImage];

        self.backButton = [SKSpriteNode spriteNodeWithTexture:[self.spriteAtlas textureNamed:@"BackBig2"]];

        self.backButton.position = [ScaleUtil positionMenuBackButton: self.background.position];
        self.backButton.name = @"backButton";
        [self.world addChild: self.backButton];
    
        [self addChild:self.world];
    }
    return self;
}

#pragma mark -
#pragma mark actions
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if ([node.name isEqualToString:@"backButton"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonBackPressed" object:nil]; //Sends message to viewcontroller to show ad.
    }
}



@end
