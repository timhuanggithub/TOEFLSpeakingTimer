//
//  mainViewController.h
//  TOEFLSpeakingTimer
//
//  Created by tim on 12/23/13.
//  Copyright (c) 2013 tim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeakingTimerViewController.h"


@interface mainViewController : UIViewController{
    
}
@property (weak, nonatomic) IBOutlet UIButton *buttonQ1Q2;
@property (weak, nonatomic) IBOutlet UIButton *buttonQ3Q4;
@property (weak, nonatomic) IBOutlet UIButton *buttonQ5Q6;
@property (weak, nonatomic) IBOutlet UIImageView *picture;


- (IBAction)pressButtonQ1Q2:(id)sender;
- (IBAction)pressButtonQ3Q4:(id)sender;
- (IBAction)pressButtonQ5Q6:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *test;
@property (weak,nonatomic) UITabBarItem *tbi;

@end
