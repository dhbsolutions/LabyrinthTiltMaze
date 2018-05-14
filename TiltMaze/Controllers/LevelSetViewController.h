//
//  LevelSetViewController.h
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/29/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface LevelSetViewController : UIViewController<ADBannerViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
}
@property (strong, nonatomic) IBOutlet UIButton *backButton;

@property (nonatomic) ADBannerView *bannerView;
@property (strong, nonatomic) IBOutlet UITableView *levelSetTableView;
- (IBAction)buttonBackPressed:(id)sender;

@end
