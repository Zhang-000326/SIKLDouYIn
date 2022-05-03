//
//  NSString+SILKAdditions.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/26.
//

#import "NSString+SILKAdditions.h"
#import "NSData+SILKAdditions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (SILKAdditions)

- (id)SILK_jsonValueDecoded {
    NSError *error = nil;
    return [self SILK_jsonValueDecoded:&error];
}

- (id)SILK_jsonValueDecoded:(NSError *__autoreleasing *)error {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data SILK_jsonValueDecoded:error];
}

- (NSArray *)SILK_jsonArray {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data SILK_jsonArray];
}

- (NSArray *)SILK_jsonArray:(NSError * _Nullable __autoreleasing *)error {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data SILK_jsonArray:error];
}

- (NSDictionary *)SILK_jsonDictionary {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data SILK_jsonDictionary];
}

- (NSDictionary *)SILK_jsonDictionary:(NSError * _Nullable __autoreleasing *)error {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data SILK_jsonDictionary:error];
}

- (NSString *)SILK_stringCachePath {
    NSString* documentsPath = nil;
    
    if (!documentsPath) {
        NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsPath = [dirs objectAtIndex:0];
    }
    
    return [documentsPath stringByAppendingPathComponent:self];
}

- (NSString *)SILK_sha1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] SILK_sha1String];
}

- (nullable NSData *)SILK_dataFromLocalFileWithType:(NSString *)fileType {
    NSString *path = [[NSBundle mainBundle] pathForResource:self ofType:fileType];
    return [[NSData alloc] initWithContentsOfFile:path];
}

- (nullable UIImage *)SILK_PNGFromLocalFile {
    NSString *path = [[NSBundle mainBundle] pathForResource:self ofType:@"png"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    return [UIImage imageWithData:data];
}

@end
