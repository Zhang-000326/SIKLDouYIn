//
//  SILKUserCollectionCell.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SILKUserCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *favoriteNum;

- (void)initDataWithVideoKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
