//
//  NSString+SILKAdditions.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SILKAdditions)

/**
 Convert a NSString to a NSDictionary or a NSArray.If an error happened, nil would be returned.
 */
- (nullable id)SILK_jsonValueDecoded;
- (nullable id)SILK_jsonValueDecoded:(NSError * _Nullable __autoreleasing * _Nullable)error;

- (nullable NSArray *)SILK_jsonArray;
- (nullable NSArray *)SILK_jsonArray:(NSError * _Nullable __autoreleasing * _Nullable)error;

- (nullable NSDictionary *)SILK_jsonDictionary;
- (nullable NSDictionary *)SILK_jsonDictionary:(NSError * _Nullable __autoreleasing * _Nullable)error;

- (NSString *)SILK_stringCachePath;

- (NSString *)SILK_sha1String;

- (nullable NSData *)SILK_dataFromLocalFileWithType:(NSString *)fileType;

- (nullable NSDictionary *)SILK_jsonDictionaryFromLocalFile;

- (nullable UIImage *)SILK_PNGFromLocalFile;

@end

NS_ASSUME_NONNULL_END
