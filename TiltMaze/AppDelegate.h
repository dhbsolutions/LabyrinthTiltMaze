//
//  AppDelegate.h
//  Tilt Maze
//
//  Created by Dave Butler on 01/01/2014.
//  Copyright (c) 2014 DHB Worlds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Level.h"
#import "LevelSet.h"
#import "SharedAction.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{

    NSMutableArray* arrayOfLevelSets;
    int currentLevelSetIndex;
    int currentLevelIndex;

}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSMutableArray* arrayOfLevelSets;
@property (nonatomic) int currentLevelSetIndex;
@property (nonatomic) int currentLevelIndex;
@property (nonatomic) SharedAction *sharedActions;

-(Level*) levelFromLevelSetIndex: (int) levelSetIndex levelIndex: (int) levelIndex;
-(LevelSet*) levelSetFromLevelSetIndex: (int) levelSetIndex;

@end
