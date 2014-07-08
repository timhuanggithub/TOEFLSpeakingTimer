//
//  AppDelegate.h
//  TOEFLSpeakingTimer
//
//  Created by tim on 12/23/13.
//  Copyright (c) 2013 tim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainViewController.h"
#import "RecordViewController.h"
#import "SettingViewController.h"

extern NSString * const alertDisplayed;
//extern NSString

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) mainViewController *mvc;
@property (strong, nonatomic) RecordViewController *rvc;
@property (strong, nonatomic) SettingViewController *svc;

@property (strong,nonatomic) UINavigationController *speakingNavController;
@property (strong,nonatomic) UINavigationController *recordNavController;
@property (strong, nonatomic) UINavigationController *settingNavController;



@end
