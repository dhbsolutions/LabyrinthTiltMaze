//
//  Level.h
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/8/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//
#import <Foundation/Foundation.h>

/**
 * Levels Object Definition.
 */
@interface Level: NSObject
/**
 * Create a new LevelS
 *
 */
-(id)initWithNameAndLevel: (NSString*) name levelId: (int) levelId imageName:(NSString*) imageName isLocked: (BOOL) locked fileName:(NSString*) fileName;


/**
 * The name of this level set
 */
@property (readwrite, retain) NSString *name;
@property (readwrite, retain) NSString *fileName;

/**
 * The name of the image for this level set
 */
@property (readwrite, retain) NSString *imageName;

/**
 * The sorted list of IDs for the level in this set
 */
@property (nonatomic) int levelId;

@property (nonatomic) BOOL isCompleted;

@end