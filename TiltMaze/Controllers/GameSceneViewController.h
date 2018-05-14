//
//  GameSceneViewController
//  Tilt Maze
//

//  Copyright (c) 2014 DHB Worlds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "Level.h"
#import <iAd/iAd.h>

@interface GameSceneViewController : UIViewController<ADBannerViewDelegate>

@property (nonatomic) ADBannerView *bannerView;

@end
