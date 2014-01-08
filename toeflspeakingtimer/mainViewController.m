//
//  mainViewController.m
//  TOEFLSpeakingTimer
//
//  Created by tim on 12/23/13.
//  Copyright (c) 2013 tim. All rights reserved.
//

#import "mainViewController.h"

@interface mainViewController ()

@end

@implementation mainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *tbi = self.tabBarItem;
        tbi.title = @"Practice";
        UIImage *icon = [UIImage imageNamed:@"Practice"];
        tbi.image = icon;
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"pictureForFun.jpg"];
    _picture.contentMode = UIViewContentModeScaleAspectFit;
    _picture.image = image;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.title = @"Practice";
    

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressButtonQ1Q2:(id)sender {
    SpeakingTimerViewController *Q1Q2SpeakingTimerViewController = [[SpeakingTimerViewController alloc]initWithPressedButton:_buttonQ1Q2];
    //Q1Q2SpeakingTimerViewController.hidesBottomBarWhenPushed = YES;
    [[self navigationController] pushViewController:Q1Q2SpeakingTimerViewController animated:YES];
    
    
}
- (IBAction)pressButtonQ3Q4:(id)sender {
    SpeakingTimerViewController *Q3Q4SpeakingTimerViewController = [[SpeakingTimerViewController alloc] initWithPressedButton:_buttonQ3Q4];
    //Q3Q4SpeakingTimerViewController.hidesBottomBarWhenPushed = YES;
    [[self navigationController]pushViewController:Q3Q4SpeakingTimerViewController animated:YES];
}

- (IBAction)pressButtonQ5Q6:(id)sender {
    SpeakingTimerViewController *Q5Q6SpeakingTimerViewController = [[SpeakingTimerViewController alloc] initWithPressedButton:_buttonQ5Q6];
    //Q5Q6SpeakingTimerViewController.hidesBottomBarWhenPushed = YES;
    [[self navigationController]pushViewController:Q5Q6SpeakingTimerViewController animated:YES];
}
@end
