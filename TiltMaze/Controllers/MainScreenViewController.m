//
//  MainScreenViewController.m
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/7/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import "MainScreenViewController.h"
#import "ScaleUtil.h"
#import "MainScreenScene.h"
#import "AppDelegate.h"
#import "LevelSet.h"
#import "Level.h"

@interface MainScreenViewController ()
@property (nonatomic) BOOL didLayoutSubviews;
-(void) buttonPlayGamePressed;
-(void) buttonOptionsPressed;
-(void) buttonCreditsPressed;

@end

@implementation MainScreenViewController

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
    
    // Listen for buttons pressed from the Scene
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"buttonPlayGamePressed" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"buttonOptionsPressed" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"buttonCreditsPressed" object:nil];
    
    self.bannerView = [[[ScaleUtil alloc] init] getADBanner];

    self.bannerView.delegate=self;
    
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
    MainScreenScene * scene = [MainScreenScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;


    // Present the scene.
    [skView presentScene:scene];

    [self loadLevels];

}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if ( !self.didLayoutSubviews )
    {

    }
    
    self.didLayoutSubviews = YES;
}


-(void) loadLevels
{

    NSMutableArray *lsArray = [[NSMutableArray alloc] init];
    
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];

    appDelegate.arrayOfLevelSets = [[NSMutableArray alloc] init];

    NSMutableArray *packminus1Levels = [[NSMutableArray alloc] init];
    
    [packminus1Levels addObject:[[Level alloc] initWithNameAndLevel: @"1" levelId:1 imageName: @"Level99_1" isLocked:NO fileName:@"Level99_1.txt"] ];
    [packminus1Levels addObject:[[Level alloc] initWithNameAndLevel: @"2" levelId:1 imageName: @"Level99_2" isLocked:NO fileName:@"Level99_2.txt"] ];
    [packminus1Levels addObject:[[Level alloc] initWithNameAndLevel: @"3" levelId:1 imageName: @"Level99_3" isLocked:NO fileName:@"Level99_3.txt"] ];
    [packminus1Levels addObject:[[Level alloc] initWithNameAndLevel: @"4" levelId:1 imageName: @"Level99_4" isLocked:NO fileName:@"Level99_4.txt"] ];
    [packminus1Levels addObject:[[Level alloc] initWithNameAndLevel: @"5" levelId:1 imageName: @"Level99_5" isLocked:NO fileName:@"Level99_5.txt"] ];
    
    LevelSet *packminus1LevelSet = [[LevelSet alloc] initWithName:@"Easy" identifier: @"Easy" index:99 levels: packminus1Levels];
    packminus1LevelSet.isUnlocked=YES;
    [lsArray addObject: packminus1LevelSet];
    

    
    NSMutableArray *pack0Levels = [[NSMutableArray alloc] init];
    
    [pack0Levels addObject:[[Level alloc] initWithNameAndLevel: @"1" levelId:1 imageName: @"Level0_1" isLocked:NO fileName:@"Level0_1.txt"] ];
    [pack0Levels addObject:[[Level alloc] initWithNameAndLevel: @"2" levelId:1 imageName: @"Level0_2" isLocked:NO fileName:@"Level0_2.txt"] ];
    [pack0Levels addObject:[[Level alloc] initWithNameAndLevel: @"3" levelId:1 imageName: @"Level0_3" isLocked:NO fileName:@"Level0_3.txt"] ];
    [pack0Levels addObject:[[Level alloc] initWithNameAndLevel: @"4" levelId:1 imageName: @"Level0_4" isLocked:NO fileName:@"Level0_4.txt"] ];
    [pack0Levels addObject:[[Level alloc] initWithNameAndLevel: @"5" levelId:1 imageName: @"Level0_5" isLocked:NO fileName:@"Level0_5.txt"] ];
   
    LevelSet *pack0LevelSet = [[LevelSet alloc] initWithName:@"Beginner" identifier: @"Beginner" index:0 levels: pack0Levels];
    pack0LevelSet.isUnlocked=YES;
    [lsArray addObject: pack0LevelSet];


    NSMutableArray *pack1Levels = [[NSMutableArray alloc] init];
    
    [pack1Levels addObject:[[Level alloc] initWithNameAndLevel: @"1-1" levelId:1 imageName: @"Level1_1" isLocked:NO fileName:@"Level1_1.txt"] ];
    [pack1Levels addObject:[[Level alloc] initWithNameAndLevel: @"1-2" levelId:1 imageName: @"Level1_2" isLocked:NO fileName:@"Level1_2.txt"] ];
    [pack1Levels addObject:[[Level alloc] initWithNameAndLevel: @"1-3" levelId:1 imageName: @"Level1_3" isLocked:NO fileName:@"Level1_3.txt"] ];
    [pack1Levels addObject:[[Level alloc] initWithNameAndLevel: @"1-4" levelId:1 imageName: @"Level1_4" isLocked:NO fileName:@"Level1_4.txt"] ];
    [pack1Levels addObject:[[Level alloc] initWithNameAndLevel: @"1-5" levelId:1 imageName: @"Level1_5" isLocked:NO fileName:@"Level1_5.txt"] ];
    [pack1Levels addObject:[[Level alloc] initWithNameAndLevel: @"1-6" levelId:1 imageName: @"Level1_6" isLocked:NO fileName:@"Level1_6.txt"] ];
    [pack1Levels addObject:[[Level alloc] initWithNameAndLevel: @"1-7" levelId:1 imageName: @"Level1_7" isLocked:NO fileName:@"Level1_7.txt"] ];
    [pack1Levels addObject:[[Level alloc] initWithNameAndLevel: @"1-8" levelId:1 imageName: @"Level1_8" isLocked:NO fileName:@"Level1_8.txt"] ];
    [pack1Levels addObject:[[Level alloc] initWithNameAndLevel: @"1-9" levelId:1 imageName: @"Level1_9" isLocked:NO fileName:@"Level1_9.txt"] ];
    [pack1Levels addObject:[[Level alloc] initWithNameAndLevel: @"1-10" levelId:1 imageName: @"Level1_10" isLocked:NO fileName:@"Level1_10.txt"] ];

   
    LevelSet *pack1LevelSet = [[LevelSet alloc] initWithName:@"Level Pack 1" identifier: @"LevelSet0" index:1 levels:pack1Levels];
    //pack1LevelSet.isUnlocked=YES;
    [lsArray addObject: pack1LevelSet];


     NSMutableArray *pack2Levels = [[NSMutableArray alloc] init];

    [pack2Levels addObject:[[Level alloc] initWithNameAndLevel: @"2-1" levelId:1 imageName: @"Level2_1" isLocked:NO fileName:@"Level2_1.txt"] ];
    [pack2Levels addObject:[[Level alloc] initWithNameAndLevel: @"2-2" levelId:1 imageName: @"Level2_2" isLocked:NO fileName:@"Level2_2.txt"] ];
    [pack2Levels addObject:[[Level alloc] initWithNameAndLevel: @"2-3" levelId:1 imageName: @"Level2_3" isLocked:NO fileName:@"Level2_3.txt"] ];
    [pack2Levels addObject:[[Level alloc] initWithNameAndLevel: @"2-4" levelId:1 imageName: @"Level2_4" isLocked:NO fileName:@"Level2_4.txt"] ];
    [pack2Levels addObject:[[Level alloc] initWithNameAndLevel: @"2-5" levelId:1 imageName: @"Level2_5" isLocked:NO fileName:@"Level2_5.txt"] ];
    [pack2Levels addObject:[[Level alloc] initWithNameAndLevel: @"2-6" levelId:1 imageName: @"Level2_6" isLocked:NO fileName:@"Level2_6.txt"] ];
    [pack2Levels addObject:[[Level alloc] initWithNameAndLevel: @"2-7" levelId:1 imageName: @"Level2_7" isLocked:NO fileName:@"Level2_7.txt"] ];
    [pack2Levels addObject:[[Level alloc] initWithNameAndLevel: @"2-8" levelId:1 imageName: @"Level2_8" isLocked:NO fileName:@"Level2_8.txt"] ];
    [pack2Levels addObject:[[Level alloc] initWithNameAndLevel: @"2-9" levelId:1 imageName: @"Level2_9" isLocked:NO fileName:@"Level2_9.txt"] ];
    [pack2Levels addObject:[[Level alloc] initWithNameAndLevel: @"2-10" levelId:1 imageName: @"Level2_10" isLocked:NO fileName:@"Level2_10.txt"] ];

    [lsArray addObject:[[LevelSet alloc] initWithName:@"Level Pack 2" identifier: @"LevelSet2" index:2 levels:pack2Levels]];


     NSMutableArray *levelPack3Levels = [[NSMutableArray alloc] init];
    [levelPack3Levels addObject:[[Level alloc] initWithNameAndLevel: @"3-1" levelId:1 imageName: @"Level3_1" isLocked:NO fileName:@"Level3_1.txt"] ];
    [levelPack3Levels addObject:[[Level alloc] initWithNameAndLevel: @"3-2" levelId:1 imageName: @"Level3_2" isLocked:NO fileName:@"Level3_2.txt"] ];
    [levelPack3Levels addObject:[[Level alloc] initWithNameAndLevel: @"3-3" levelId:1 imageName: @"Level3_3" isLocked:NO fileName:@"Level3_3.txt"] ];
    [levelPack3Levels addObject:[[Level alloc] initWithNameAndLevel: @"3-4" levelId:1 imageName: @"Level3_4" isLocked:NO fileName:@"Level3_4.txt"] ];
    [levelPack3Levels addObject:[[Level alloc] initWithNameAndLevel: @"3-5" levelId:1 imageName: @"Level3_5" isLocked:NO fileName:@"Level3_5.txt"] ];
    [levelPack3Levels addObject:[[Level alloc] initWithNameAndLevel: @"3-6" levelId:1 imageName: @"Level3_6" isLocked:NO fileName:@"Level3_6.txt"] ];
    [levelPack3Levels addObject:[[Level alloc] initWithNameAndLevel: @"3-7" levelId:1 imageName: @"Level3_7" isLocked:NO fileName:@"Level3_7.txt"] ];
    [levelPack3Levels addObject:[[Level alloc] initWithNameAndLevel: @"3-8" levelId:1 imageName: @"Level3_8" isLocked:NO fileName:@"Level3_8.txt"] ];
    [levelPack3Levels addObject:[[Level alloc] initWithNameAndLevel: @"3-9" levelId:1 imageName: @"Level3_9" isLocked:NO fileName:@"Level3_9.txt"] ];
    [levelPack3Levels addObject:[[Level alloc] initWithNameAndLevel: @"3-10" levelId:1 imageName: @"Level3_10" isLocked:NO fileName:@"Level3_10.txt"] ];
  
    [lsArray addObject:[[LevelSet alloc] initWithName:@"Level Pack 3" identifier: @"LevelSet3" index:3 levels:levelPack3Levels]];

   
     NSMutableArray *levelPack4Levels = [[NSMutableArray alloc] init];
    [levelPack4Levels addObject:[[Level alloc] initWithNameAndLevel: @"4-1" levelId:1 imageName: @"Level4_1" isLocked:NO fileName:@"Level4_1.txt"] ];
    [levelPack4Levels addObject:[[Level alloc] initWithNameAndLevel: @"4-2" levelId:1 imageName: @"Level4_2" isLocked:NO fileName:@"Level4_2.txt"] ];
    [levelPack4Levels addObject:[[Level alloc] initWithNameAndLevel: @"4-3" levelId:1 imageName: @"Level4_3" isLocked:NO fileName:@"Level4_3.txt"] ];
    [levelPack4Levels addObject:[[Level alloc] initWithNameAndLevel: @"4-4" levelId:1 imageName: @"Level4_4" isLocked:NO fileName:@"Level4_4.txt"] ];
    [levelPack4Levels addObject:[[Level alloc] initWithNameAndLevel: @"4-5" levelId:1 imageName: @"Level4_5" isLocked:NO fileName:@"Level4_5.txt"] ];
    [levelPack4Levels addObject:[[Level alloc] initWithNameAndLevel: @"4-6" levelId:1 imageName: @"Level4_6" isLocked:NO fileName:@"Level4_6.txt"] ];
    [levelPack4Levels addObject:[[Level alloc] initWithNameAndLevel: @"4-7" levelId:1 imageName: @"Level4_7" isLocked:NO fileName:@"Level4_7.txt"] ];
    [levelPack4Levels addObject:[[Level alloc] initWithNameAndLevel: @"4-8" levelId:1 imageName: @"Level4_8" isLocked:NO fileName:@"Level4_8.txt"] ];
    [levelPack4Levels addObject:[[Level alloc] initWithNameAndLevel: @"4-9" levelId:1 imageName: @"Level4_9" isLocked:NO fileName:@"Level4_9.txt"] ];
    [levelPack4Levels addObject:[[Level alloc] initWithNameAndLevel: @"4-10" levelId:1 imageName: @"Level4_10" isLocked:NO fileName:@"Level4_10.txt"] ];

    [lsArray addObject:[[LevelSet alloc] initWithName:@"Level Pack 4" identifier: @"LevelSet4" index:4 levels: levelPack4Levels]];
   

    [appDelegate.arrayOfLevelSets addObjectsFromArray:lsArray];
    
}

#pragma mark -
#pragma mark  notifications / buttons pressed
    //Handle Notification
 - (void)handleNotification:(NSNotification *)notification
 { 
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate.sharedActions.buttonSound play];
    if ([notification.name isEqualToString:@"buttonPlayGamePressed"])
    {
        [self buttonPlayGamePressed];
    } else if ([notification.name isEqualToString:@"buttonOptionsPressed"])
    {
        [self buttonOptionsPressed];
    } else if ([notification.name isEqualToString:@"buttonCreditsPressed"])
    {
        [self buttonCreditsPressed];
    }
 }

-(void) buttonPlayGamePressed
{
    [self performSegueWithIdentifier:@"segueSelectLevelSet" sender:self];
}

-(void) buttonOptionsPressed
{
    [self performSegueWithIdentifier:@"segueOptions" sender:self];
}


-(void) buttonCreditsPressed
{
    [self performSegueWithIdentifier:@"segueCredits" sender:self];
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
#pragma mark  Memory Management
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
