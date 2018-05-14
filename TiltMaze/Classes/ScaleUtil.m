//
//  ScaleUtil.m
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/12/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import "ScaleUtil.h"
#import <iAd/iAd.h>

@implementation ScaleUtil



+ (CGPoint) positionGameSceneBackButton: (CGPoint) gameScenePosition
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return CGPointMake(gameScenePosition.x -80, 990);//SHOULD BE 1020
    } else {
        if(IS_WIDESCREEN)
        {
            return CGPointMake(gameScenePosition.x -18, 1028);
        } else
        {
            return CGPointMake(gameScenePosition.x -310, 920);
        }
    }
}

+ (CGPoint) positionGameScene
{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return  CGPointMake(80.0f, -48.0f);
        } else {
            if(IS_WIDESCREEN)
            {
                return CGPointMake(16.0f, -48.0f);
            } else
            {
                return CGPointMake(44.0f, -42.0f);
            }
        }
}

+ (CGPoint) getGameSceneCenterPoint: (CGRect) rect
{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return CGPointMake((rect.size.width / 2)  /*- 48*/, (rect.size.height / 2) - 64);
        } else
        {
            if(IS_WIDESCREEN)
            {
                //DHB CHANGED THIS LINE******
                return CGPointMake((rect.size.width / 2), (rect.size.height / 2) -120);
            } else
            {
                //DHB CHANGED THIS LINE******
                return CGPointMake((rect.size.width / 2), (rect.size.height / 2) -40);//will move background
            }
        }
}



+ (CGRect) getSceneBoundry
{

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return CGRectMake(48, -32, 768, 1024);
    } else {
       if(IS_WIDESCREEN)
        {
            //DHB CHANGED THIS LINE******
            return CGRectMake(0, 32, 640, 1136);
        } else
        {
            //DHB CHANGED THIS LINE******
            //return CGRectMake(0, -16, 640, 960);
            return CGRectMake(0, -48, 695, 1050);
        }
    }
}
 /*       if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.world.position =  CGPointMake(80.0f, -48.0f);
        } else {
            //DHB CHANGED THIS LINE******
            //return CGPointMake(32 + point.x, 0 + point.y);
            self.world.position =  CGPointMake(16.0f, -48.0f);
        }*/


+ (CGPoint) getSceneCenterPoint: (CGRect) rect
{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return CGPointMake((rect.size.width / 2)  /*- 48*/, (rect.size.height / 2) - 32);
        } else
        {
            if(IS_WIDESCREEN)
            {
                //DHB CHANGED THIS LINE******
                return CGPointMake((rect.size.width / 2), (rect.size.height / 2) -120);
            } else
            {
                //DHB CHANGED THIS LINE******
                return CGPointMake((rect.size.width / 2), (rect.size.height / 2) -40);//will move background
            }
        }
}

+ (CGRect) getMenuBoundry
{

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return CGRectMake(0, 0, 768, 1024);
    } else {
       if(IS_WIDESCREEN)
        {
            //DHB CHANGED THIS LINE******
            return CGRectMake(0, 0, 640, 1136);
        } else
        {
            //DHB CHANGED THIS LINE******
            return CGRectMake(0, 0, 768, 1024);//640, 960);
        }
    }
}


+ (CGPoint) getMenuCenterPoint: (CGRect) rect
{
    return CGPointMake((rect.size.width / 2), (rect.size.height / 2) );
}


+ (CGSize) getMenuSize
{

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return CGSizeMake(768, 1024);
    } else {
       if(IS_WIDESCREEN)
        {
            //DHB CHANGED THIS LINE******
            return CGSizeMake(640, 1136);//568×320.
        } else
        {
            //DHB CHANGED THIS LINE******
            return CGSizeMake(768, 1024);//640, 960);
        }
    }
}

+ (CGPoint) positionMenuBackButton: (CGPoint) menuScenePosition
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return CGPointMake(menuScenePosition.x , 870);
    } else {
        if(IS_WIDESCREEN)
        {
            return CGPointMake(menuScenePosition.x -18, 878);
        } else
        {
            return CGPointMake(menuScenePosition.x , 860);
        }
    }
}



- (ADBannerView*) getADBanner
{
        ADBannerView* banner = [[ADBannerView alloc] initWithFrame:CGRectZero];
        [banner setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    

        return banner;
}

@end