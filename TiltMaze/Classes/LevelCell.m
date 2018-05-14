//
//  LevelCell.m
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/8/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import "LevelCell.h"
#import "StyleUtil.h"
#import <QuartzCore/QuartzCore.h>

@implementation LevelCell


-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        
        
        /*NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"LevelCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        self = [arrayOfViews objectAtIndex:0] ;*/
        [StyleUtil styleLabel:self.titleLabel];
    }
    
    return self;
}

-(void)setBorderVisible:(bool) visible {
    if (visible) {
        [self.screenshot.layer setCornerRadius:8.0f];
        [self.screenshot.layer setMasksToBounds:YES];
        self.screenshot.layer.borderColor = [UIColor colorWithRed:(1.0 * 170) / 255 green:(1.0 * 170) / 255 blue:(1.0 * 170) / 255 alpha:0.5].CGColor;
        self.screenshot.layer.borderWidth = 2.0f;
    } else {
        self.screenshot.layer.borderColor = [[UIColor clearColor] CGColor];
    }
}

@end
