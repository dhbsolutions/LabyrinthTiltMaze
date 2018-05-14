//
//  ScaleUtil.h
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/12/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface ScaleUtil : NSObject

+ (CGPoint) positionGameScene;

+ (CGPoint) positionGameSceneBackButton: (CGPoint) gameScenePosition;

+ (CGRect) getSceneBoundry;

+ (CGPoint) getSceneCenterPoint: (CGRect) rect;

+ (CGRect) getMenuBoundry;

+ (CGPoint) getMenuCenterPoint: (CGRect) rect;

+ (CGSize) getMenuSize;

+ (CGPoint) positionMenuBackButton: (CGPoint) menuScenePosition;

- (ADBannerView*) getADBanner;

+ (CGPoint) getGameSceneCenterPoint: (CGRect) rect;

@end

