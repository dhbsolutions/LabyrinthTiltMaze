//
//  LevelMgr.h
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/8/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 
 * The LevelMgr manages the list of levels, generates the level 
 * screenshots and handles the Cocos2d framework initialization.
 */
@interface LevelMgr : NSObject {
    @private
    
    bool _hasInit;
}

/** 
 * Gets the singleton of the LevelMgr
 */
//+(LevelMgr *)getLevelMgr;

/**
 * Get the set of the levels for the specified level set index.
 */
//+(LevelSet*)getLevelSet: (int) index;

/**
 * This is a helper method to get a specific level.
 *
 * @param set the index of the set containing this level
 * @param levelId the ID of the level to find
 */
//+(Level*)getLevel: (int) set levelId:(NSString*) levelId;

/** 
 * Generate a set of images of each level in the documents directory.
 *
 * @param bounds the size to draw the level image.
 */
//-(void)drawLevels:(CGRect) bounds;

/**
 * This number holds the current level set index.  It's used for
 * the page control.
 */
//@property (readwrite) int currentSet;

/**
 * This variable is kind of a hack.  The level manager shouldn't know anything
 * about the UI that drives the game, but it's an easy shared object to communicate
 * between the you won view and the main menu controller.
 */
//@property (readwrite) bool showSetMenu;

/**
 * The array of sorted level sets.
 */
//@property (readonly,copy) NSArray *levelSets;

/** 
 * The graphics view used to add the Cocos2d view into the UIKit stack
 */

@end
