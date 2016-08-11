//
//  GoodsDetailView.m
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/11.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "GoodsDetailView.h"

@implementation GoodsDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)sharedView
{
    GoodsDetailView *view = [[[NSBundle mainBundle] loadNibNamed:@"GoodsDetailView" owner:self options:nil] firstObject];
    return view;
}

- (void)request
{
    NSLog(@"网络请求2");
}

@end
