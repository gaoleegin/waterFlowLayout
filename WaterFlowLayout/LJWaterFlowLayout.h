//
//  LJWaterFlowLayout.h
//  瀑布流布局
//
//  Created by apple on 14/12/27.
//  Copyright (c) 2014年 gaolijun. All rights reserved.
//  瀑布流布局

#import <UIKit/UIKit.h>

@class LJWaterFlowLayout;
@protocol LJWaterflowLayoutDelegate <NSObject>
- (CGFloat)waterflowLayout:(LJWaterFlowLayout *)waterflowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;

@optional
/**
 *  返回四边的间距, 默认是UIEdgeInsetsMake(10, 10, 10, 10)
 */
- (UIEdgeInsets)insetsInWaterflowLayout:(LJWaterFlowLayout *)waterflowLayout;
/**
 *  返回最大的列数, 默认是3
 */
- (int)maxColumnsInWaterflowLayout:(LJWaterFlowLayout *)waterflowLayout;
/**
 *  返回每行的间距, 默认是10
 */
- (CGFloat)rowMarginInWaterflowLayout:(LJWaterFlowLayout *)waterflowLayout;
/**
 *  返回每列的间距, 默认是10
 */
- (CGFloat)columnMarginInWaterflowLayout:(LJWaterFlowLayout *)waterflowLayout;
@end

@interface LJWaterFlowLayout : UICollectionViewLayout
@property (nonatomic, weak) id<LJWaterflowLayoutDelegate> delegate;
@end