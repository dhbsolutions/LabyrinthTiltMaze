//
//  LevelPackCompletedViewController.m
//  LabyrinthTiltMaze
//
//  Created by Butler, David {BIS} on 5/24/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import "LevelPackCompletedViewController.h"
#import "AppDelegate.h"

@interface LevelPackCompletedViewController ()

@end

@implementation LevelPackCompletedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)okButtonPressed:(id)sender {
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate.sharedActions.buttonSound play];
    //NSLog([self.collectionView ])
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshProgressViews" object:nil]; //Sends message to viewcontroller to show ad.
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"buttonBackPressed" object:nil]; //Sends message to viewcontroller to show ad.
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonBackPressed" object:nil]; //Sends message to viewcontroller to show ad.

}
@end
