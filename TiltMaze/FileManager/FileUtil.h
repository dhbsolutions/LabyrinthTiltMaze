//
//  FileUtil.h
//  TiltMaze
//
//  Created by Butler, David {BIS} on 2/9/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface FileUtil : NSObject {
	@private
}

/* To get the file URL*/
-(NSURL*) getFileUrl: (NSString*) fileName;

-(NSString*) getFileContents: (NSString*) fileName;

@end
