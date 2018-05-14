//
//  MainScreenViewController.h
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/7/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <iAd/iAd.h>

@interface MainScreenViewController  : UIViewController <ADBannerViewDelegate>
{

}

@property (nonatomic) ADBannerView *bannerView;
@property (strong, nonatomic) IBOutlet UIButton *buttonPlay;

@end
