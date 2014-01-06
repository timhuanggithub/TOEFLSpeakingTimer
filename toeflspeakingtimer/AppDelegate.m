//
//  AppDelegate.m
//  TOEFLSpeakingTimer
//
//  Created by tim on 12/23/13.
//  Copyright (c) 2013 tim. All rights reserved.
//

#import "AppDelegate.h"
#import "mainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window.backgroundColor = [UIColor whiteColor];
    
    mainViewController *mvc = [[mainViewController alloc] init];
    mainViewController *mvc1 = [[mainViewController alloc]init];
    mainViewController *mvc2 = [[mainViewController alloc] init];
    
    UINavigationController *Q1Q2navController = [[UINavigationController alloc] initWithRootViewController:mvc];
    Q1Q2navController.navigationBar.barTintColor = DEFAULT_COLOR;
    Q1Q2navController.navigationBar.translucent = NO;
    Q1Q2navController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    UINavigationController *Q3Q4navController = [[UINavigationController alloc]initWithRootViewController:mvc1];
    Q3Q4navController.navigationBar.barTintColor = DEFAULT_COLOR;
    Q3Q4navController.navigationBar.translucent = NO;
    Q3Q4navController.navigationBar.tintColor = [UIColor whiteColor];
    
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    tabBarController.tabBar.tintColor = DEFAULT_COLOR;
    NSArray *viewControllers = [NSArray arrayWithObjects:Q1Q2navController, Q3Q4navController, mvc2, nil];
    [tabBarController setViewControllers: viewControllers];
    
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
