//
//  SILKFeedManager.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/19.
//

#import "SILKFeedManager.h"

// header
#import "SILKFeedDefine.h"

// model
#import "SILKVideoModel.h"
#import "SILKFeedModel.h"

// view
#import "SILKFeedViewController.h"

//
#import "SILKCacheCenterProtocol.h"

NSString * const kSILKFeedModelArray = @"kSILKFeedModelArray";
NSString * const kSILKFeedVideoKeylArray = @"kSILKFeedVideoKeylArray";

@interface SILKFeedManager ()

@end

@implementation SILKFeedManager

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        NSArray *archiveModels = [[NSUserDefaults standardUserDefaults] arrayForKey:kSILKFeedModelArray];
        NSMutableArray *unArchivedModels = @[].mutableCopy;
        NSSet *classes = [NSSet setWithArray:@[[NSDictionary class], [NSString class], [NSArray class], [NSNumber class], [SILKFeedModel class], [SILKVideoModel class],[NSNull class]]];
        for (NSData *data in archiveModels) {
            SILKFeedModel *adModel = [NSKeyedUnarchiver unarchivedObjectOfClasses:classes fromData:data error:nil];
            [unArchivedModels SILK_addObject:adModel];
        }
        self.feedModelArray = unArchivedModels.copy;
        
        self.feedVideoKeyArray = [[NSUserDefaults standardUserDefaults] arrayForKey:kSILKFeedVideoKeylArray];
    }
    
    return self;
}

#pragma mark - Public Method

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SILKFeedManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[SILKFeedManager alloc] initPrivate];
    });
    return instance;
}

- (void)saveVideoData:(NSData *)videoData {
    NSString *videoKey = [@"video" stringByAppendingFormat:@"_%lu", self.feedVideoKeyArray.count+1];
    
    // 存储视频 key
    NSMutableArray *mKeyArray = self.feedVideoKeyArray.mutableCopy;
    [mKeyArray SILK_addObject:videoKey];
    self.feedVideoKeyArray = mKeyArray;
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:mKeyArray.copy forKey:kSILKFeedVideoKeylArray];
    [userDefault synchronize];
    
    // 存储视频 data
    [GET_INSTANCE_FROM_PROTOCOL(SILKCacheCenter) setVideoData:videoData forKey:videoKey];

    // 存储视频 model
    SILKVideoModel *videoModel = [[SILKVideoModel alloc] init];
    videoModel.key = videoKey;
    [self saveVideoModel:videoModel];
}


- (void)saveVideoModel:(SILKVideoModel *)model {
    NSMutableArray *mFeedModels = self.feedModelArray.mutableCopy;
    SILKFeedModel *feedModel = [[SILKFeedModel alloc] init];
    feedModel.videoModel = model;
    [mFeedModels SILK_addObject:feedModel];
    self.feedModelArray = mFeedModels;
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *mDataArray = [userDefault arrayForKey:kSILKFeedModelArray].mutableCopy ?: @[].mutableCopy;
    NSData *feedModelData = [NSKeyedArchiver archivedDataWithRootObject:feedModel requiringSecureCoding:YES error:nil];
    [mDataArray SILK_addObject:feedModelData];
    [userDefault setObject:mDataArray.copy forKey:kSILKFeedModelArray];
    [userDefault synchronize];
}


#pragma mark - Private Method


#pragma mark - Getter && Setter

- (NSArray *)feedModelArray {
    if (!_feedModelArray) {
        _feedModelArray = @[];
    }
    
    return _feedModelArray;
}

- (NSArray *)feedVideoKeyArray {
    if (!_feedVideoKeyArray) {
        _feedVideoKeyArray = @[];
    }
    
    return _feedVideoKeyArray;
}

@end
