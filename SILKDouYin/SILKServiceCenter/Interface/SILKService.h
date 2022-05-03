//
//  Header.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SILKService <NSObject>

@optional

- (void)onServiceInit;

@end

@protocol SILKUniqueService <SILKService>

+ (instancetype)sharedInstance;

@end

@protocol SILKInstanceService <SILKService>

@end

@interface SILKService : NSObject

@end

NS_ASSUME_NONNULL_END
