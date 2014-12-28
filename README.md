waterFlowLayout
===============

This is a use of CollectionView to achieve the waterfall flow!

使用方法：
将waterFlowLayout拖入自己的工程
引入头文件：#import "LJWaterFlowLayout.h"
//使用自定义瀑布流，并设置代理
    LJWaterFlowLayout *layout = [[LJWaterFlowLayout alloc]init];
    layout.delegate = self;
    
    实现代理的方法：
   //告诉每一个cell的高度，必须实现此方法
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
