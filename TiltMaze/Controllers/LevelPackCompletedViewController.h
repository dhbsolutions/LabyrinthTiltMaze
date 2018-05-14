//
//  LevelPackCompletedViewController.h
//  LabyrinthTiltMaze
//
//  Created by Butler, David {BIS} on 5/24/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelPackCompletedViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *textMessage;
- (IBAction)okButtonPressed:(id)sender;
@end
