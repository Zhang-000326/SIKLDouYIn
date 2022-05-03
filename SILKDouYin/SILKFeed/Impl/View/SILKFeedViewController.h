//
//  SILKFeedViewController.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/19.
//

#import <UIKit/UIKit.h>

#import "SILKFeedDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface SILKFeedViewController : SILKBaseViewController

@property (nonatomic, strong) UITableView *feedTableView;
@property (nonatomic, assign) NSInteger currentIndex;

- (instancetype)initWithFeedModels:(NSArray *)models;

@end

NS_ASSUME_NONNULL_END
