//
//  PlayerViewController.h
//  toeflspeakingtimer
//
//  Created by tim on 2/28/14.
//  Copyright (c) 2014 tim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordStore.h"
#import <AVFoundation/AVFoundation.h>
#import <MessageUI/MessageUI.h>

@interface PlayerViewController : UIViewController<AVAudioPlayerDelegate,MFMailComposeViewControllerDelegate>{
    RecordStore *recordStore;
    
    
}


-(id)iniWithRecord:(NSInteger)row;
- (IBAction)playAndPause:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)forward:(id)sender;
- (IBAction)currentTimeSliderValueChanged:(id)sender;
- (IBAction)currentTimeSliderTouchUpInside:(id)sender;

-(void)setToinitial;
-(void)updateDisplay;
-(void)updateSliderLabels;
-(void)playRecord;
-(void)playPause;
-(void)shareRecord;

@property (nonatomic,strong) NSString * currentRecord;
@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UIButton *forward;
@property (weak, nonatomic) IBOutlet UIButton *playAndPause;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UISlider *Slider;
@property (nonatomic,strong) AVAudioPlayer *player;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic) BOOL playPressed;
@property (weak, nonatomic) IBOutlet UILabel *elapsedTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;

@end
