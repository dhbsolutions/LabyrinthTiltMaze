//
//  LevelSetViewController.m
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/29/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import "LevelSetViewController.h"
#import "LevelSetTableViewCell.h"
#import "LevelSet.h"
#import "AppDelegate.h"
#import "ScaleUtil.h"

@interface LevelSetViewController ()

@end

@implementation LevelSetViewController

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

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"refreshProgressViews" object:nil];

    // Do any additional setup after loading the view.
    self.levelSetTableView.delegate = self;
    self.levelSetTableView.dataSource = self;
    self.bannerView = [[[ScaleUtil alloc] init] getADBanner];
//    self.bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    [self.bannerView setBackgroundColor:[UIColor blackColor]];

    self.bannerView.delegate=self;
    [self.view addSubview:self.bannerView];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
    
        self.backButton.frame = CGRectMake(self.backButton.bounds.origin.x,
                                            self.backButton.bounds.origin.y + 66,
                                            self.backButton.bounds.size.width,
                                            self.backButton.bounds.size.height * 1.5);

        self.levelSetTableView.frame = CGRectMake(self.levelSetTableView.bounds.origin.x,
                                            self.levelSetTableView.bounds.origin.y + 140,
                                            self.levelSetTableView.bounds.size.width,
                                            self.levelSetTableView.bounds.size.height - (self.backButton.bounds.size.height * .5));
    }

}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Handle Notification
- (void)handleNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:@"refreshProgressViews"])
    {
        [self.levelSetTableView reloadData];
    }
}

- (IBAction)buttonBackPressed:(id)sender
{
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate.sharedActions.buttonSound play];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark TableView Delegate

/*
 *Table View Delegate methods implementation
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
  
  return [appDelegate.arrayOfLevelSets count];

}

// Customize the appearance of table view cells abc.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
  
  appDelegate.currentLevelSetIndex = (int) indexPath.row;
  
  LevelSet* levelSet = [appDelegate.arrayOfLevelSets objectAtIndex: appDelegate.currentLevelSetIndex];
  
  if(levelSet.isUnlocked)
  {
    [appDelegate.sharedActions.buttonSound play];
    [self performSegueWithIdentifier:@"segueSelectLevel" sender:self];
  }

}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];


    LevelSet* levelSet = [appDelegate.arrayOfLevelSets objectAtIndex: [indexPath row]];

    static NSString *cellIdentifier = @"levelSetCell";
    
    //DHB updated depreciated call
    LevelSetTableViewCell *cell = (LevelSetTableViewCell *)[tableView dequeueReusableCellWithIdentifier: cellIdentifier];

    if (cell == nil)
    {
        cell = [[LevelSetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
    }

     //NSLog(@"[indexPath row]=@%ld", (long)[indexPath row]);
    int row = (int)[indexPath row];
    
    if(row == 0)
    {
        [cell.woodImage setHidden: YES];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else
    {
        [cell.woodImage setHidden: NO];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    cell.levelSetNameLabel.text = [NSString stringWithFormat:@"%@", levelSet.name];
    cell.levelSetStatusLabel.text = [NSString stringWithFormat:@"%@", levelSet.status];
    if(levelSet.isUnlocked)
    {
        [cell.lockImage setHidden:YES];
        [cell.checkImage setHidden:NO];
    } else
    {
        [cell.lockImage setHidden:NO];
        [cell.checkImage setHidden:YES];
    }

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 86.0f;
}

// custom view for footer. will be adjusted to default or specified footer height
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	UIView *vwFooter = [[UIView alloc] init];
	vwFooter.frame = CGRectMake(0, 0, 0, 0);
	return vwFooter;
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


@end
