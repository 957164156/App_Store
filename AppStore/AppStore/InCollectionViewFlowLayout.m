//
//  InCollectionViewFlowLayout.m
//  AppStore
//
//  Created by 孙明卿 on 2016/12/9.
//  Copyright © 2016年 爱书人. All rights reserved.
//

#import "InCollectionViewFlowLayout.h"

@implementation InCollectionViewFlowLayout
//滚动的时候重新布局位置
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    
    //获取当前显示cell的布局
    NSArray *attrArray = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    
    
    return attrArray;
}

//确定最终的偏移量
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGFloat collectW = self.collectionView.bounds.size.width;
    
    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    
   //获取最终的区域范围
    CGRect targetRect = CGRectMake(targetP.x, 0, collectW, CGFLOAT_MAX);
    
    //获取最终显示的cell
    NSArray *arrtArray = [super layoutAttributesForElementsInRect:targetRect];
    //
    CGFloat marginToContent = 0;
    int i = 0;
    for (UICollectionViewLayoutAttributes *arrt in arrtArray) {
        i++;
        CGFloat Margin = 0;
        //找到第一个大于0的item的X
        if (arrt.frame.origin.x - targetP.x < 0 && i == 1){
            //找到第一个item并计算出距离原点的距离
            Margin = arrt.frame.origin.x - targetP.x - 15;
            marginToContent = Margin;
            continue;
        }
        if (i == 2) {
            Margin = arrt.frame.origin.x - targetP.x - 15;
            if (fabs(marginToContent) > fabs(Margin)) {
                marginToContent = Margin;
            }
            break;
        }
        if (i == 1) {
            //计算到他到左边边距的距离
            marginToContent = (arrt.frame.origin.x - targetP.x) - 15;
            
            break;
        }
       
        break;

    }
    //处理临界值
    if (targetP.x + collectW > self.collectionView.contentSize.width || targetP.x + collectW == self.collectionView.contentSize.width ) {
        return targetP;
    }
    NSLog(@" %f",targetP.x);
    // 移动间距
     targetP.x += marginToContent;

    return targetP;
}
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//
//    CGFloat collectW = self.collectionView.bounds.size.width;
//
//    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
//
//    NSLog(@" %f ======= %f",targetP.x,targetP.y);
//    //获取最终的区域范围
//    CGRect targetRect = CGRectMake(targetP.x, 0, collectW, CGFLOAT_MAX);
//
//    //获取最终显示的cell
//    NSArray *arrtArray = [super layoutAttributesForElementsInRect:targetRect];
//    //
//    CGFloat minCenter = CGFLOAT_MAX;
//    for (UICollectionViewLayoutAttributes *arrt in arrtArray) {
//        //获取距离中心点的距离
//        CGFloat centerContent = (arrt.center.x - targetP.x) - collectW * 0.5;
//        if (fabs(centerContent)  < fabs(minCenter)) {
//            minCenter = centerContent;
//        }
//    }
//    // 移动间距
//    targetP.x += minCenter;
//
//    if (targetP.x < 0) {
//        targetP.x = 0;
//    }
//
//    return targetP;
//}

// 作用:指定一段区域给你这段区域内cell的尺寸
// 可以一次性返回所有cell尺寸,也可以每隔一个距离返回cell
//- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    //    NSLog(@"%s",__func__);
//    // 设置cell尺寸 => UICollectionViewLayoutAttributes
//    // 越靠近中心点,距离越小,缩放越大
//    // 求cell与中心点距离
//
//    // 1.获取当前显示cell的布局
//    NSArray *attrs = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
//
//    for (UICollectionViewLayoutAttributes *attr in attrs) {
//
//        // 2.计算中心点距离
//        CGFloat delta = fabs((attr.center.x - self.collectionView.contentOffset.x) - self.collectionView.bounds.size.width * 0.5);
//
//        // 3.计算比例
//        CGFloat scale = 1 - delta / (self.collectionView.bounds.size.width * 0.5) * 0.25;
//
//        attr.transform = CGAffineTransformMakeScale(scale, scale);
//    }
//
//    return attrs;
//
//}
//
//// 什么时候调用:用户手指一松开就会调用
//// 作用:确定最终偏移量
//// 定位:距离中心点越近,这个cell最终展示到中心点
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
//
//    // 拖动比较快 最终偏移量 不等于 手指离开时偏移量
//    CGFloat collectionW = self.collectionView.bounds.size.width;
//
//    // 最终偏移量
//    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
//
//    // 0.获取最终显示的区域
//    CGRect targetRect = CGRectMake(targetP.x, 0, collectionW, MAXFLOAT);
//
//    // 1.获取最终显示的cell
//    NSArray *attrs = [super layoutAttributesForElementsInRect:targetRect];
//
//    // 获取最小间距
//    CGFloat minDelta = MAXFLOAT;
//    for (UICollectionViewLayoutAttributes *attr in attrs) {
//        // 获取距离中心点距离:注意:应该用最终的x
//        CGFloat delta = (attr.center.x - targetP.x) - self.collectionView.bounds.size.width * 0.5;
//
//        if (fabs(delta) < fabs(minDelta)) {
//            minDelta = delta;
//        }
//    }
//
//    // 移动间距
//    targetP.x += minDelta;
//
//    if (targetP.x < 0) {
//        targetP.x = 0;
//    }
//
//    return targetP;
//}
//
//// Invalidate:刷新
//// 在滚动的时候是否允许刷新布局
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
//    return YES;
//}
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//
//    // 取出屏幕的中心点
//    CGFloat screenCenter = self.collectionView.contentOffset.x + self.collectionView.frame.size.width/2;
//
//    // 这一步，取出手指离开时，屏幕上显式的cell
//    CGRect nowVisibleRect = (CGRect){self.collectionView.contentOffset, self.collectionView.frame.size};
//
//    NSArray<UICollectionViewLayoutAttributes*>* nowAttributes = [self layoutAttributesForElementsInRect:nowVisibleRect];
//
//    // 计算哪个cell距离屏幕中心最近
//    CGFloat minDistance = CGFLOAT_MAX;
//    int minIndex = -1;
//    for(int i = 0; i < nowAttributes.count; i++) {
//        UICollectionViewLayoutAttributes* attr = nowAttributes[i];
//        CGFloat distance =  attr.center.x - screenCenter;
//        if (fabs(distance) < fabs(minDistance)) {
//            minDistance = distance;
//            minIndex = i;
//        }
//    }
//
//    // 当力度大于0.3时，说明一定要切换到另一页
//    NSLog(@"%f", velocity.x);
//    if (fabs(velocity.x) > 0.3) {
//
//        // 右边还有元素
//        if ( velocity.x > 0 && nowAttributes.count-1 > minIndex) {
//            minDistance = nowAttributes[minIndex+1].center.x - screenCenter;
//        }else if(velocity.x < 0 && minIndex > 0) {
//            minDistance = nowAttributes[minIndex-1].center.x - screenCenter;
//        }
//    }
//
//    // 计算出目标点
//    CGPoint destPoint = CGPointMake(self.collectionView.contentOffset.x + minDistance, proposedContentOffset.y);
//
//
//    // 动画移动到指定位置
//    [UIView animateWithDuration:0.01 animations:^{
//        self.collectionView.contentOffset = destPoint;
//
//    }];
//    //[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction animations:^{
//   // } completion:nil];
//
//    // 返回值已经没有什么意义了
//    return destPoint;
//}

@end
