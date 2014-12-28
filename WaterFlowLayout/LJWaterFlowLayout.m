//
//  LJWaterflowLayout.m
//  02-瀑布流布局
//
//  Created by apple on 14/12/27.
//  Copyright (c) 2014年 gaolijun. All rights reserved.
//

#import "LJWaterFlowLayout.h"

/** 每一行的最大列数 */
static const int LJDefaultMaxColumns = 3;
/** 每一行的间距 */
static const CGFloat LJDefaultRowMargin = 10;
/** 每一列的间距 */
static const CGFloat LJDefaultColumnMargin = 10;
/** 上下左右的间距 */
static const UIEdgeInsets LJDefaultInsets = {10, 10, 10, 10};

@interface LJWaterFlowLayout()
/** 存放每一列的最大Y值(整体高度) */
@property (nonatomic, strong) NSMutableArray *maxYs;
@end

@implementation LJWaterFlowLayout

- (NSMutableArray *)maxYs
{
    if (!_maxYs) {
        self.maxYs = [[NSMutableArray alloc] init];
    }
    return _maxYs;
}

- (void)prepareLayout
{
    //    NSLog(@"prepareLayout");
}

/**
 *  如果返回YES, 当显示的范围发生改变时就会重新刷新
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 * 返回collectionView的ContentSize
 */
- (CGSize)collectionViewContentSize
{
    CGFloat longMaxY = 0;
    if (self.maxYs.count) {
        longMaxY = [self.maxYs[0] doubleValue]; // 最长那一列 的 最大Y值
        for (int i = 1; i < self.maxColumns; i++) {
            CGFloat maxY = [self.maxYs[i] doubleValue];
            if (maxY > longMaxY) {
                longMaxY = maxY;
            }
        }
        
        // 累加底部的间距
        longMaxY += self.insets.bottom;
    }
    return CGSizeMake(0, longMaxY);
}

/**
 *  indexPath这个位置对应cell的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 每一列之间的间距
    CGFloat columnMargin = self.columnMargin;
    // 每一行之间的间距
    CGFloat rowMargin = self.rowMargin;
    
    // CollectionView的尺寸
    CGFloat collectionW = self.collectionView.bounds.size.width;
    
    int maxColumns = self.maxColumns;
    UIEdgeInsets insets = self.insets;
    // item(cell)的宽度
    CGFloat itemW = (collectionW - insets.left - insets.right - (maxColumns - 1) * columnMargin) / maxColumns;
    // 询问代理. indexPath这个位置item的高度
    CGFloat itemH = [self.delegate waterflowLayout:self heightForItemAtIndexPath:indexPath itemWidth:itemW];
    
    // 创建属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 设置位置和尺寸
    CGFloat minMaxY = [self.maxYs[0] doubleValue]; // 最短那一列 的 最大Y值
    int minColumn = 0; // 最短那一列 的 列号
    for (int i = 1; i < maxColumns; i++) {
        CGFloat maxY = [self.maxYs[i] doubleValue];
        if (maxY < minMaxY) {
            minMaxY = maxY;
            minColumn = i;
        }
    }
    
    CGFloat itemX = insets.left + minColumn * (itemW + columnMargin);
    CGFloat itemY = minMaxY + rowMargin;
    attrs.frame = CGRectMake(itemX, itemY, itemW, itemH);
    
    // 累加这一列的最大Y值
    self.maxYs[minColumn] = @(CGRectGetMaxY(attrs.frame));
    
    return attrs;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"layoutAttributesForElementsInRect");
    // 初始化最大y值数组
    [self.maxYs removeAllObjects];
    for (NSUInteger i = 0; i < self.maxColumns; i++) {
        [self.maxYs addObject:@(self.insets.top)];
    }
    
    // 计算所有cell的布局属性
    NSMutableArray *array = [NSMutableArray array];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attrs];
    }
    return array;
}

#pragma mark - 私有方法(获得代理返回的数字)
- (int)maxColumns
{
    if ([self.delegate respondsToSelector:@selector(maxColumnsInWaterflowLayout:)]) {
        return [self.delegate maxColumnsInWaterflowLayout:self];
    }
    return LJDefaultMaxColumns;
}

- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    }
    return LJDefaultRowMargin;
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    }
    return LJDefaultColumnMargin;
}

- (UIEdgeInsets)insets
{
    if ([self.delegate respondsToSelector:@selector(insetsInWaterflowLayout:)]) {
        return [self.delegate insetsInWaterflowLayout:self];
    }
    return LJDefaultInsets;
}

@end
