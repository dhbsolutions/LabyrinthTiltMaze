//
//  CreditScreenViewController.m
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/20/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import "CreditScreenViewController.h"
#import "ScaleUtil.h"
#import "CreditScreenScene.h"
#import "AppDelegate.h"

@interface CreditScreenViewController ()

@end

@implementation CreditScreenViewController

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

    self.bannerView = [[[ScaleUtil alloc] init] getADBanner];

    self.bannerView.delegate=self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"buttonBackPressed" object:nil];

    // Optional to set background color to clear color
    [self.bannerView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview: self.bannerView];
//    [self.view autoresizesSubviews];

        // Configure the view.
        SKView * skView = (SKView *)self.view;
        //SET SCENE BOUNDRY
        //[skView setBounds: [ScaleUtil getSceneBoundry]];
        [skView setBounds: CGRectMake(0, 0, 768, 1024)];
        // Create and configure the scene.
        CreditScreenScene * scene = [CreditScreenScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;

    
        // Present the scene.
        [skView presentScene:scene];
}

#pragma mark -
#pragma mark iAd stuff
-(void) bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"Ad loaded");
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1];
    
    [banner setAlpha:1];
    //[bannerView.superview bringSubviewToFront:bannerView];
    
    [UIView commitAnimations];
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Error loading");
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1];
    
    [banner setAlpha:0];
    
    [UIView commitAnimations];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"Ad bannerViewActionShouldBegin");
     return YES;
}

-(void)bannerViewWillLoadAd:(ADBannerView *)banner
{
    NSLog(@"Ad will load");
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    NSLog(@"Ad did finish");
}

#pragma mark -
#pragma mark notifications / buttons pressed
//Handle Notification
- (void)handleNotification:(NSNotification *)notification
{
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate.sharedActions.buttonSound play];

    if ([notification.name isEqualToString:@"buttonBackPressed"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark Memory Management
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end