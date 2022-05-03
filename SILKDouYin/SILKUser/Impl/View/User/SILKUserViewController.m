//
//  SILKUserViewController.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/16.
//

#import "SILKUserViewController.h"

#import "SILKUserManager.h"

// model
#import "SILKUserModel.h"

// view
#import "SILKUserInfoHeader.h"
#import "SILKUserSlideTabBar.h"
#import "SILKUserCollectionCell.h"
#import "SILKUserCollectionFlowLayout.h"

#import "SILKFeedManagerProtocol.h"

#define kUserInfoHeaderHeight 320 + NAVBAR_HEIGHT
#define kSlideTabBarHeight 40

NSString * const kUserInfoCell          = @"UserInfoCell";
NSString * const kUserCollectionCell    = @"kUserCollectionCell";

@interface SILKUserViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, SILKUserSlideTabBarDelegate>

@property (nonatomic, copy) NSString  *uid;
@property (nonatomic, strong) SILKUserModel *user;
@property (nonatomic, strong) NSMutableArray *workAwemes;
@property (nonatomic, strong) NSMutableArray *favoriteAwemes;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) NSInteger tabIndex;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) SILKUserInfoHeader *userInfoHeader;

@end

@implementation SILKUserViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _workAwemes = [[NSMutableArray alloc]init];
        _favoriteAwemes = [[NSMutableArray alloc]init];
        _pageIndex = 0;
        _pageSize = 18;
        
        _tabIndex = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor clearColor]}];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
}

- (void)initCollectionView {
    _itemWidth = (SCREEN_WIDTH - (CGFloat)(((NSInteger)(SCREEN_WIDTH)) % 3) ) / 3.0f - 1.0f;
    _itemHeight = _itemWidth * 1.35f;
    SILKUserCollectionFlowLayout *layout = [[SILKUserCollectionFlowLayout alloc] initWithTopHeight:NAVBAR_HEIGHT + kSlideTabBarHeight];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView  alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;


    _collectionView.alwaysBounceVertical = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[SILKUserInfoHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kUserInfoCell];
    [_collectionView registerClass:[SILKUserCollectionCell class] forCellWithReuseIdentifier:kUserCollectionCell];
    [self.view addSubview:_collectionView];
}

- (void)updateNavigationTitle:(CGFloat)offsetY {
    if (kUserInfoHeaderHeight - [self navagationBarHeight]*2 > offsetY) {
        [self setNavigationBarTitleColor:[UIColor clearColor]];
    }
    if (kUserInfoHeaderHeight - [self navagationBarHeight]*2 < offsetY && offsetY < kUserInfoHeaderHeight - [self navagationBarHeight]) {
        CGFloat alphaRatio =  1.0f - (kUserInfoHeaderHeight - [self navagationBarHeight] - offsetY)/[self navagationBarHeight];
        [self setNavigationBarTitleColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:alphaRatio]];
    }
    if (offsetY > kUserInfoHeaderHeight - [self navagationBarHeight]) {
        [self setNavigationBarTitleColor:[UIColor colorWithWhite:1 alpha:1]];
    }
}

//UICollectionViewDataSource Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && kind == UICollectionElementKindSectionHeader) {
        SILKUserInfoHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kUserInfoCell forIndexPath:indexPath];
        _userInfoHeader = header;
        if(_user) {
            [header initData:_user];
        }
        header.slideTabBar.delegate = self;
        return header;
    }
    return [UICollectionReusableView new];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 1) {
        NSUInteger videoCount = [[GET_INSTANCE_FROM_PROTOCOL(SILKFeedManager) feedVideoKeyArray] count];
        return _tabIndex == 0 ? videoCount : videoCount / 2;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SILKUserCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kUserCollectionCell forIndexPath:indexPath];
    NSString *videoKey = [[GET_INSTANCE_FROM_PROTOCOL(SILKFeedManager) feedVideoKeyArray] SILK_objectAtIndex:indexPath.row];
    [cell initDataWithVideoKey:videoKey];
    return cell;
}

//UICollectionFlowLayout Delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return CGSizeMake(SCREEN_WIDTH, kUserInfoHeaderHeight);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(_itemWidth, _itemHeight);
}

//UIScrollViewDelegate Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        [_userInfoHeader overScrollAction:offsetY];
    }else {
        [_userInfoHeader scrollToTopAction:offsetY];
        [self updateNavigationTitle:offsetY];
    }
}

//SILKUserSlideTabBarDelegate
- (void)tabBarTapAction:(NSInteger)index {
    if(_tabIndex == index){
        return;
    }
    _tabIndex = index;
    _pageIndex = 0;
    
    [UIView setAnimationsEnabled:NO];
    [self.collectionView performBatchUpdates:^{
        [self.workAwemes removeAllObjects];
        [self.favoriteAwemes removeAllObjects];
        
        if([self.collectionView numberOfItemsInSection:1]) {
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
        }
    } completion:^(BOOL finished) {
        [UIView setAnimationsEnabled:YES];
        
        [self loadData:self.pageIndex pageSize:self.pageSize];
    }];
    
}

- (void)loadData:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
   
}

- (void) setNavigationBarTitleColor:(UIColor *)color {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color}];
}

- (CGFloat)navagationBarHeight {
    return self.navigationController.navigationBar.frame.size.height;
}

@end
