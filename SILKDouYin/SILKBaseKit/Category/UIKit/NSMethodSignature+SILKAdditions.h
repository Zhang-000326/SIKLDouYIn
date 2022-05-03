//
//  NSMethodSignature+SILKAdditions.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMethodSignature (SILKAdditions)

/**
 以 NSString 格式返回当前 NSMethodSignature 的 typeEncoding，例如 v@:
 */
@property(nullable, nonatomic, copy, readonly) NSString *SILK_typeString;

/**
 以 const char 格式返回当前 NSMethodSignature 的 typeEncoding，例如 v@:
 */
@property(nullable, nonatomic, readonly) const char *SILK_typeEncoding;

@end

NS_ASSUME_NONNULL_END
