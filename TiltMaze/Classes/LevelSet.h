//
//  LevelSet.h
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/20/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Levels are organized into sets so we can group them along similar themes and into
 * easier chunks to deal with.  This object is a little struct containing the information
 * about a specific set of levels.
 */
@interface LevelSet : NSObject

/**
 * Create a new LevelSet
 *
 * @param name the display name of the level
 * @param the levels in this set
 */
-(id)initWithName: (NSString*) name identifier: (NSString*) identifier index: (int) index levels:(NSMutableArray*) levels;

/**
 * The name of this level set
 */
@property (readwrite, retain) NSString *name;
@property (readwrite, retain) NSString *identifier;
@property (nonatomic) NSString *status;
@property (nonatomic) int index;

@property (nonatomic) BOOL isUnlocked;

/**
 * The levels in this set
 */
@property (readwrite, retain) NSMutableArray *levels;

@end
