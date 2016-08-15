//
//  AdPlayView.h
//  AdPlayView
//
//  Created by Alex on 16/3/17.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AdSelectIndexBlock)(NSInteger selectIndex);

@interface AdPlayView : UIView
/**
 *  图片数组
 */
@property (nonatomic,strong) NSArray *imgsArray;
/**
 *  默认图片
 */
@property (nonatomic,copy ) NSString *placeholderImage;
/**
 *  Block 回调
 */
@property (copy, nonatomic) AdSelectIndexBlock adSelectIndexBlock;

/**
 *  点击响应block回调
 *
 *  @param block
 */
- (void)tapActionBlock:(AdSelectIndexBlock)block;

@end
