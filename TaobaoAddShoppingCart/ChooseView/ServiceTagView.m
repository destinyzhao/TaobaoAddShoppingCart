//
//  ServiceTagView.m
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/12.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ServiceTagView.h"

@interface ServiceTagView ()

@property (strong, nonatomic) NSMutableArray *btnArray;
@property (strong, nonatomic) UIColor *titleNormalColor;
@property (strong, nonatomic) UIColor *titleSelectedColor;
@property (strong, nonatomic) UIColor *normalBackgroundColor;
@property (strong, nonatomic) UIColor *selectedBackgroundColor;
@property (strong, nonatomic) UIColor *borderColor;
@property (strong, nonatomic) UIFont *font;

@end

@implementation ServiceTagView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)setTagSource:(NSArray *)arr  font:(UIFont *)font titleNormalColor:(UIColor *)titleNormalColor titleSelectedColor:(UIColor *)titleSelectedColor normalBackgroundColor:(UIColor *)normalBackgroundColor selectedBackgroundColor:(UIColor *)selectedBackgroundColor  borderColor:(UIColor *)borderColor enabled:(BOOL)enabled
{
  
    self.titleNormalColor = titleNormalColor;
    self.titleSelectedColor = titleSelectedColor;
    self.normalBackgroundColor = normalBackgroundColor;
    self.selectedBackgroundColor = selectedBackgroundColor;
    self.borderColor = borderColor;
    self.font = font;
    
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
        
        if (self.titleNormalColor) {
            [btn setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        }
        
        if (self.titleSelectedColor) {
            [btn setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
        }
        
        if (normalBackgroundColor) {
            [btn setBackgroundImage:[self imageWithColor:normalBackgroundColor] forState:UIControlStateNormal];
        }
        
        if (selectedBackgroundColor) {
            [btn setBackgroundImage:[self imageWithColor:selectedBackgroundColor] forState:UIControlStateSelected];
        }
        
        if (borderColor) {
            btn.layer.borderColor = borderColor.CGColor;
            btn.layer.borderWidth = 1;
        }
        
        if (enabled) {
            if (i == 0) {
                btn.selected = YES;
            }
        }
        
        btn.titleLabel.font = font;
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        btn.layer.cornerRadius = 2;
        
        btn.enabled = enabled;
        [btn.layer setMasksToBounds:YES];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(touchbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        [self.btnArray addObject:btn];
        
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

    NSInteger index = sender.tag - 100 ;
    
    for (int i = 0; i< self.btnArray.count; i++) {
        UIButton *btn =(UIButton *) [self viewWithTag:100+i];
        btn.enabled = YES;
        
        if (index == i) {
            btn.selected = YES;
        }
        else
        {
            btn.selected = NO;
        }
        
        if (self.normalBackgroundColor) {
            [btn setBackgroundImage:[self imageWithColor:self.normalBackgroundColor] forState:UIControlStateNormal];
        }
        
        if (self.selectedBackgroundColor) {
            [btn setBackgroundImage:[self imageWithColor:self.selectedBackgroundColor] forState:UIControlStateSelected];
        }
        
        if (self.borderColor) {
            // set borderColor
            btn.layer.borderColor = self.borderColor.CGColor;
        }
       
        if (self.titleNormalColor) {
            [btn setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        }
        
        if (self.titleSelectedColor) {
            [btn setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
        }
    }
    
    if (self.selectedTagBlock) {
        self.selectedTagBlock(index);
    }
    
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
