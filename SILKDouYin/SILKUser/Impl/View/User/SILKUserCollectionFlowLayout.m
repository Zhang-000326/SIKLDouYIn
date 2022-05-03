//
//  SILKUserCollectionFlowLayout.m
//  SILKDouYin
//
//  Created by 张骞 on 2022/4/17.
//

#import "SILKUserCollectionFlowLayout.h"

#import "SILKUserDefine.h"

@implementation SILKUserCollectionFlowLayout

- (instancetype)initWithTopHeight:(CGFloat)height{
    self = [super init];
    if (self){
        self.topHeight = height;
    }
    return self;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray<UICollectionViewLayoutAttributes *> *superArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (UICollectionViewLayoutAttributes *attributes in [superArray mutableCopy]) {
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [superArray removeObject:attributes];
        }
    }
    
    [superArray SILK_addObject:[super layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]]];
  
    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        
        if(attributes.indexPath.section == 0) {
            
            if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]){
                CGRect rect = attributes.frame;
                if(self.collectionView.contentOffset.y + self.topHeight - rect.size.height > rect.origin.y) {
                    rect.origin.y =  self.collectionView.contentOffset.y + self.topHeight - rect.size.height;
                    attributes.frame = rect;
                }
                attributes.zIndex = 5;
            }
        }
        
    }
    return [superArray copy];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBound {
    return YES;
}

@end
