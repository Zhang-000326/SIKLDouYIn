//
//  NSData+SILKAdditions.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (SILKAdditions)

/**
 * Convert a NSData to a NSArray or a NSDictionary.
 *
 * @return These fuctions will return a NSArray or a NSDictionary. If an error happened, these would return nil.
 */
- (nullable id)SILK_jsonValueDecoded;
- (nullable id)SILK_jsonValueDecoded:(NSError * _Nullable __autoreleasing * _Nullable)error;

- (nullable NSArray *)SILK_jsonArray;
- (nullable NSArray *)SILK_jsonArray:(NSError * _Nullable __autoreleasing * _Nullable)error;

- (nullable NSDictionary *)SILK_jsonDictionary;
- (nullable NSDictionary *)SILK_jsonDictionary:(NSError * _Nullable __autoreleasing * _Nullable)error;

- (NSString *)SILK_sha1String;

@end

NS_ASSUME_NONNULL_END
