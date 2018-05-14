//
//  CreditScreenViewController.h
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/20/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <iAd/iAd.h>

@interface CreditScreenViewController : UIViewController <ADBannerViewDelegate>

@property (nonatomic) ADBannerView *bannerView;

@end
