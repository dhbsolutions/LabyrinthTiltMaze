//
//  ShareAction.h
//  LabyrinthTiltMaze
//
//  Created by Butler, David {BIS} on 4/26/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@import AVFoundation;

@interface SharedAction : NSObject

- (void)loadSharedAssets;
-(void) stopAllSounds;
-(void) resumeAllSounds;
-(void) pauseAllSounds;

@property (nonatomic) AVAudioPlayer *rollingSound;
@property (nonatomic) AVAudioPlayer *bounceSound;
@property (nonatomic) AVAudioPlayer *laserSound;
@property (nonatomic) AVAudioPlayer *buttonSound;
@property (nonatomic) AVAudioPlayer *blackHoleSound;
@property (nonatomic) AVAudioPlayer *electrocutionSound;
@property (nonatomic) AVAudioPlayer *backgroundMusicPlayer;

@property (nonatomic) BOOL wasRollingSoundPlaying;
@property (nonatomic) BOOL wasBounceSoundPlaying;
@property (nonatomic) BOOL wasLaserSoundPlaying;
@property (nonatomic) BOOL wasButtonSoundPlaying;
@property (nonatomic) BOOL wasBlackHoleSoundPlaying;
@property (nonatomic) BOOL wasElectrocutionSoundPlaying;
@property (nonatomic) BOOL wasBackgroundMusicPlayerPlaying;

@end

static SKAction *sharedMissileLaunchSoundAction;

