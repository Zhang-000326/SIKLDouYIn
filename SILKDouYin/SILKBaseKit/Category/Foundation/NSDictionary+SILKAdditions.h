//
//  NSDictionary+SILKAdditions.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary <KeyType, ObjectType> (SILKAdditions)

/**
 * 将字典转换成字符串，如果出错，返回空
 *
 * @return 字符串对象
 */
- (nullable NSString *)SILK_jsonStringEncoded;
- (nullable NSString *)SILK_jsonStringEncoded:(NSError * _Nullable __autoreleasing * _Nullable)error;

/**
 * 字典各种值的获取方法
 * 
 */
- (BOOL)SILK_boolValueForKey:(KeyType<NSCopying>)key;

- (int)SILK_intValueForKey:(KeyType<NSCopying>)key;

- (long)SILK_longValueForKey:(KeyType<NSCopying>)key;

- (long long)SILK_longlongValueForKey:(KeyType<NSCopying>)key;

- (NSInteger)SILK_integerValueForKey:(KeyType<NSCopying>)key;

- (NSUInteger)SILK_unsignedIntegerValueForKey:(KeyType<NSCopying>)key;

- (short)SILK_shortValueForKey:(KeyType<NSCopying>)key;

- (unsigned short)SILK_unsignedShortValueForKey:(KeyType<NSCopying>)key;

- (float)SILK_floatValueForKey:(KeyType<NSCopying>)key;

- (double)SILK_doubleValueForKey:(KeyType<NSCopying>)key;

- (nullable NSNumber *)SILK_numberValueForKey:(KeyType<NSCopying>)key;

- (nullable NSString *)SILK_stringValueForKey:(KeyType<NSCopying>)key;

- (nullable NSArray *)SILK_arrayValueForKey:(KeyType<NSCopying>)key;

- (nullable NSDictionary *)SILK_dictionaryValueForKey:(KeyType<NSCopying>)key;

- (BOOL)SILK_boolValueForKey:(KeyType<NSCopying>)key default:(BOOL)def;
- (char)SILK_charValueForKey:(KeyType<NSCopying>)key default:(char)def;
- (unsigned char)SILK_unsignedCharValueForKey:(KeyType<NSCopying>)key default:(unsigned char)def;

- (short)SILK_shortValueForKey:(KeyType<NSCopying>)key default:(short)def;
- (unsigned short)SILK_unsignedShortValueForKey:(KeyType<NSCopying>)key default:(unsigned short)def;

- (int)SILK_intValueForKey:(KeyType<NSCopying>)key default:(int)def;
- (unsigned int)SILK_unsignedIntValueForKey:(KeyType<NSCopying>)key default:(unsigned int)def;

- (long)SILK_longValueForKey:(KeyType<NSCopying>)key default:(long)def;
- (unsigned long)SILK_unsignedLongValueForKey:(KeyType<NSCopying>)key default:(unsigned long)def;
- (long long)SILK_longLongValueForKey:(KeyType<NSCopying>)key default:(long long)def;
- (unsigned long long)SILK_unsignedLongLongValueForKey:(KeyType<NSCopying>)key default:(unsigned long long)def;

- (float)SILK_floatValueForKey:(KeyType<NSCopying>)key default:(float)def;
- (double)SILK_doubleValueForKey:(KeyType<NSCopying>)key default:(double)def;

- (NSInteger)SILK_integerValueForKey:(KeyType<NSCopying>)key default:(NSInteger)def;
- (NSUInteger)SILK_unsignedIntegerValueForKey:(KeyType<NSCopying>)key default:(NSUInteger)def;

- (nullable NSNumber *)SILK_numberValueForKey:(KeyType<NSCopying>)key default:(nullable NSNumber *)def;
- (nullable NSString *)SILK_stringValueForKey:(KeyType<NSCopying>)key default:(nullable NSString *)def;

- (nullable NSArray *)SILK_arrayValueForKey:(KeyType<NSCopying>)key default:(nullable NSArray *)def;

- (nullable NSDictionary *)SILK_dictionaryValueForKey:(KeyType<NSCopying>)key default:(nullable NSDictionary *)def;

- (nullable ObjectType)SILK_objectForKey:(KeyType<NSCopying>)key default:(nullable ObjectType)def;

#pragma mark - Functional

- (void)SILK_forEach:(void(^)(KeyType key, ObjectType obj))block;

- (BOOL)SILK_contain:(BOOL(^)(KeyType key, ObjectType obj))block;

- (BOOL)SILK_all:(BOOL(^)(KeyType key, ObjectType obj))block;

- (NSDictionary<KeyType, ObjectType> *)SILK_filter:(BOOL(^)(KeyType key, ObjectType obj))block;

- (NSDictionary<KeyType, id> *)SILK_map:(_Nullable id(^)(KeyType key, ObjectType obj))block;

@end


@interface NSMutableDictionary <KeyType, ObjectType> (SILKAdditions)

#pragma mark - Safe Access

- (void)SILK_setObject:(ObjectType)anObject forKey:(KeyType<NSCopying>)key;

@end

NS_ASSUME_NONNULL_END
