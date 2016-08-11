//
//  GoodsCommentView.m
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/11.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "GoodsCommentView.h"

@implementation GoodsCommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)sharedView
{
    GoodsCommentView *view = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCommentView" owner:self options:nil] firstObject];
    return view;
}

- (void)request
{
    NSLog(@"网络请求3");
}

@end
