//
//  LevelSetTableViewCell.h
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/29/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelSetTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *levelSetNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *levelSetStatusLabel;
@property (strong, nonatomic) IBOutlet UIImageView *lockImage;
@property (strong, nonatomic) IBOutlet UIImageView *checkImage;
@property (strong, nonatomic) IBOutlet UIImageView *woodImage;

@end
