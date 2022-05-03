//
//  NSData+SILKAdditions.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/26.
//

#import "NSData+SILKAdditions.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSData (SILKAdditions)

- (id)SILK_jsonValueDecoded {
    NSError *error = nil;
    return [self SILK_jsonValueDecoded:&error];
}

- (id)SILK_jsonValueDecoded:(NSError *__autoreleasing *)error {
    id value = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:error];
    return value;
}

- (NSArray *)SILK_jsonArray {
    id value = [self SILK_jsonValueDecoded];
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSArray *)SILK_jsonArray:(NSError * _Nullable __autoreleasing *)error {
    id value = [self SILK_jsonValueDecoded:error];
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)SILK_jsonDictionary {
    id value = [self SILK_jsonValueDecoded];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)SILK_jsonDictionary:(NSError * _Nullable __autoreleasing *)error {
    id value = [self SILK_jsonValueDecoded:error];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSString *)SILK_sha1String {
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (unsigned int)self.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@end
