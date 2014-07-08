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
@property (nonatomic,strong) NSString * currentDirectory;
@property (nonatomic) NSInteger questionType;

+(RecordStore *)sharedStore;
-(id)initWithDirectory:(NSString *)directory;
-(id)removeFileFromStore:(NSInteger)index;
-(id)addFile:(NSString *)fileName;
-(NSDictionary *)getRecordAttribute:(NSString *)fileName;
-(NSURL *)getURLFromFileName:(NSString *)fileName;

@end
