//
//  LevelSet.m
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/20/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import "LevelSet.h"
#import "Level.h"
#import "AppDelegate.h"

@interface LevelSet()

@end

@implementation LevelSet

-(id)initWithName: (NSString*) name identifier: (NSString*) identifier index: (int) index levels:(NSMutableArray*) levels
{
    if( (self=[super init] ))
    {
        self.name = name;
        self.levels = levels;
        self.identifier = identifier;
        self.index = index;
    
    }
    
    return self;
    
}

-(NSString*) status
{
    NSString *statusString;
    int totalLevels = (int) [self.levels count];
    int totalCompletedLevels = 0;
    /*self.isUnlocked=NO;
        for(int i = 0; i<[self.levels count];i++)
        {
            Level* level = [self.levels objectAtIndex:i];
        
            level.isCompleted=NO;
        }
        return NO;*/
    
    if(self.isUnlocked)
    {
        for(int i = 0; i<[self.levels count];i++)
        {
            Level* level = [self.levels objectAtIndex:i];
        
            if(level.isCompleted)
            {
                totalCompletedLevels++;
            }
        }

        statusString = [NSString stringWithFormat:@"Completed %d of %d levels.", totalCompletedLevels, totalLevels];
    }
    else
    {
    
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
          
        LevelSet* priorLevelSet = [appDelegate.arrayOfLevelSets objectAtIndex: self.index - 1];

        int totalLevels = (int) [priorLevelSet.levels count];
        int totalCompletedLevels = 0;
    
        for(int i = 0; i<[priorLevelSet.levels count];i++)
        {
            Level* level = [priorLevelSet.levels objectAtIndex:i];
        
            if(level.isCompleted)
            {
                totalCompletedLevels++;
            }
        }
    
        // If you complete all but 1 levelSet is unlocked.
        statusString = [NSString stringWithFormat:@"Complete %d more levels to unlock.", (totalLevels - totalCompletedLevels)];

    
    }
    return statusString;
}


- (BOOL) isUnlocked
{
    //DHB UNLOCK ALL LEVELS
    //return YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //if([self.identifier isEqualToString:@"LevelSet0"]) {return YES;}
    //    [defaults setBool:NO forKey:[NSString stringWithFormat:@"%@-unlocked", self.identifier]];
    //    return NO;
    BOOL isUnlcked = [defaults boolForKey:[NSString stringWithFormat:@"%@-unlocked", self.identifier]];

    // Wasnt recorded as Completed, but check the prior levelSet, just in case
    if(!isUnlcked && self.index > 0)
    {
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
          
        LevelSet* priorLevelSet = [appDelegate.arrayOfLevelSets objectAtIndex: self.index -1];

        int totalLevels = (int) [priorLevelSet.levels count];
        int totalCompletedLevels = 0;
    
        for(int i = 0; i<[priorLevelSet.levels count];i++)
        {
            Level* level = [priorLevelSet.levels objectAtIndex:i];
        
            if(level.isCompleted)
            {
                totalCompletedLevels++;
            }
        }
    
        // If you complete all but 1 levelSet is unlocked.
        if(totalCompletedLevels >= totalLevels)
        {
            [self setIsUnlocked: YES];
            return YES;
        }
    
        return isUnlcked;

    }

    return isUnlcked;
}

- (void) setIsUnlocked:(BOOL)isUnlocked
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(isUnlocked)
    {
        [defaults setBool:YES forKey:[NSString stringWithFormat:@"%@-unlocked", self.identifier]];
        [defaults synchronize];
    } else
    {
        [defaults setBool:NO forKey:[NSString stringWithFormat:@"%@-unlocked", self.identifier]];
        [defaults synchronize];
    }
}



@end
