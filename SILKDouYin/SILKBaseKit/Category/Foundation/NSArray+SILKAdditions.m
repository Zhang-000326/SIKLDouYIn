//
//  NSArray+SILKAdditions.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/26.
//

#import "NSArray+SILKAdditions.h"

@implementation NSArray (SILKAdditions)

- (NSString *)SILK_jsonStringEncoded
{
    NSError *error = nil;
    return [self SILK_jsonStringEncoded:&error];
}

- (NSString *)SILK_jsonStringEncoded:(NSError *__autoreleasing *)error
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

- (id)SILK_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (id)SILK_objectAtIndex:(NSUInteger)index class:(Class)cls {
    id obj = [self SILK_objectAtIndex:index];
    if ([obj isKindOfClass:cls]) {
        return obj;
    }
    return nil;
}

- (void)SILK_forEach:(void (^)(id _Nonnull))block {
    NSParameterAssert(block != nil);
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block(obj);
    }];
}

- (BOOL)SILK_contains:(BOOL (^)(id _Nonnull))block {
    NSParameterAssert(block != nil);
    __block BOOL result = NO;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block(obj)) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

- (BOOL)SILK_all:(BOOL (^)(id _Nonnull))block {
    NSParameterAssert(block != nil);
    __block BOOL result = YES;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!block(obj)) {
            result = NO;
            *stop = YES;
        }
    }];
    return result;
}

- (NSUInteger)SILK_firstIndex:(BOOL (^)(id _Nonnull))block {
    NSParameterAssert(block != nil);
    __block NSUInteger result = NSNotFound;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block(obj)) {
            result = idx;
            *stop = YES;
        }
    }];
    return result;
}

- (id)SILK_find:(BOOL (^)(id _Nonnull))block {
    NSParameterAssert(block != nil);
    __block id result = nil;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block(obj)) {
            result = obj;
            *stop = YES;
        }
    }];
    return result;
}

- (NSArray *)SILK_filter:(BOOL (^)(id _Nonnull))block {
    NSParameterAssert(block != nil);
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block(obj)) {
            [result addObject:obj];
        }
    }];
    return [result copy];
}

- (NSArray<id> *)SILK_map:(id  _Nonnull (^)(id _Nonnull))block {
    NSParameterAssert(block != nil);
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id mapped = block(obj) ? : [NSNull null];
        [result addObject:mapped];
    }];
    return [result copy];
}

@end

@implementation NSMutableArray (SILKAdditions)

- (void)SILK_addObject:(id)anObject {
    if (anObject != nil) {
        [self addObject:anObject];
    }
}

- (void)SILK_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject != nil && index <= self.count) {
        [self insertObject:anObject atIndex:index];
    }
}

- (void)SILK_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (anObject != nil && index < self.count) {
        [self replaceObjectAtIndex:index withObject:anObject];
    }
}

- (void)SILK_removeObject:(id)anObject {
    if (anObject != nil) {
        [self removeObject:anObject];
    }
}

- (void)SILK_removeObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

@end
