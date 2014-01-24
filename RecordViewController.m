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
        
        
        fileManager = [NSFileManager defaultManager];
        
        Q1Q2Directory = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/Q1Q2/"];
        Q3Q4Directory = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/Q3Q4/"];
        Q5Q6Directory = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/Q5Q6/"];
        
        if (![fileManager fileExistsAtPath:Q1Q2Directory isDirectory:NULL]) {
            [fileManager createDirectoryAtPath:Q1Q2Directory withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        if (![fileManager fileExistsAtPath:Q3Q4Directory isDirectory:NULL]) {
            [fileManager createDirectoryAtPath:Q3Q4Directory withIntermediateDirectories:NO attributes:nil error:nil];

        }
        
        if (![fileManager fileExistsAtPath:Q5Q6Directory isDirectory:NULL]) {
            [fileManager createDirectoryAtPath:Q5Q6Directory withIntermediateDirectories:NO attributes:nil error:nil];
            
        }

        
        
        
        
        
        
        
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [_RecordTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.title = @"Record";
    _questionSegmentedControl.selectedSegmentIndex = 0;
    currentDirectory = Q1Q2Directory;
    [_questionSegmentedControl addTarget:self action:@selector(questionChoose:) forControlEvents:UIControlEventValueChanged];
    NSLog(@"11");
    
    

    
    
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [recordStore removeFileFromStore:indexPath.row];
        [_RecordTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    recordStore = [[RecordStore sharedStore]initWithDirectory:currentDirectory];
    return recordStore.fileArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    NSMutableArray *dateArray = [[NSMutableArray alloc]init];
    NSMutableArray *timeArray = [[NSMutableArray alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"MM/dd/yy";
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    timeFormatter.dateFormat = @"hh:mm a";
    
    for (NSString *fileName in recordStore.fileArray) {
        NSDictionary *fileAttribute = [fileManager attributesOfItemAtPath:[currentDirectory stringByAppendingString:fileName] error:nil];
        [dateArray addObject:[dateFormatter stringFromDate:[fileAttribute fileCreationDate]]];
        [timeArray addObject:[timeFormatter stringFromDate:[fileAttribute fileCreationDate]]];
    }
    
    cell.textLabel.text = [timeArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [dateArray objectAtIndex:indexPath.row];
    return cell;
    
}


-(void)questionChoose:(id)sender{
    if (_questionSegmentedControl.selectedSegmentIndex == 0) {
        currentDirectory = Q1Q2Directory;
        [_RecordTableView reloadData];
    }
    else if (_questionSegmentedControl.selectedSegmentIndex == 1){
        currentDirectory = Q3Q4Directory;
        [_RecordTableView reloadData];
    }
    else if (_questionSegmentedControl.selectedSegmentIndex == 2){
        currentDirectory = Q5Q6Directory;
        [_RecordTableView reloadData];
    }
}



@end
