//
//  MainGoodsView.m
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/11.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "MainGoodsView.h"

@interface MainGoodsView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adViewHeightConstraint;

@end

@implementation MainGoodsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    self.adViewHeightConstraint.constant = SCREEN_WIDTH;
}

+ (instancetype)sharedView
{
    MainGoodsView *view = [[[NSBundle mainBundle] loadNibNamed:@"MainGoodsView" owner:self options:nil] firstObject];
    return view;
}

- (void)request
{
    NSLog(@"网络请求1");
}

@end
