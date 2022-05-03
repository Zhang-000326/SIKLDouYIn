//
//  NSDictionary+SILKAdditions.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/2/26.
//

#import "NSDictionary+SILKAdditions.h"

#define RETURN_VALUE(_type_, _key_, _def_)                                                     \
if (!_key_) return _def_;                                                            \
id value = self[_key_];                                                            \
if (!value || value == [NSNull null]) return _def_;                                \
if ([value isKindOfClass:[NSNumber class]]) return ((NSNumber *)value)._type_;   \
if ([value isKindOfClass:[NSString class]]) return NSNumberFromID(value)._type_; \
return _def_;

@implementation NSDictionary (SILKAdditions)

- (NSString *)SILK_jsonStringEncoded {
    NSError *error = nil;
    return [self SILK_jsonStringEncoded:&error];
}

- (NSString *)SILK_jsonStringEncoded:(NSError *__autoreleasing *)error {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

/// Get a number value from 'id'.
static NSNumber *NSNumberFromID(id value) {
    static NSCharacterSet *dot;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dot = [NSCharacterSet characterSetWithRange:NSMakeRange('.', 1)];
    });
    if (!value || value == [NSNull null]) return nil;
    if ([value isKindOfClass:[NSNumber class]]) return value;
    if ([value isKindOfClass:[NSString class]]) {
        NSString *lower = ((NSString *)value).lowercaseString;
        if ([lower isEqualToString:@"true"] || [lower isEqualToString:@"yes"]) return @(YES);
        if ([lower isEqualToString:@"false"] || [lower isEqualToString:@"no"]) return @(NO);
        if ([lower isEqualToString:@"nil"] || [lower isEqualToString:@"null"]) return nil;
        if ([(NSString *)value rangeOfCharacterFromSet:dot].location != NSNotFound) {
            return @(((NSString *)value).doubleValue);
        } else {
            return @(((NSString *)value).longLongValue);
        }
    }
    return nil;
}

- (BOOL)SILK_boolValueForKey:(id<NSCopying>)key {
    return [self SILK_boolValueForKey:key default:NO];
}

- (int)SILK_intValueForKey:(id<NSCopying>)key {
    return [self SILK_intValueForKey:key default:0];
}

- (long)SILK_longValueForKey:(id<NSCopying>)key {
    return [self SILK_longValueForKey:key default:0];
}

- (long long)SILK_longlongValueForKey:(id<NSCopying>)key {
    return [self SILK_longLongValueForKey:key default:0];
}

- (NSInteger)SILK_integerValueForKey:(id<NSCopying>)key {
    return [self SILK_integerValueForKey:key default:0];
}

- (NSUInteger)SILK_unsignedIntegerValueForKey:(id<NSCopying>)key {
    return [self SILK_unsignedIntegerValueForKey:key default:0];
}

- (short)SILK_shortValueForKey:(id<NSCopying>)key {
    return [self SILK_shortValueForKey:key default:0];
}

- (unsigned short)SILK_unsignedShortValueForKey:(id<NSCopying>)key {
    return [self SILK_unsignedShortValueForKey:key default:0];
}

- (float)SILK_floatValueForKey:(id<NSCopying>)key {
    return [self SILK_floatValueForKey:key default:0.0];
}

- (double)SILK_doubleValueForKey:(id<NSCopying>)key {
    return [self SILK_doubleValueForKey:key default:0.0];
}

- (NSNumber *)SILK_numberValueForKey:(id<NSCopying>)key {
    return [self SILK_numberValueForKey:key default:nil];
}

- (NSString *)SILK_stringValueForKey:(id<NSCopying>)key {
    return [self SILK_stringValueForKey:key default:nil];
}

- (nullable NSArray *)SILK_arrayValueForKey:(id<NSCopying>)key {
    return [self SILK_arrayValueForKey:key default:nil];
}

- (nullable NSDictionary *)SILK_dictionaryValueForKey:(id<NSCopying>)key {
    return [self SILK_dictionaryValueForKey:key default:nil];
}

- (BOOL)SILK_boolValueForKey:(id<NSCopying>)key default:(BOOL)def {
    RETURN_VALUE(boolValue,key,def);
}

- (char)SILK_charValueForKey:(id<NSCopying>)key default:(char)def {
    RETURN_VALUE(charValue,key,def);
}

- (unsigned char)SILK_unsignedCharValueForKey:(id<NSCopying>)key default:(unsigned char)def {
    RETURN_VALUE(unsignedCharValue,key,def);
}

- (short)SILK_shortValueForKey:(id<NSCopying>)key default:(short)def {
    RETURN_VALUE(shortValue,key,def);
}

- (unsigned short)SILK_unsignedShortValueForKey:(id<NSCopying>)key default:(unsigned short)def {
    RETURN_VALUE(unsignedShortValue,key,def);
}

- (int)SILK_intValueForKey:(id<NSCopying>)key default:(int)def {
    RETURN_VALUE(intValue,key,def);
}

- (unsigned int)SILK_unsignedIntValueForKey:(id<NSCopying>)key default:(unsigned int)def {
    RETURN_VALUE(unsignedIntValue,key,def);
}

- (long)SILK_longValueForKey:(id<NSCopying>)key default:(long)def {
    RETURN_VALUE(longValue,key,def);
}

- (unsigned long)SILK_unsignedLongValueForKey:(id<NSCopying>)key default:(unsigned long)def {
    RETURN_VALUE(unsignedLongValue,key,def);
}

- (long long)SILK_longLongValueForKey:(id<NSCopying>)key default:(long long)def {
    RETURN_VALUE(longLongValue,key,def);
}

- (unsigned long long)SILK_unsignedLongLongValueForKey:(id<NSCopying>)key default:(unsigned long long)def {
    RETURN_VALUE(unsignedLongLongValue,key,def);
}

- (float)SILK_floatValueForKey:(id<NSCopying>)key default:(float)def {
    RETURN_VALUE(floatValue,key,def);
}

- (double)SILK_doubleValueForKey:(id<NSCopying>)key default:(double)def {
    RETURN_VALUE(doubleValue,key,def);
}

- (NSInteger)SILK_integerValueForKey:(id<NSCopying>)key default:(NSInteger)def {
    RETURN_VALUE(integerValue,key,def);
}

- (NSUInteger)SILK_unsignedIntegerValueForKey:(id<NSCopying>)key default:(NSUInteger)def {
    RETURN_VALUE(unsignedIntegerValue,key,def);
}

- (NSNumber *)SILK_numberValueForKey:(id<NSCopying>)key default:(NSNumber *)def {
    if (!key) return def;
    id value = self[key];
    if (!value || value == [NSNull null]) return def;
    if ([value isKindOfClass:[NSNumber class]]) return value;
    if ([value isKindOfClass:[NSString class]]) return NSNumberFromID(value);
    return def;
}

- (NSString *)SILK_stringValueForKey:(id<NSCopying>)key default:(NSString *)def {
    if (!key) return def;
    id value = self[key];
    if (!value || value == [NSNull null]) return def;
    if ([value isKindOfClass:[NSString class]]) return value;
    if ([value isKindOfClass:[NSNumber class]]) return ((NSNumber *)value).description;
    return def;
}

- (NSArray *)SILK_arrayValueForKey:(id<NSCopying>)key default:(NSArray *)def {
    if (key == nil) {
        return def;
    }
    id value = self[key];
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return def;
}

- (NSDictionary *)SILK_dictionaryValueForKey:(id<NSCopying>)key default:(NSDictionary *)def {
    if (key == nil) {
        return def;
    }
    id value = self[key];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return def;
}

- (id)SILK_objectForKey:(id<NSCopying>)key default:(id)def {
    if (key == nil) {
        return def;
    }
    id value = self[key];
    return value ? : def;
}

- (void)SILK_forEach:(void (^)(id _Nonnull, id _Nonnull))block {
    NSParameterAssert(block != nil);
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        block(key, obj);
    }];
}

- (BOOL)SILK_contain:(BOOL (^)(id _Nonnull, id _Nonnull))block {
    NSParameterAssert(block != nil);
    __block BOOL result = NO;
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (block(key, obj)) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

- (BOOL)SILK_all:(BOOL (^)(id _Nonnull, id _Nonnull))block {
    NSParameterAssert(block != nil);
    __block BOOL result = YES;
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (!block(key, obj)) {
            result = NO;
            *stop = YES;
        }
    }];
    return result;
}

- (NSDictionary *)SILK_filter:(BOOL (^)(id _Nonnull, id _Nonnull))block {
    NSParameterAssert(block != nil);
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:self.count];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (block(key, obj)) {
            result[key] = obj;
        }
    }];
    return [result copy];
}

- (NSDictionary *)SILK_map:(id  _Nullable (^)(id _Nonnull, id _Nonnull))block {
    NSParameterAssert(block != nil);
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:self.count];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        result[key] = block(key, obj) ? : [NSNull null];
    }];
    return [result copy];
}

@end

@implementation NSMutableDictionary (SILKAdditions)

- (void)SILK_setObject:(id)anObject forKey:(id<NSCopying>)key {
    NSAssert(key != nil, @"set nil key");
    if (key != nil && anObject != nil) {
        [self setObject:anObject forKey:key];
    }
}

@end
