//
//  ChooseView.h
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/10.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBlock)(NSInteger btnTag ,NSInteger viewTag, BOOL select, NSMutableDictionary *selectDic);


@interface ChooseView : UIView

+ (instancetype)sharedInstance;

- (void)show:(NSMutableArray *)typeArray selectDic:(NSMutableDictionary *)selectDic block:(SelectBlock)block;

@end
