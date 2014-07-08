//
//  PlayerViewController.m
//  toeflspeakingtimer
//
//  Created by tim on 2/28/14.
//  Copyright (c) 2014 tim. All rights reserved.
//

#import "PlayerViewController.h"


@interface PlayerViewController ()

@end

@implementation PlayerViewController


-(id)iniWithRecord:(NSInteger)row{
    recordStore = [[RecordStore alloc]init];
    _currentRecord= [recordStore.fileArray objectAtIndex:row];
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    timeFormatter.dateFormat = @"hh:mm a";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];

    NSDictionary *fileAttribute = [recordStore getRecordAttribute:_currentRecord];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _questionLabel.textAlignment = NSTextAlignmentCenter;
    if (recordStore.questionType == 1) {
        _questionLabel.text = @"Q1Q2";
    }
    else if (recordStore.questionType == 2){
        _questionLabel.text = @"Q3Q4";
    }
    else if (recordStore.questionType == 3){
        _questionLabel.text = @"Q5Q6";
    }
    
    self.navigationItem.title = _questionLabel.text;
    
    _dateLabel.text = [timeFormatter stringFromDate:[fileAttribute fileCreationDate]];
    _timeLabel.text = [dateFormatter stringFromDate:[fileAttribute fileCreationDate]];
    
    _back.tintColor = [UIColor blackColor];
    [_back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    
    _playAndPause.tintColor = [UIColor blackColor];
    [_playAndPause setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
    
    _forward.tintColor = [UIColor blackColor];
    [_forward setImage:[UIImage imageNamed:@"forward.png"] forState:UIControlStateNormal];
    
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:[recordStore getURLFromFileName:_currentRecord] error:nil];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];

    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareRecord)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    _player.delegate = self;
    _Slider.minimumValue = 0.0f;
    _Slider.maximumValue = _player.duration;
    [self updateSliderLabels];
    [self setToinitial];
}



- (IBAction)playAndPause:(id)sender {
    if (_playPressed) {
        [self playPause];
    }
    else{
        [self playRecord];

    }
}

-(void)stopTimer{
    [_timer invalidate];
}

- (void)timerFired:(NSTimer *)timer{
    [self updateDisplay];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self setToinitial];
    [self stopTimer];
    [self updateDisplay];
    
}


- (void)updateDisplay{
    NSTimeInterval currentTime = _player.currentTime;
    _Slider.value = currentTime;
    [self updateSliderLabels];
}

- (void)updateSliderLabels{
    NSTimeInterval currentTime = _Slider.value;
    NSString *currentTimeString = [NSString stringWithFormat:@"00:%02d",(NSInteger)currentTime];
    
    _elapsedTimeLabel.text = currentTimeString;
    _remainingTimeLabel.text = [NSString stringWithFormat:@"-00:%02d",(NSInteger)(_player.duration - currentTime)];
    
}

- (IBAction)back:(id)sender {
    _player.currentTime = _player.currentTime - 2;
    [self updateDisplay];
}

- (IBAction)forward:(id)sender {
    _player.currentTime = _player.currentTime + 2;
    [self updateDisplay];
}

- (IBAction)currentTimeSliderValueChanged:(id)sender {
    if (_timer) {
        [self stopTimer];
    }
    [self updateSliderLabels];
}

- (IBAction)currentTimeSliderTouchUpInside:(id)sender {
    [_player stop];
    _player.currentTime = _Slider.value;
    [_player prepareToPlay];
    [self playRecord];
}

-(void)setToinitial{
    if ([_player isPlaying]) {
        [_player stop];
    }
    _Slider.value = _Slider.minimumValue;
    _playPressed = NO;
    [_playAndPause setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self setToinitial];
}

-(void)playRecord{
    _playPressed = YES;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [_playAndPause setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    [_player play];
}

-(void)playPause{
    _playPressed = NO;
    [_player pause];
    [self stopTimer];
    [self updateDisplay];
    [_playAndPause setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
    
}

-(void)shareRecord{
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc]init];
    mc.mailComposeDelegate = self;
    NSData *myData = [NSData dataWithContentsOfFile:[[recordStore currentDirectory] stringByAppendingString:_currentRecord]];
    [mc setSubject:[_questionLabel.text stringByAppendingString:@"record"]];
    [mc addAttachmentData:myData mimeType:@"audio/mp4a-latm" fileName:_currentRecord];
    [self presentViewController:mc animated:YES completion:NULL];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
