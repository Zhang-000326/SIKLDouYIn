//
//  SILKCacheCenter.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/29.
//

#import "SILKCacheCenter.h"
#import "SILKBaseKit.h"

#define HashLength 2

@interface SILKCacheCenter()

@property (nonatomic, strong) NSString *cachePath;

@property (nonatomic, strong) dispatch_queue_t ioQueue;

@end

@implementation SILKCacheCenter

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SILKCacheCenter *instance;
    dispatch_once(&onceToken, ^{
        instance = [[SILKCacheCenter alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _ioQueue = dispatch_queue_create("UESTC.SILK.ZQ.Cache", DISPATCH_QUEUE_SERIAL);
        _cachePath = [[@"SILKCacheCenter" SILK_stringCachePath] copy];
    }
    return self;
}

- (void)dealloc {
    _ioQueue = nil;
}

#pragma mark - Public Method

- (BOOL)isCacheExist:(NSString *)key {
    if (SILK_isEmptyString(key)) {
        return NO;
    }
    NSString *realKey = [key SILK_sha1String];
    return [self isCacheExistWithHashKey:realKey];
}

- (BOOL)isVideoCacheExist:(NSString *)key {
    if (SILK_isEmptyString(key)) {
        return NO;
    }
    NSString *realKey = [[key SILK_sha1String] stringByAppendingPathExtension:@"mp4"];
    return [self isCacheExistWithHashKey:realKey];
}

- (NSData *)dataForKey:(NSString *)key {
    if (SILK_isEmptyString(key)) {
        return nil;
    }
    
    NSString *realKey = [key SILK_sha1String];
    if ([self isCacheExistWithHashKey:realKey]) {
        __block NSData *data = nil;
        dispatch_sync(self.ioQueue, ^{
            data = [NSData dataWithContentsOfFile:[self cachePathForKeyWithHashFolder:realKey] options:0 error:NULL];
        });
        return data;
    } else {
        return nil;
    }
}

- (NSData *)videoDataForKey:(NSString *)key {
    if (SILK_isEmptyString(key)) {
        return nil;
    }
    
    NSString *realKey = [[key SILK_sha1String] stringByAppendingPathExtension:@"mp4"];
    if ([self isCacheExistWithHashKey:realKey]) {
        __block NSData *data = nil;
        dispatch_sync(self.ioQueue, ^{
            data = [NSData dataWithContentsOfFile:[self cachePathForKeyWithHashFolder:realKey] options:0 error:NULL];
        });
        return data;
    } else {
        return nil;
    }
}

- (NSString *)filePathForKey:(NSString *)key {
    if (SILK_isEmptyString(key)) {
        return nil;
    }
    NSString *realKey = [key SILK_sha1String];
    NSString *cachePath = [self cachePathForKeyWithHashFolder:realKey];
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        return cachePath;
    }
    return nil;
}

- (NSString *)videoFilePathForKey:(NSString *)key {
    if (SILK_isEmptyString(key)) {
        return nil;
    }
    NSString *realKey = [[key SILK_sha1String] stringByAppendingPathExtension:@"mp4"];
    NSString *cachePath = [self cachePathForKeyWithHashFolder:realKey];
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        return cachePath;
    }
    return nil;
}

- (void)setData:(NSData *)data forKey:(NSString *)key {
    if (![data isKindOfClass:[NSData class]] || SILK_isEmptyString(key)) {
        return;
    }
    
    NSString *realKey = [key SILK_sha1String];
    NSString *cachePath = [self cachePathForKeyWithHashFolder:realKey];
    [self writeData:data toPath:cachePath];
}

- (void)setVideoData:(NSData *)data forKey:(NSString *)key {
    if (![data isKindOfClass:[NSData class]] || SILK_isEmptyString(key)) {
        return;
    }
    
    NSString *realKey = [[key SILK_sha1String] stringByAppendingPathExtension:@"mp4"];
    NSString *cachePath = [self cachePathForKeyWithHashFolder:realKey];
    [self writeData:data toPath:cachePath];
}

#pragma mark - Private Method

- (void)writeData:(NSData *)data toPath:(NSString *)path {
    dispatch_async(self.ioQueue, ^{
        if (HashLength > 0) {
            [[NSFileManager defaultManager] createDirectoryAtPath:[path stringByDeletingLastPathComponent]
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:NULL];
        }
        [data writeToFile:path atomically:YES];
    });
}

- (void)deleteDataAtPath:(NSString *)path {
    dispatch_async(self.ioQueue, ^{
        [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    });
}

- (BOOL)isCacheExistWithHashKey:(NSString *)HashKey {
    if (SILK_isEmptyString(HashKey)) {
        return NO;
    }
    
    NSString *cachedFilePath = [self cachePathForKeyWithHashFolder:HashKey];
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachedFilePath]) {
        return YES;
    }
    
    return NO;
}

- (NSString *)cachePathForKeyWithHashFolder:(NSString *)key {
    NSString *path = @"";
    if (HashLength > 0) {
        path = [key length] >= HashLength ? [key substringToIndex:HashLength] : @"";
    }
    path = [path stringByAppendingPathComponent:key];
    return [self.cachePath stringByAppendingPathComponent:path];
}

@end
