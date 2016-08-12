//
//  ServiceTagView.m
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/12.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ServiceTagView.h"

@implementation ServiceTagView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)setTagSource:(NSArray *)arr  font:(UIFont *)font normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor enabled:(BOOL)enabled
{
  
    // 是否需要换行
    BOOL isLineWrap = NO;
    // origin x 初始值
    CGFloat originX = 10;
    // origin y 初始值
    CGFloat originY = 5;
    // view frame
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    
    for (int i = 0; i<arr.count; i++) {
        NSString *str = [arr objectAtIndex:i] ;
        
        NSDictionary *dic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        // type size
        CGSize typeSize = [str sizeWithAttributes:dic];
        // btn width
        CGFloat btnWidth = typeSize.width + 10;
        // btn height
        static CGFloat btnHeight = 20;
        // btn max width
        CGFloat maxBtnWith = width - 20;
        // 两个button 高度间距
        static CGFloat spaceHeight = 25;
        // 两个button 宽度间距
        static CGFloat spaceWidth = 15;
        // 距离屏幕左边+右边的距离
        static CGFloat space = 20;
        
        if ( originX > (width - space - typeSize.width - spaceWidth)) {
            isLineWrap = YES;
            originX = 10;
            originY += spaceHeight;
        }
        
        NSString *btnTitle = [arr objectAtIndex:i];
        // create btn
        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(originX, originY, btnWidth>maxBtnWith?maxBtnWith:btnWidth,btnHeight);
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
        [btn setTitleColor:selectedColor forState:UIControlStateSelected];
        [btn setBackgroundColor:backgroundColor];
        btn.titleLabel.font = font;
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        btn.layer.cornerRadius = 2;
        if (borderColor) {
            btn.layer.borderColor = borderColor.CGColor;
            btn.layer.borderWidth = 1;
        }
        btn.enabled = enabled;
        [btn.layer setMasksToBounds:YES];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(touchbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        
        // update originX
        originX += typeSize.width + spaceWidth;
    }
    
    originY += 30;
    
    // update view frame
    [self updateFrame:originY];
}

#pragma mark -
#pragma mark - 更新frame
- (void)updateFrame:(CGFloat)height
{
    self.frame = CGRectMake(0, 0, self.frame.size.width, height);
}

- (void)touchbtn:(UIButton *)sender
{
    
}


@end
