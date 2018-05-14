
//
//  GameSceneViewController.m
//  Tilt Maze
//
//  Created by Dave Butler on 01/01/2014.
//  Copyright (c) 2014 DHB Worlds. All rights reserved.
//

#import "GameSceneViewController.h"
#import "GameScene.h"
#import <QuartzCore/QuartzCore.h>
#import "ScaleUtil.h"
#import "AppDelegate.h"
#import "LevelPackCompletedViewController.h"

@interface GameSceneViewController ()
@property (nonatomic) BOOL didLayoutSubviews;
@property (nonatomic) GameScene* scene;
@property (nonatomic) SKView * skView;

@end


@implementation GameSceneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.bannerView = [[[ScaleUtil alloc] init] getADBanner];

    self.bannerView.delegate=self;
    
    // Optional to set background color to clear color
    [self.bannerView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview: self.bannerView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"buttonBackPressed" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"completedLevelPackSegue" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"layoutScene" object:nil];

    // Configure the view.
    self.skView = (SKView *)self.view;
    //skView.showsFPS = YES;
    //skView.showsNodeCount = YES;
    //skView.showsDrawCount = YES;
    //skView.showsPhysics=YES;
    
    [self layoutScene];
    [self.view autoresizesSubviews];

}

- (void) layoutScene
{
    //Recreating the Scene everytime in iOS 9.  Not sure why this was needed.
    //SET SCENE BOUNDRY
    self.scene = [GameScene sceneWithSize: [ScaleUtil getSceneBoundry].size];
    self.scene.scaleMode=SKSceneScaleModeFill;
    //[self.skView setBounds: [ScaleUtil getSceneBoundry]];
    
    // Create and configure the scene.
    
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene loadLevel];
    
    [self.skView presentScene: self.scene];

}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if ( !self.didLayoutSubviews )
    {
        // Play some background music
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
        [appDelegate.sharedActions.backgroundMusicPlayer play];
        
    }
    
    self.didLayoutSubviews = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate.sharedActions pauseAllSounds];
    
    [super viewDidDisappear:animated];
}

- (BOOL) shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark  notifications / buttons pressed
//Handle Notification
- (void)handleNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:@"buttonBackPressed"])
    {
        //Stop playing sounds
        AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
        [appDelegate.sharedActions stopAllSounds];
        [appDelegate.sharedActions.backgroundMusicPlayer pause];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshProgressViews" object:nil]; //Sends message to viewcontroller to show ad.
        [self dismissViewControllerAnimated:YES completion:nil];
        [appDelegate.sharedActions stopAllSounds];
        [appDelegate.sharedActions.backgroundMusicPlayer pause];
    } else if ([notification.name isEqualToString:@"completedLevelPackSegue"])
    {
        [self performSegueWithIdentifier:@"completedLevelPackSegue" sender:self];
    } else if  ([notification.name isEqualToString:@"layoutScene"])
    {
        [self layoutScene];
    }
}

#pragma mark -
#pragma mark iAd stuff
-(void) bannerViewDidLoadAd:(ADBannerView *)banner
{
    //NSLog(@"Ad loaded");
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1];
    
    [banner setAlpha:1];
    //[bannerView.superview bringSubviewToFront:bannerView];
    
    [UIView commitAnimations];
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    //NSLog(@"Error loading");
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1];
    
    [banner setAlpha:0];
    
    [UIView commitAnimations];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    //NSLog(@"Ad bannerViewActionShouldBegin");
    SKView *skView = (SKView *)self.view;
    skView.scene.paused = YES;
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate.sharedActions pauseAllSounds];
    
     return YES;
}

-(void)bannerViewWillLoadAd:(ADBannerView *)banner
{
    //NSLog(@"Ad will load");
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    //NSLog(@"Ad did finish");
    
    SKView *skView = (SKView *)self.view;
    skView.scene.paused = NO;
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate.sharedActions resumeAllSounds];
    

}

#pragma mark -
#pragma mark segue
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    
    if ([segue.identifier isEqualToString:@"completedLevelPackSegue"])
    {
        // set something on destination with a value from the cell
        LevelPackCompletedViewController* vc = [segue destinationViewController];
        [vc.textMessage setText: self.scene.completedMessageText];
    
        //NSLog(@"prepartForSeque completedLevelPackSegue");
    }
}

@end
