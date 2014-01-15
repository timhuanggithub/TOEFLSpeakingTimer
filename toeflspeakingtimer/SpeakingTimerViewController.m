//
//  SpeakingTimerViewController.m
//  TOEFLSpeakingTimer
//
//  Created by tim on 12/24/13.
//  Copyright (c) 2013 tim. All rights reserved.
//

#import "SpeakingTimerViewController.h"

@interface SpeakingTimerViewController ()

@end

@implementation SpeakingTimerViewController


- (IBAction)pressStartButton:(id)sender{
    if ((sender == _startStopButton && startButtonPressed == NO) || (sender == self && startButtonPressed == YES) ) {
        [_startStopButton setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
        startButtonPressed = YES;
        
        _playRecord.hidden = YES;
        _saveToRecord.hidden = YES;

        
        if ( iForArray == _playOrder.count && sender == self){
            _saveToRecord.hidden = NO;
            _playRecord.hidden =NO;
            recordPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:speakingRecorder.url error:nil];
            recordPlayer.delegate = self;
            [_startStopButton setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
            _TimeLabel.text = @"00:00";
            [self swapButtonPostion:_startStopButton with:_playRecord];
            ButtonSwaped = YES;
            
            
            
        }
        else if ([_playOrder[iForArray] isKindOfClass:[NSTimer class]] ) {
            NSRunLoop *runner = [NSRunLoop currentRunLoop];
            [runner addTimer:_playOrder[iForArray] forMode:NSDefaultRunLoopMode];
        }
        else if ([ _playOrder[iForArray] isKindOfClass:[AVAudioPlayer class]]) {
            [(AVAudioPlayer *)_playOrder[iForArray] play];
        }
        else if ([_playOrder[iForArray] isKindOfClass:[NSString class]]){
            [_startStopButton setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
            
        }

        
    }
    else if (sender == _startStopButton && startButtonPressed == YES){
        if (iForArray<_playOrder.count) {
            if ([_playOrder[iForArray] isKindOfClass:[NSString class]]) {
                iForArray++;
                [self pressStartButton:self];
                _TimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", _remainingPrepareTime/100,_remainingPrepareTime%100];
            }
            else{
                [self stop];
                [self setToIntial];
            }
        }
        else{
            [self stop];
            [self setToIntial];
        }
    }

}


-(id)initWithPressedButton:(UIButton *)pressedButton {
    self = [super init];
    if (self) {
        if (pressedButton.tag == 12) {
            _currentQuestion = 12;
            self.navigationItem.title = @"Q1Q2";
        }
        if (pressedButton.tag == 34) {
            _currentQuestion = 34;
            self.navigationItem.title = @"Q3Q4";
        }
        if (pressedButton.tag == 56) {
            _currentQuestion = 56;
            self.navigationItem.title = @"Q5Q6";
        }
        NSArray *pathComponents = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject],@"SpeakingMemo.m4a", nil];
        NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
        
        session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];
        
        NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
        
        [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatAppleLossless] forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:44100.0f] forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
        [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityLow] forKey:AVEncoderAudioQualityKey];
        
        speakingRecorder = [[AVAudioRecorder alloc]initWithURL:outputFileURL settings:recordSetting error:NULL];
        [speakingRecorder prepareToRecord];
        speakingRecorder.delegate = self;
        


    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    [self setToIntial];
    
    
}



-(void) updatePrepareTime{
    if (_remainingPrepareTime >0) {
        _remainingPrepareTime -= 1;
        _TimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", _remainingPrepareTime/100,_remainingPrepareTime%100];
    }
    else if (_remainingPrepareTime <= 0){
        [self stop];
        if(_playOrder[iForArray+1] != nil ){
        iForArray++;
        }
        [self pressStartButton:self];
    }
}

-(void) updateSpeakingTime{
    if (_remainingSpeakingTime > 0) {
        if (![speakingRecorder isRecording]) {
            [speakingRecorder record];
            
        }
        _remainingSpeakingTime -= 1;
        _TimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", _remainingSpeakingTime/100,_remainingSpeakingTime%100];

    }
    else if(_remainingSpeakingTime <= 0){
        [self stop];
        iForArray++;
        [self pressStartButton:self];
    }
}

-(void) updateReadingTime{
    if (_remainingReadingTime > 0) {
        _remainingReadingTime -= 1;
        _TimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",_remainingReadingTime/100,_remainingReadingTime%100];
    }
    else if (_remainingReadingTime <=0){
        [self stop];
        iForArray++;
        [self pressStartButton:self];
    }
    
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if (player == recordPlayer && flag == YES) {
        [_playRecord setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
        _startStopButton.hidden = NO;
    }

    else if((player == speak || prepare) && flag == YES){
        iForArray++;
        [self pressStartButton:self];
    }
}

-(void)setToIntial{
    prepareTimer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(updatePrepareTime) userInfo:nil repeats:YES];
    speakingTimer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(updateSpeakingTime) userInfo:nil repeats:YES];
    
    NSURL *beepURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"]];
    beep = [[AVAudioPlayer alloc]initWithContentsOfURL:beepURL error:nil];
    beep.delegate = self;
    
    NSURL *prepareURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"prepare" ofType:@"mp3"]];
    prepare = [[AVAudioPlayer alloc]initWithContentsOfURL:prepareURL error:nil];
    prepare.delegate = self;
    
    NSURL *speakURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"speak" ofType:@"mp3"]];
    speak = [[AVAudioPlayer alloc]initWithContentsOfURL:speakURL error:nil];
    speak.delegate = self;
    
    [_playRecord setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    _playRecord.enabled = YES;
    _playRecord.hidden = YES;
    
    [_saveToRecord setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    _saveToRecord.enabled = YES;
    _saveToRecord.hidden = YES;

    


    if (_currentQuestion == 12) {
        
        _initalPrepareTime = Q1Q2PrepareTime;
        _initalSpeakingTime = Q1Q2SpeakingTime;
       
        _TimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",_initalPrepareTime/100,_initalPrepareTime%100];
        
        NSURL *Q1Q2questionURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Q1Q2question" ofType:@"mp3"]];
        AVAudioPlayer *Q1Q2question = [[AVAudioPlayer alloc]initWithContentsOfURL:Q1Q2questionURL error:nil];
        Q1Q2question.delegate = self;
        
        
        
        currentQuestionDirectory = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/Q1Q2/"];
        
        
        
        _questionDescription.editable = YES;
        _questionDescription.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        _questionDescription.editable = NO;
        _questionDescription.text = @"In this question, you have 15 seconds to prepare your answer, 45 seconds to speak.\n\nPress start when you are ready to read question.";
        
       
        
        _playOrder = [NSArray arrayWithObjects:Q1Q2question,prepare,beep,prepareTimer,speak,beep,speakingTimer, nil];
        
    }
    else if (_currentQuestion == 34){
        _initalPrepareTime = Q3Q4PrepareTime;
        _initalSpeakingTime = Q3Q4SpeakingTime;
        _initalReadingTime = readingTime;
        
        _questionDescription.editable = YES;
        _questionDescription.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        _questionDescription.editable = NO;
        _questionDescription.text = @"In this question, you have 45 or 50 seconds to read passage,30 seconds to prepare and 60 seconds to speak.\n\nPress start when you are ready to read passage and after listening.";
        
        _TimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",_initalReadingTime/100,_initalReadingTime%100];

        NSTimer *readingTimer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(updateReadingTime) userInfo:nil repeats:YES];
        
        NSURL *Q3Q4questionURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Q3Q4question" ofType:@"mp3"]];
        AVAudioPlayer *Q3Q4question = [[AVAudioPlayer alloc]initWithContentsOfURL:Q3Q4questionURL error:nil];
        Q3Q4question.delegate = self;
        
        currentQuestionDirectory = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/Q3Q4/"];
        
        
        _playOrder = [NSArray arrayWithObjects:readingTimer,@"Continue",Q3Q4question,prepare,beep,prepareTimer,speak,beep,speakingTimer, nil];
    }
    else if (_currentQuestion == 56){
        _initalPrepareTime = Q5Q6PrepareTime;
        _initalSpeakingTime = Q5Q6SpeakingTime;
        
        _questionDescription.editable = YES;
        _questionDescription.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        _questionDescription.editable = NO;
        _questionDescription.text = @"In this question, you have 20 seconds to prepare your answers, 60 seconds to speak.\n\nPress start after the listening.";

        _TimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",_initalPrepareTime/100,_initalPrepareTime%100];
        
        NSURL *Q5Q6questionURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Q5Q6question" ofType:@"mp3"]];
        AVAudioPlayer *Q5Q6question = [[AVAudioPlayer alloc]initWithContentsOfURL:Q5Q6questionURL error:nil];
        Q5Q6question.delegate = self;
        
        currentQuestionDirectory = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/Q5Q6/"];
        
        
        _playOrder = [NSArray arrayWithObjects:Q5Q6question,prepare,beep,prepareTimer,speak,beep,speakingTimer, nil];
    }
    
    startButtonPressed = NO;
    [_startStopButton setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    _remainingPrepareTime = _initalPrepareTime;
    _remainingSpeakingTime = _initalSpeakingTime;
    _remainingReadingTime = _initalReadingTime;
    iForArray = 0;
    
    if (ButtonSwaped == YES) {
        [self swapButtonPostion:_startStopButton with:_playRecord];
        ButtonSwaped = NO;
    }
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    if (![fileManger fileExistsAtPath:currentQuestionDirectory isDirectory:NULL]) {
        [fileManger createDirectoryAtPath:currentQuestionDirectory withIntermediateDirectories:NO attributes:nil error:nil];
    }
   
}

- (IBAction)pressSaveToRecord:(id)sender {
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSArray *sourcePathComponents = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject],@"SpeakingMemo.m4a", nil];
    NSURL *sourceURL = [NSURL fileURLWithPathComponents:sourcePathComponents];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmm"];
    NSString *destFileName = [[formatter stringFromDate:[NSDate date]] stringByAppendingPathExtension:@"m4a"];
    
    
    NSArray *destPathComponent = [NSArray arrayWithObjects:currentQuestionDirectory,destFileName, nil];
    NSURL *destURL = [NSURL fileURLWithPathComponents:destPathComponent];
    if ([sourceURL checkResourceIsReachableAndReturnError:nil]) {
        if ([fileManger moveItemAtURL:sourceURL toURL:destURL error:nil]) {
            static float const curvingIntoCartAnimationDuration = 1.0f;
            
            CALayer * layerToAnimate = _saveToRecord.layer;
            
            CAKeyframeAnimation * itemViewCurvingIntoCartAnimation = [self itemViewCurvingIntoCartAnimation];
            CABasicAnimation * itemViewShrinkingAnimation =  [CABasicAnimation animationWithKeyPath:@"bounds"];
            itemViewShrinkingAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0.0,0.0, _saveToRecord.bounds.size.width/1.5, _saveToRecord.bounds.size.height/1.5)];
            CABasicAnimation * itemAlphaFadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
            itemAlphaFadeAnimation.toValue = [NSNumber numberWithFloat:0.7];
            
            CAAnimationGroup * shrinkFadeAndCurveAnimation = [CAAnimationGroup animation];
            [shrinkFadeAndCurveAnimation setAnimations:[NSArray arrayWithObjects:
                                                        itemViewCurvingIntoCartAnimation,
                                                        itemViewShrinkingAnimation,
                                                        itemAlphaFadeAnimation,
                                                        nil]];
            [shrinkFadeAndCurveAnimation setDuration:curvingIntoCartAnimationDuration];
            [shrinkFadeAndCurveAnimation setDelegate:self];
            [shrinkFadeAndCurveAnimation setRemovedOnCompletion:NO];
            [shrinkFadeAndCurveAnimation setValue:@"shrinkAndCurveToAddToOrderAnimation" forKey:@"name"];
            [layerToAnimate addAnimation:shrinkFadeAndCurveAnimation forKey:nil];
            _saveToRecord.enabled = NO;

        }
        else{
            UIAlertView *alertForMove =[[UIAlertView alloc]initWithTitle:@"Notification" message:@"File moved failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertForMove show];
        }
        
        }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Notification" message:@"The record has been saved. " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}

- (IBAction)pressPlayRecordButton:(id)sender {
    if ([recordPlayer isPlaying]) {
        [self stop];
    }
    else{
        [recordPlayer play];
        [_playRecord setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
        _remainingRecordTime = _initalSpeakingTime;
        recordTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateRecordTime) userInfo:Nil repeats:YES];
    }
}

-(void)updateRecordTime{
    if (_remainingRecordTime >0) {
        _remainingRecordTime -= 1;
        _TimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", _remainingRecordTime/100,_remainingRecordTime%100];
    }
    else if(_remainingRecordTime <= 0){
        [self stop];
        
    }
}


-(void)stop{
    if ([speakingRecorder isRecording]) {
        [speakingRecorder stop];
    }
    if ([recordPlayer isPlaying]) {
        [recordPlayer stop];
        recordPlayer.currentTime = 0;
        [_playRecord setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];

    }
    if ([recordTimer isValid]) {
        [recordTimer invalidate];
        _TimeLabel.text= @"00:00";
    }
    if (iForArray<_playOrder.count) {
        if ([_playOrder[iForArray] isKindOfClass:[NSTimer class]] && [_playOrder[iForArray] isValid]) {
            [_playOrder[iForArray] invalidate];
        }
        else if ([ _playOrder[iForArray] isKindOfClass:[AVAudioPlayer class]] && [_playOrder[iForArray] isPlaying]) {
            [_playOrder[iForArray] stop];
        }
    
    }
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [self stop];
    if (_playRecord.hidden && _saveToRecord.hidden) {
        [self setToIntial];
    }

    
}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if (_remainingSpeakingTime == 0 && recorder == speakingRecorder) {
        _saveToRecord.hidden = NO;
        _playRecord.hidden =NO;
        recordPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:speakingRecorder.url error:nil];
        recordPlayer.delegate = self;
    }
    
}

-(void)swapButtonPostion:(UIButton *)button1 with:(UIButton *) button2{

    CGRect frame = button1.frame;
    button1.frame = button2.frame;
    button2.frame =frame;
}




- (CAKeyframeAnimation *) itemViewCurvingIntoCartAnimation {
    CGRect positionOfItemViewInView = _saveToRecord.frame;
    
    float riseAbovePoint = 300.0f;
    
    CGPoint beginningPointOfQuadCurve = positionOfItemViewInView.origin;
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    CGPoint endPointOfQuadCurve = CGPointMake(screenWidth/2, screenHeight);

    CGPoint controlPointOfQuadCurve = CGPointMake((beginningPointOfQuadCurve.x + endPointOfQuadCurve.x *2)/2, beginningPointOfQuadCurve.y -riseAbovePoint);
    
    UIBezierPath * quadBezierPathOfAnimation = [UIBezierPath bezierPath];
    [quadBezierPathOfAnimation moveToPoint:beginningPointOfQuadCurve];
    [quadBezierPathOfAnimation addQuadCurveToPoint:endPointOfQuadCurve controlPoint:controlPointOfQuadCurve];
    
    CAKeyframeAnimation * itemViewCurvingIntoCartAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    itemViewCurvingIntoCartAnimation.path = quadBezierPathOfAnimation.CGPath;
    
    return itemViewCurvingIntoCartAnimation;
}

@end
