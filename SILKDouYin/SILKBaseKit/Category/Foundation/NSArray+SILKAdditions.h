//
//  NSArray+SILKAdditions.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray <__covariant ObjectType> (SILKAdditions)

/**
 * 将数组转换成字符串，如果出错，返回空
 *
 * @return 字符串对象
 */
- (nullable NSString *)SILK_jsonStringEncoded;
- (nullable NSString *)SILK_jsonStringEncoded:(NSError * _Nullable __autoreleasing * _Nullable)error;

#pragma mark - Safe Access

/**
 * 获取指定索引的对象，如果出错，返回空
 *
 */
- (nullable ObjectType)SILK_objectAtIndex:(NSUInteger)index;

- (nullable ObjectType)SILK_objectAtIndex:(NSUInteger)index class:(Class)cls;

#pragma mark - Functional

/**
 * 对数组中所有元素执行 block 函数
 *
 */
- (void)SILK_forEach:(void(^)(ObjectType obj))block;

/**
 * 通过 block，判断数组中是否包含特定元素
 *
 * @return 遍历结果
 */
- (BOOL)SILK_contains:(BOOL(^)(ObjectType obj))block;

- (BOOL)SILK_all:(BOOL(^)(ObjectType obj))block;

- (NSUInteger)SILK_firstIndex:(BOOL(^)(ObjectType obj))block;

- (nullable ObjectType)SILK_find:(BOOL(^)(ObjectType obj))block;

- (NSArray<ObjectType> *)SILK_filter:(BOOL(^)(ObjectType obj))block;

- (NSArray<id> *)SILK_map:(id _Nullable (^)(ObjectType obj))block;

@end

@interface NSMutableArray <ObjectType> (SILKAdditions)

#pragma mark - Safe Operation

- (void)SILK_addObject:(ObjectType)anObject;

- (void)SILK_insertObject:(ObjectType)anObject atIndex:(NSUInteger)index;

- (void)SILK_replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anObject;

- (void)SILK_removeObject:(ObjectType)anObject;

- (void)SILK_removeObjectAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
