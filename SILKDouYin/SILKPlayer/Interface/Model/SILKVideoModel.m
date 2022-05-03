//
//  SILKVideoModel.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/6.
//

#import "SILKVideoModel.h"

@implementation SILKVideoModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    //public
    [aCoder encodeObject:self.key forKey:@"key"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        //public
        self.key = [aDecoder decodeObjectForKey:@"key"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
