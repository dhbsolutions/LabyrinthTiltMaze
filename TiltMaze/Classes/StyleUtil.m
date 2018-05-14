//
//  StyleUtil.m
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/8/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "StyleUtil.h"

@implementation StyleUtil

+(void)styleButton:(UIButton*) button {
    
    if (button == nil) {
        return;
    }
    
    button.titleLabel.opaque = NO;
    button.titleLabel.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    button.titleLabel.textColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    button.titleLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];
    button.titleLabel.shadowOffset = CGSizeMake(0, -1);
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [button.layer setCornerRadius:8.0f];
    [button.layer setMasksToBounds:YES];
    button.backgroundColor = [UIColor colorWithRed:(1.0 * 45) / 255 green:(1.0 * 43) / 255 blue:(1.0 * 40) / 255 alpha:0.9];
    button.titleEdgeInsets = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [button.layer setBorderWidth:1.0f];
    [button.layer setBorderColor:[[UIColor blackColor] CGColor]];
    button.titleLabel.font = [UIFont fontWithName:@"Avenir Book" size:16];
    
    button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width + 6, button.frame.size.height + 3);
}

+(void)styleMenuButton:(UIButton*) button {
    
    if (button == nil) {
        return;
    }
    
    [StyleUtil styleButton:button];
    [button setTitleColor:[UIColor colorWithRed:(1.0 * 255) / 255 green:(1.0 * 241) / 255 blue:(1.0 * 70) / 255 alpha:0.9] forState: UIControlStateHighlighted];
}

+(void)styleNodeLabel:(UILabel*) label {
    label.textColor = [UIColor blackColor];
    
    label.backgroundColor = [UIColor colorWithRed:(1.0 * 170) / 255 green:(1.0 * 170) / 255 blue:(1.0 * 170) / 255 alpha:0.2];
    label.layer.cornerRadius = 6;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        label.font = [UIFont fontWithName:@"Avenir" size: 18.0];
    } else {
        label.font = [UIFont fontWithName:@"Avenir" size: 11.0];
    }
    
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    
    label.frame = CGRectMake(0, 0, label.frame.size.width + 6, label.frame.size.height + 3);
}

+(void)styleLabel:(UILabel*) label {
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"Avenir" size: 18.0];
}

+(void)animateView:(UIView*) view {
    view.alpha = 0;
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:0.5];
    view.alpha = 1;
    [UIView commitAnimations];
    
}

+(void)advance {
  //  [[SimpleAudioEngine sharedEngine] playEffect:@"Advance.m4a"];
}

+(void)regress {
  //  [[SimpleAudioEngine sharedEngine] playEffect:@"Regress.m4a"];
}

+(void)newLevel {
  //  [[SimpleAudioEngine sharedEngine] playEffect:@"NewLevel.m4a"];
}

@end
