//
//  StyleUtil.h
//  TiltMaze
//
//  Created by Butler, David {BIS} on 3/8/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Style util is a simple class with utilities for styling
 * various UI controls.
 */
@interface StyleUtil : NSObject

/**
 * Style a button in the application.
 *
 * @param button the button to style
 */
+(void)styleButton:(UIButton*) button;

/**
 * Style a button in the application that's used as a navigation button
 * on one of the main game screens.
 *
 * @param button the button to style
 */
+(void)styleMenuButton:(UIButton*) button;

/**
 * Style a label that shows extra information about a node.
 *
 * @param label the label to style
 */
+(void)styleNodeLabel:(UILabel*) label;

/**
 * Style a label that shows up in a menu button
 *
 * @param label the label to style
 */
+(void)styleLabel:(UILabel*) label;

/**
 * Animate a view into the foreground with a fade effect
 */
+(void)animateView:(UIView*) view;

/**
 * Play the advance sound when you move forward in the game.
 */
+(void)advance;

/**
 * Play the regress sound when you move back to a previous screen in the game.
 */
+(void)regress;

/**
 * Play the new level sound.
 */
+(void)newLevel;


@end
