//
//  FileUtil.m
//  TiltMaze
//
//  Created by Butler, David {BIS} on 2/9/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

#pragma mark -
#pragma mark Variable synthesize Declaration

#pragma mark -
#pragma mark Custom Functions

/*******************************************************************************************************
 * To get file URl of the .dt5 file in documents directory
 *******************************************************************************************************/
-(NSURL*) getFileUrl: (NSString*) fileName

{
    NSURL* fileUrl;
	
    NSString *resourceFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];

            
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath: resourceFilePath];

    if (fileExists)
    {
        fileUrl = [NSURL fileURLWithPath: resourceFilePath];
    }
 
	return fileUrl;
}

-(NSString *)readFile:(NSURL *)url
{
    NSStringEncoding encoding;
    NSError *error;

    NSString *result = [[NSString alloc] initWithContentsOfURL:url usedEncoding:&encoding error:&error];
    return result;
    
}



-(NSString*) getFileContents: (NSString*) fileName
{
    @autoreleasepool
    {
	
	// Copy the database from the package to the users filesystem
	//[fileManager copyItemAtPath:databasePathFromApp toPath:self.databasePath error:nil];


        NSURL *url = [self getFileUrl: fileName];
        if (url == nil) {
            return FALSE;
        }
    
        NSString *fileString = [self readFile: url];
        // insert code here...
        //NSLog(@"%@", fileString);
    
        return fileString;
    }
}


/*******************************************************************************************************
 This is to remove/ delete the file at given URL.
 *******************************************************************************************************/
-(BOOL)deleteFileAtUrl:(NSURL*) url
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	return [fileManager removeItemAtURL:url error:nil];
}

/*******************************************************************************************************
 This is to remove/ delete the file at given URL.
 *******************************************************************************************************/
-(BOOL)deleteFileAtPath:(NSString*) path
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	return [fileManager removeItemAtPath:path error:nil];
}


#pragma mark -

@end
