//
//  SelectLevelViewController.m
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/7/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//
#import "SelectLevelViewController.h"
#import "StyleUtil.h"
#import "GameSceneViewController.h"
#import "LevelCell.h"
#import "Level.h"
#import "LevelSet.h"
#import "StyleUtil.h"
#import "ScaleUtil.h"
#import "AppDelegate.h"

@interface SelectLevelViewController ()

    @property (nonatomic) int noOfSection;
    @property (nonatomic, retain) NSMutableArray* arrayOfLevels;
    @property (strong, nonatomic) IBOutlet UIButton *backButton;
    //@property (nonatomic, retain) Level* selectedLevel;

@end

@implementation SelectLevelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"refreshProgressViews" object:nil];

  
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    //[StyleUtil styleMenuButton:self.backBtn];
    self.noOfSection = 3;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
    
        self.backButton.frame = CGRectMake(self.backButton.bounds.origin.x,
                                            self.backButton.bounds.origin.y + 66,
                                            self.backButton.bounds.size.width,
                                            self.backButton.bounds.size.height * 1.5);

        self.collectionView.frame = CGRectMake(self.collectionView.bounds.origin.x,
                                            self.collectionView.bounds.origin.y + 140,
                                            self.collectionView.bounds.size.width,
                                            self.collectionView.bounds.size.height - (self.backButton.bounds.size.height * .5));
    }
    
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];

    LevelSet* levelSet = [appDelegate.arrayOfLevelSets objectAtIndex: appDelegate.currentLevelSetIndex ] ;
 
 
    self.arrayOfLevels = levelSet.levels;
 
    
    [self.collectionView reloadData];
}

-(void)refresh {
    [self.collectionView reloadData];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark Collection
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*) collectionView
{
 /*   if ([[LevelMgr getLevelSet:self.currentSet].levelIds count] % _noOfSection == 0) {
        return [[LevelMgr getLevelSet:self.currentSet].levelIds count] / _noOfSection;
    } else {
        return ([[LevelMgr getLevelSet:self.currentSet].levelIds count] / _noOfSection) + 1;
    }*/
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //NSLog(@"arrayOfLevels count=%lu", (unsigned long)[self.arrayOfLevels count]);
    return [self.arrayOfLevels count];
}

/**
 * Create each cell in the collection view that we use to select levels on the iPad
 */
-(UICollectionViewCell*) collectionView:(UICollectionView*) collectionView cellForItemAtIndexPath:(NSIndexPath*) indexPath
{
    static NSString *cellIdentifier = @"levelCell";
    Level* level = (Level*) [self.arrayOfLevels objectAtIndex: indexPath.item];
    
    
    LevelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
        [cell.screenshot setImage:[UIImage imageNamed: level.imageName]];
        [cell.checkMark setImage:nil];
        //[cell setBorderVisible:true];
        cell.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:16];
        cell.level = level;
        [cell.titleLabel setText: level.name];
        //[cell setBorderVisible:false];

        if(level.isCompleted)
        {
            [cell.checkMark setHidden:NO];
            [cell.checkMark setImage:[UIImage imageNamed: @"greenCheck@2x.png"]] ;
        } else
        {
            [cell.checkMark setHidden:YES];
        }
    
    // Return the cell
    return cell;
    
}


/**
 * This method gets called when the user taps on a cell in the collection view.
 */
- (void)collectionView:(UICollectionView*) collectionView didSelectItemAtIndexPath:(NSIndexPath*) indexPath {
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate.sharedActions.buttonSound play];

    int index = (int) indexPath.section * self.noOfSection + (int) indexPath.row;

    appDelegate.currentLevelIndex=index;
    [self performSegueWithIdentifier:@"segueToGame" sender:self];

}

- (IBAction)buttonBackPressed:(id)sender
{
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    [appDelegate.sharedActions.buttonSound play];
    //NSLog([self.collectionView ])
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark  notifications / buttons pressed
//Handle Notification
- (void)handleNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:@"refreshProgressViews"])
    {
        [self.collectionView reloadData];
    }
}

#pragma mark -
#pragma mark segue
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueToGame"])
    {
    /*if ([sender isKindOfClass:[LevelCell class]])
    {
        LevelCell *cell = sender;
        
        // set something on destination with a value from the cell
        GameSceneViewController* vc = [segue destinationViewController];
        
        //vc.selectedLevel = cell.level;
        NSLog(@"prepartForSeque  Levl=%@", cell.level.fileName);
    }*/

    }
}


@end
