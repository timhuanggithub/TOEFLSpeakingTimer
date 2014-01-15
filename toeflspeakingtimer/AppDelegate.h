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


@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) mainViewController *mvc;
@property (strong, nonatomic) RecordViewController *rvc;
@property (strong, nonatomic) mainViewController *mvc2;

@property (strong,nonatomic) UINavigationController *Q1Q2navController;
@property (strong,nonatomic) UINavigationController *Q3Q4navController;



@end
