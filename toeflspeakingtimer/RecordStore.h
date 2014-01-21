//
//  RecordStore.h
//  toeflspeakingtimer
//
//  Created by tim on 1/19/14.
//  Copyright (c) 2014 tim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RecordStore : NSObject{
    

    
}

@property (nonatomic,strong) NSMutableArray *fileArray;
@property (nonatomic,strong) NSString *currentDirectory;

+(RecordStore *)sharedStore;
-(id)initWithDirectory:(NSString *)directory;
-(id)removeFileFromStore:(NSInteger)index;

@end
