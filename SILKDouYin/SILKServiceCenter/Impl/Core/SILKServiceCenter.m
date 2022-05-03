//
//  SILKServiceCenter.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/5.
//

#import "SILKServiceCenter.h"

#import "NSDictionary+SILKAdditions.h"

@interface SILKServiceCenter (){
    NSMutableDictionary *p_hashServiceClassToInstance;
    NSMutableDictionary *p_hashServiceProtocolToClass;
    NSRecursiveLock     *p_lock;
}
@end

@implementation SILKServiceCenter

- (instancetype)initPrivate {
    self = [super init];
    if(self){
        p_hashServiceClassToInstance = [[NSMutableDictionary alloc] init];
        p_hashServiceProtocolToClass = [[NSMutableDictionary alloc] init];
        p_lock = [[NSRecursiveLock alloc] init];
    }
    return self;
}

- (void)dealloc
{
    if(p_hashServiceClassToInstance != nil){
        p_hashServiceClassToInstance = nil;
    }
    
    p_lock = nil;
}

#pragma mark - Public

+ (SILKServiceCenter *)defaultCenter {
    static SILKServiceCenter *serviceCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serviceCenter = [[SILKServiceCenter alloc] initPrivate];
    });
    return serviceCenter;
}

- (Class)getServiceClassFromProtocol:(Protocol *)protocol {
    NSString *protocolName = NSStringFromProtocol(protocol);
    [p_lock lock];
    
    Class cls = [p_hashServiceProtocolToClass objectForKey:protocolName];
    
    if (!cls) {
        cls = NSClassFromString(protocolName);
    }
    
    [p_lock unlock];
    return cls;
}

- (id)getServiceInstanceFromClass:(Class)cls {
    [p_lock lock];
    
    id obj = [p_hashServiceClassToInstance objectForKey:cls];
    if (!obj) {
        if (![cls isSubclassOfClass:[SILKService class]]) {
            [p_lock unlock];
            return nil;
        }
        
        if (![cls conformsToProtocol:@protocol(SILKService)]) {
            [p_lock unlock];
            return nil;
        }
        
        if ([cls conformsToProtocol:@protocol(SILKUniqueService)]) {
            obj = [cls sharedInstance];
        } else {
            obj = [[cls alloc] init];
        }
        
        [p_hashServiceClassToInstance setObject:obj forKey:(id<NSCopying>)cls];
        [p_lock unlock];
        
        if ([obj respondsToSelector:@selector(onServiceInit)]) {
            [obj onServiceInit];
        }
    } else {
        [p_lock unlock];
    }
    
    return obj;
}

- (id)getServiceInstanceFromProtocol:(Protocol *)protocol {
    NSString *protocolName = NSStringFromProtocol(protocol);
    [p_lock lock];
    
    Class cls = [p_hashServiceProtocolToClass objectForKey:protocolName];
    if (!cls) {
        cls = NSClassFromString(protocolName);
    }
    
    [p_lock unlock];
    return [self getServiceInstanceFromClass:cls];
}

- (void)bindClass:(Class)cls toProtocol:(Protocol *)protocol {
    NSParameterAssert(cls && [cls conformsToProtocol:@protocol(SILKService)]);
    NSParameterAssert(protocol);

    NSString *protocolName = NSStringFromProtocol(protocol);
    if (![p_hashServiceProtocolToClass objectForKey:protocolName]) {
        [p_lock lock];
        [p_hashServiceProtocolToClass setObject:cls forKey:protocolName];
        [p_lock unlock];
    }
}

- (void)unbindProtocol:(Protocol *)protocol {
    NSParameterAssert(protocol);
    
    NSString *protocolName = NSStringFromProtocol(protocol);
    
    [p_lock lock];
    Class cls = [p_hashServiceProtocolToClass objectForKey:protocolName];
    [p_hashServiceProtocolToClass removeObjectForKey:protocolName];
    [p_lock unlock];
    
    if (!cls) {
        cls = NSClassFromString(protocolName);
    }
    [self removeServiceClass:cls];
}

- (void)removeServiceClass:(Class)cls {
    [p_lock lock];
    
    SILKService<SILKService> *obj = [p_hashServiceClassToInstance objectForKey:cls];
    
    if(obj == nil){
        [p_lock unlock];
        return ;
    }
    
    [p_hashServiceClassToInstance removeObjectForKey:cls];
    [p_lock unlock];
    obj = nil;
}

@end
