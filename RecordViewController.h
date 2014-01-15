//
//  RecordViewController.h
//  toeflspeakingtimer
//
//  Created by tim on 1/14/14.
//  Copyright (c) 2014 tim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSString *Q1Q2Directory;
    NSString *Q3Q4Directory;
    NSString *Q5Q6Directory;
    NSFileManager *fileManager;
    
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *questionSegmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *RecordTableView;

@end