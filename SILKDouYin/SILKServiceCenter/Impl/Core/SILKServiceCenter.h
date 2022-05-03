//
//  SILKServiceCenter.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/5.
//

#import <Foundation/Foundation.h>
#import "SILKService.h"

NS_ASSUME_NONNULL_BEGIN

@interface SILKServiceCenter : NSObject

+ (SILKServiceCenter *)defaultCenter;

- (Class)getServiceClassFromProtocol:(Protocol *)protocol;

- (id)getServiceInstanceFromClass:(Class)cls;

- (id)getServiceInstanceFromProtocol:(Protocol *)protocol;

- (void)bindClass:(Class)cls toProtocol:(Protocol *)protocol;

- (void)unbindProtocol:(Protocol *)protocol;

- (void)removeServiceClass:(Class)cls;

#ifndef SILK_SERVICE
#define SILK_SERVICE

#define GET_CLASS_FROM_PROTOCOL(obj) \
    ( (Class<obj>) [[SILKServiceCenter defaultCenter] getServiceClassFromProtocol:@protocol(obj)] )

#define GET_INSTANCE_FROM_CLASS(obj) \
    ( (obj*) [[SILKServiceCenter defaultCenter] getServiceInstanceFromClass:[obj class]] )

#define GET_INSTANCE_FROM_PROTOCOL(obj) \
    ( (NSObject<obj> *) [[SILKServiceCenter defaultCenter] getServiceInstanceFromProtocol:@protocol(obj)] )

#define BIND_PROTOCOL(obj) \
    + (void)load { [[SILKServiceCenter defaultCenter] bindClass:self.class toProtocol:@protocol(obj)]; }

#define UNBIND_PROTOCOL(obj) \
    ( [[SILKServiceCenter defaultCenter] unbindProtocol:@protocol(obj)] )

#define REMOVE_SERVICE(obj) \
    ( [[SILKServiceCenter defaultCenter] removeServiceClass:[obj class]] )

#endif

@end

NS_ASSUME_NONNULL_END
