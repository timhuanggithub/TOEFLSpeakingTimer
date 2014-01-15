//
//  RecordViewController.m
//  toeflspeakingtimer
//
//  Created by tim on 1/14/14.
//  Copyright (c) 2014 tim. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()

@end

@implementation RecordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *tbi = self.tabBarItem;
        tbi.title = @"Record";
        UIImage *icon = [UIImage imageNamed:@"Record"];
        tbi.image = icon;
        
        _RecordTableView.delegate  = self;
        _RecordTableView.dataSource = self;
        
        Q1Q2Directory = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/Q1Q2/"];
        Q3Q4Directory = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/Q3Q4/"];
        Q5Q6Directory = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/Q5Q6/"];
        
        if (![[NSFileManager defaultManager]fileExistsAtPath:Q1Q2Directory isDirectory:NULL]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:Q1Q2Directory withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        if (![[NSFileManager defaultManager]fileExistsAtPath:Q3Q4Directory isDirectory:NULL]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:Q3Q4Directory withIntermediateDirectories:NO attributes:nil error:nil];

        }
        
        if (![[NSFileManager defaultManager]fileExistsAtPath:Q5Q6Directory isDirectory:NULL]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:Q5Q6Directory withIntermediateDirectories:NO attributes:nil error:nil];
            
        }

        
        
        
        
        
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.title = @"Record";
    
//    _RecordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSLog(@"1");
    //NSArray *fileArray = [fileManager contentsOfDirectoryAtPath:Q1Q2Directory error:nil];
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    
    cell.textLabel.text = @"111";
    //cell.textLabel.text = [[fileManager contentsOfDirectoryAtPath:Q1Q2Directory error:nil] objectAtIndex:indexPath.row];
    
    return cell;
    
}

@end
