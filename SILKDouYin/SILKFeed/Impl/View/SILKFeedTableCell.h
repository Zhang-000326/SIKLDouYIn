//
//  SILKFeedTableCell.h
//  SILKDouYin
//
//  Created by 张骞 on 2022/3/19.
//

#import <UIKit/UIKit.h>

typedef void (^OnPlayerReady)(void);

@class SILKFeedModel;
@class SILKAVPlayerView;
@class SILKFeedMusicNameLabel;
@class SILKFeedMusicCDView;
@class SILKFeedLoveView;
@class SILKFeedFocusView;

NS_ASSUME_NONNULL_BEGIN

@interface SILKFeedTableCell : UITableViewCell

@property (nonatomic, strong) SILKFeedModel            *feedModel;

@property (nonatomic, strong) SILKAVPlayerView     *playerView;

@property (nonatomic, strong) SILKFeedMusicNameLabel   *musicNameLabel;
@property (nonatomic, strong) UILabel          *descLabel;
@property (nonatomic, strong) UILabel          *authorNameLabel;

@property (nonatomic, strong) UIImageView      *authorAvatarView;
@property (nonatomic, strong) SILKFeedFocusView        *focusView;
@property (nonatomic, strong) SILKFeedMusicCDView   *musicCD;

@property (nonatomic, strong) UIImageView      *shareView;
@property (nonatomic, strong) UIImageView      *commentView;

@property (nonatomic, strong) SILKFeedLoveView     *loveView;

@property (nonatomic, strong) UILabel          *shareNum;
@property (nonatomic, strong) UILabel          *commentNum;
@property (nonatomic, strong) UILabel          *loveNum;

@property (nonatomic, strong) OnPlayerReady    onPlayerReady;
@property (nonatomic, assign) BOOL             isPlayerReady;

- (void)loadFeedModel:(SILKFeedModel *)feedModel;
- (void)loadVideoResource;
- (void)play;
- (void)pause;
- (void)replay;

@end

NS_ASSUME_NONNULL_END
