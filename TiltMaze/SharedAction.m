//
//  ShareAction.m
//  LabyrinthTiltMaze
//
//  Created by Butler, David {BIS} on 4/26/14.
//  Copyright (c) 2014 Dave Butler. All rights reserved.
//

#import "SharedAction.h"

@implementation SharedAction


- (void)loadSharedAssets
{

    //Setup the rolling sound
    NSError *error;
    NSURL *rollingURL =[[NSBundle mainBundle] URLForResource:@"ball_roll2" withExtension:@"m4a"];
    self.rollingSound = [[AVAudioPlayer alloc] initWithContentsOfURL:rollingURL error:&error];
    self.rollingSound.numberOfLoops = -1;
    self.rollingSound.volume = 0.02f;
    [self.rollingSound prepareToPlay];

    NSURL *laserURL =[[NSBundle mainBundle] URLForResource:@"Laser" withExtension:@"m4a"];
    self.laserSound = [[AVAudioPlayer alloc] initWithContentsOfURL:laserURL error:&error];
    self.laserSound.numberOfLoops = -1;
    self.laserSound.volume = 0.1f;
    [self.laserSound prepareToPlay];
    

    //Setup the button click sound
    NSURL *buttonURL =[[NSBundle mainBundle] URLForResource:@"008619895-wood-plank-movement-02" withExtension:@"mp3"];
    self.buttonSound = [[AVAudioPlayer alloc] initWithContentsOfURL:buttonURL error:&error];
    self.buttonSound.numberOfLoops = 0;
    self.buttonSound.volume = 0.7f;
    [self.buttonSound prepareToPlay];

    NSURL *backgroundMusicURL =[[NSBundle mainBundle] URLForResource:@"Marble Game" withExtension:@"m4a"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    self.backgroundMusicPlayer.volume = 0.07f;
    [self.backgroundMusicPlayer prepareToPlay];
    //[self.backgroundMusicPlayer play];
    
    NSURL *blackHoleURL =[[NSBundle mainBundle] URLForResource:@"008900349-vortex" withExtension:@"mp3"];
    self.blackHoleSound = [[AVAudioPlayer alloc] initWithContentsOfURL: blackHoleURL error:&error];
    self.blackHoleSound.numberOfLoops = 0;
    self.blackHoleSound.volume = 0.6f;
    [self.blackHoleSound prepareToPlay];
    
    NSURL *electrocutionURL =[[NSBundle mainBundle] URLForResource:@"006142270-electrical-burst-02" withExtension:@"mp3"];
    self.electrocutionSound = [[AVAudioPlayer alloc] initWithContentsOfURL: electrocutionURL error:&error];
    self.electrocutionSound.numberOfLoops = 0;
    self.electrocutionSound.volume = 0.8f;
    [self.electrocutionSound prepareToPlay];
    
    if ( error )
    {
        NSLog(@"Error: %@", error.localizedDescription);
    }

}

-(void) stopAllSounds
{
    [self.rollingSound stop];
    [self.laserSound pause];
    [self.electrocutionSound stop];
    [self.rollingSound stop];
    [self.buttonSound stop];
    
}

-(void) pauseAllSounds
{
    self.wasBounceSoundPlaying=NO;
    self.wasLaserSoundPlaying=NO;
    self.wasBlackHoleSoundPlaying=NO;
    self.wasElectrocutionSoundPlaying=NO;
    self.wasBackgroundMusicPlayerPlaying=NO;


    if(self.rollingSound.playing)
    {
        [self.rollingSound pause];
        self.wasRollingSoundPlaying=YES;
    }

    if(self.laserSound.playing)
    {
        [self.laserSound pause];
        self.wasLaserSoundPlaying=YES;
    }
    
    if(self.electrocutionSound.playing)
    {
        [self.electrocutionSound pause];
        self.wasElectrocutionSoundPlaying=YES;
    }
    
    if(self.buttonSound.playing)
    {
        [self.buttonSound pause];
        self.wasButtonSoundPlaying=YES;
    }
    
    if(self.blackHoleSound.playing)
    {
        [self.blackHoleSound pause];
        self.wasBlackHoleSoundPlaying=YES;
    }
    
    if(self.backgroundMusicPlayer.playing)
    {
        [self.backgroundMusicPlayer pause];
        self.wasBackgroundMusicPlayerPlaying=YES;
    }
}

-(void) resumeAllSounds
{

    if(self.wasRollingSoundPlaying)
    {
        [self.rollingSound play];
    }

    if(self.wasLaserSoundPlaying)
    {
        [self.laserSound play];
    }
    
    if(self.wasElectrocutionSoundPlaying)
    {
        [self.electrocutionSound play];
    }
    
    if(self.wasButtonSoundPlaying)
    {
        [self.buttonSound play];
    }
    
    if(self.wasBlackHoleSoundPlaying)
    {
        [self.blackHoleSound play];
    }
    
    if(self.wasBackgroundMusicPlayerPlaying)
    {
        [self.backgroundMusicPlayer play];
    }
    
}

@end
