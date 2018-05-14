//
//  Level.m
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/8/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//
#import "Level.h"

@interface Level()
@end


@implementation Level


-(id)initWithNameAndLevel: (NSString*) name levelId: (int) levelId imageName:(NSString*) imageName isLocked: (BOOL) locked fileName:(NSString*) fileName;
{
    if( (self=[super init] ))
    {
        self.name = name;
        self.levelId = levelId;
        self.imageName = imageName;
        self.isCompleted = locked;
        self.fileName = fileName;
    }
    
    return self;
    
}

- (BOOL) isCompleted
{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //Uncomment line below to mark all levels a completed
    //[defaults setBool:NO forKey:[NSString stringWithFormat:@"%@-completed", self.fileName]];
    BOOL isComp = [defaults boolForKey:[NSString stringWithFormat:@"%@-completed", self.fileName]];


    return isComp;
}

- (void) setIsCompleted:(BOOL)locked
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(locked)
    {
        [defaults setBool:YES forKey:[NSString stringWithFormat:@"%@-completed", self.fileName]];
        [defaults synchronize];
    } else
    {
        [defaults setBool:NO forKey:[NSString stringWithFormat:@"%@-completed", self.fileName]];
        [defaults synchronize];
    }
}

@end
