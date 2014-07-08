//
//  RecordStore.m
//  toeflspeakingtimer
//
//  Created by tim on 1/19/14.
//  Copyright (c) 2014 tim. All rights reserved.
//

#import "RecordStore.h"

@implementation RecordStore

+(RecordStore *)sharedStore{
    static RecordStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil]init];
    }
    return sharedStore;
}


+(id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedStore];
}

-(id)initWithDirectory:(NSString *)directory{
    self = [super init];
    if (self) {
         _currentDirectory = directory;
        _fileArray = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:_currentDirectory error:nil] mutableCopy];
    }
    return self;
}

-(id)removeFileFromStore:(NSInteger)index{
    [[NSFileManager defaultManager] removeItemAtPath:[_currentDirectory stringByAppendingString:[_fileArray objectAtIndex:index]] error:nil];
    [_fileArray removeObjectAtIndex:index];
    return self;
}

-(id)addFile:(NSString *)fileName{
    [_fileArray addObject:fileName];
    return self;

}

-(NSDictionary *)getRecordAttribute:(NSString *)fileName{
    NSDictionary *fileAttribute = [[NSFileManager defaultManager] attributesOfItemAtPath:[_currentDirectory stringByAppendingString:fileName] error:nil];
    return fileAttribute;
    
}

-(NSURL *)getURLFromFileName:(NSString *)fileName{
    NSURL *url = [NSURL URLWithString:[_currentDirectory stringByAppendingString:fileName]];
    return url;
}
@end
