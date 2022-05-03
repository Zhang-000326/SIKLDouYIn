//
//  SILKUserViewController.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/16.
//

#import <UIKit/UIKit.h>

#import "SILKUserDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface SILKUserViewController : SILKBaseViewController

@property (nonatomic, strong) UICollectionView                 *collectionView;

@property (nonatomic, assign) NSInteger                        selectIndex;

@end

NS_ASSUME_NONNULL_END
