//
//  SILKFeedModel.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/19.
//

#import "SILKFeedModel.h"

// model
#import "SILKVideoModel.h"

@implementation SILKFeedModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    //public
    [aCoder encodeObject:self.videoModel forKey:@"videoModel"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        //public
        self.videoModel = [aDecoder decodeObjectForKey:@"videoModel"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
