//
//  MainGoodsView.h
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/11.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScollBottomBlock)(void);

@interface MainGoodsView : UIView

@property (copy, nonatomic) ScollBottomBlock scollBottomBlock;

+ (instancetype)sharedView;

- (void)request;

@end
