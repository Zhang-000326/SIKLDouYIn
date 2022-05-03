//
//  SILKUserCollectionFlowLayout.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SILKUserCollectionFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGFloat      topHeight;

- (instancetype)initWithTopHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
