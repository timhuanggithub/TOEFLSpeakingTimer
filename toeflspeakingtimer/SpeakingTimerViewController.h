//
//  SpeakingTimerViewController.h
//  TOEFLSpeakingTimer
//
//  Created by tim on 12/24/13.
//  Copyright (c) 2013 tim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SpeakingTimerViewController : UIViewController<AVAudioPlayerDelegate,AVAudioRecorderDelegate>{
    NSTimer *prepareTimer;
    NSTimer *speakingTimer;
    BOOL startButtonPressed;
    NSInteger iForArray;
    AVAudioRecorder *speakingRecorder;
    AVAudioSession *session;
    AVAudioPlayer *recordPlayer;
    AVAudioPlayer *speak;
    AVAudioPlayer *prepare;
    AVAudioPlayer *beep;
    BOOL ButtonSwaped;
    
}



@property NSInteger initalSpeakingTime;
@property NSInteger initalPrepareTime;
@property NSInteger remainingSpeakingTime;
@property NSInteger remainingPrepareTime;
@property NSInteger initalReadingTime;
@property NSInteger remainingReadingTime;
@property (weak, nonatomic) IBOutlet UITextView *questionDescription;

@property NSArray *playOrder;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;
@property (strong, nonatomic) IBOutlet UIView *SpeakingTimerView;
@property (weak, nonatomic) IBOutlet UIButton *saveToRecord;
@property (weak, nonatomic) IBOutlet UIButton *playRecord;
@property NSInteger currentQuestion;


@property (weak, nonatomic) IBOutlet UIButton *startStopButton;
- (IBAction)pressStartButton:(id)sender;
- (id)initWithPressedButton:(UIButton *)pressedButton;
-(void)setToIntial;
- (IBAction)pressSaveToRecord:(id)sender;
- (IBAction)pressPlayRecordButton:(id)sender;
-(void)swapButtonPostion:(UIButton *)button1 with:(UIButton *) button2;





@end
