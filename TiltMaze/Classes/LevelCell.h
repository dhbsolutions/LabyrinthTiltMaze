//
//  LevelCell.h
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/8/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Level.h"
/**
 * This class handles the UI for the cell for each level in the level
 * chooser and the cell for each layer set in the menus we use for iPad.
 */
@interface LevelCell: UICollectionViewCell

/**
 * Set if this cell should show a border.  True if it should and
 * false if it shouldn't.
 */
-(void)setBorderVisible:(bool) visible;

@property (nonatomic, retain) Level* level;

/**
 * The title label for cell in the table.
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 * The main image for the call which shows a thumbnail of the level
 */
@property (weak, nonatomic) IBOutlet UIImageView *screenshot;

/**
 * The check mark which shows in the upper right corner once you've won a level.
 */
@property (weak, nonatomic) IBOutlet UIImageView *checkMark;


@end
