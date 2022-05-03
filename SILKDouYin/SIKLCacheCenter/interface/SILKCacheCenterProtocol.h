//
//  SILKCacheCenterProtocol.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/5/1.
//

#import <Foundation/Foundation.h>

#import "SILKServiceCenter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SILKCacheCenter <SILKUniqueService>

@required

/**
 * 检测资源是否存在
 *
 * @param key 资源唯一标识符，存储时这个 id 会进行 sha1 计算作为存储 key
 * @return 存在返回 YES，否则返回 NO
 */
- (BOOL)isCacheExist:(NSString *)key;

/**
 * 检测视频资源是否存在
 *
 * @param key 资源唯一标识符，存储时这个 id 会进行 sha1 计算作为存储 key
 * @return 存在返回 YES，否则返回 NO
 */
- (BOOL)isVideoCacheExist:(NSString *)key;

/**
 * 根据 key 获取数据
 *
 * @param key 资源唯一标识符，存储时这个 id 会进行 sha1 计算作为存储 key
 * @return 资源二进制数据
 */
- (NSData *)dataForKey:(NSString *)key;

/**
 * 根据 key 获取视频数据
 *
 * @param key 资源唯一标识符，存储时这个 id 会进行 sha1 计算作为存储 key
 * @return 资源二进制数据
 */
- (NSData *)videoDataForKey:(NSString *)key;

/**
 * 根据 key 获取数据路径
 *
 * @param key 资源唯一标识符，存储时这个 id 会进行 sha1 计算作为存储 key
 * @return 资源路径
 */
- (NSString *)filePathForKey:(NSString *)key;

/**
 * 根据 key 获取视频数据路径
 *
 * @param key 资源唯一标识符，存储时这个 id 会进行 sha1 计算作为存储 key
 * @return 资源路径
 */
- (NSString *)videoFilePathForKey:(NSString *)key;

/**
 * 存储资源
 *
 * @param data 视频二进制数据
 * @param key 资源唯一标识符，存储时这个 id 会进行 sha1 计算作为存储 key
 */
- (void)setData:(NSData *)data forKey:(NSString *)key;

/**
 * 存储视频资源
 *
 * @param data 视频二进制数据
 * @param key 资源唯一标识符，存储时这个 id 会进行 sha1 计算作为存储 key
 */
- (void)setVideoData:(NSData *)data forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
