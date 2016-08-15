//
//  DDSegmentView.h
//  DDSegmentView
//
//  Created by Alex on 16/4/8.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SegmentBlock)(NSInteger index);

@interface DDSegmentView : UIView
/**
 *  title 数组
 */
@property (strong, nonatomic) NSArray *titleArray;
/**
 *  更新Title 数组
 */
@property (strong, nonatomic) NSArray *updateTitleArray;
/**
 *  当前选中
 */
@property (assign, nonatomic) NSInteger currentSelectedIndex;
/**
 *  Block
 */
@property (copy, nonatomic)SegmentBlock segmentBlock;


/**
 *  设置Block
 *
 *  @param segmentBlock segmentBlock description
 */
- (void)segmentBlock:(SegmentBlock)segmentBlock;

- (void)createSegmentWithTitleArray:(NSArray *)titleArray segmentWidth:(CGFloat)segmentWidth font:(UIFont *)font normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

- (void)setLineColor:(UIColor *)color;

@end
