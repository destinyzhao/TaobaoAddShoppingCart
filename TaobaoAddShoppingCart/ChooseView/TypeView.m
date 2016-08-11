//
//  TypeView.m
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/10.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "TypeView.h"

@interface TypeView ()
/**
 *  按钮数组
 */
@property (strong, nonatomic) NSMutableArray *btnArray;
/**
 *  当前选择Index
 */
@property(assign, nonatomic) NSInteger seletIndex;


@end

@implementation TypeView

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

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setTypeSource:(NSArray *)arr typeName:(NSString *)typeName btnName:(NSString *)btnName
{
    
    self.seletIndex = -1;
    
    NSLog(@"subviews count:%zd",self.subviews.count);
    
    // 分类名称Label
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    lab.text = typeName;
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont systemFontOfSize:14];
    [self addSubview:lab];
    
    // 是否需要换行
    BOOL isLineWrap = NO;
    // origin x 初始值
    CGFloat originX = 10;
    // origin y 初始值
    CGFloat originY = 40;
    // view frame
    CGFloat width = self.frame.size.width;
    
    for (int i = 0; i<arr.count; i++) {
        NSString *str = [arr objectAtIndex:i] ;
        
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14] forKey:NSFontAttributeName];
        // type size
        CGSize typeSize = [str sizeWithAttributes:dic];
        // btn width
        CGFloat btnWidth = typeSize.width + 30;
        // btn height
        CGFloat btnHeight = 25;
        // btn max width
        CGFloat maxBtnWith = self.frame.size.width - 40;
        // space height
        CGFloat spaceHeight = 30;
        // space width
        CGFloat spaceWidth = 35;
        
        if ( originX > (width - 2*originX - typeSize.width - spaceWidth)) {
            isLineWrap = YES;
            originX = 10;
            originY += spaceHeight;
        }
        
        NSString *btnTitle = [arr objectAtIndex:i];
        // create btn
        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(originX, originY, btnWidth>maxBtnWith?maxBtnWith:btnWidth,btnHeight);
        [btn setTitleColor:[UIColor colorWithRed:227/255.0 green:71/255.0 blue:91/255.0 alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        btn.layer.cornerRadius = 2;
        btn.layer.borderColor = [UIColor colorWithRed:227/255.0 green:71/255.0 blue:91/255.0 alpha:1].CGColor;
        btn.layer.borderWidth = 1;
        [btn.layer setMasksToBounds:YES];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(touchbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        if ([btnTitle isEqualToString:btnName]) {
            [self touchbtn:btn];
        }
        
        // update originX
        originX += typeSize.width + spaceWidth;
        
        [self.btnArray addObject:btn];
    }
    
    originY += 30;
    
    // 分割线
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, originY+10, self.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    // update view frame
    CGFloat height = originY+11;
    [self updateFrame:height];
}

#pragma mark -
#pragma mark - 更新frame
- (void)updateFrame:(CGFloat)height
{
    self.frame = CGRectMake(0, 0, self.frame.size.width, height);
}

#pragma mark -
#pragma mark -  按钮点击事件
-(void)touchbtn:(UIButton *)btn
{
    [self resumeBtn];
    
    self.seletIndex = (NSInteger)btn.tag-100;
    
    if (btn.selected == NO) {
        btn.selected = YES;
        btn.backgroundColor = [UIColor colorWithRed:227/255.0 green:71/255.0 blue:91/255.0 alpha:1];
        
        [self.delegate btnindex:_seletIndex viewTag:self.tag select:YES];
    }
    else
    {
        self.seletIndex = -1;
        btn.selected = NO;
        btn.backgroundColor = [UIColor whiteColor];
        
        [self.delegate btnindex:_seletIndex viewTag:self.tag select:NO];
    }
}

#pragma mark -
#pragma mark - 恢复按钮的原始状态
-(void)resumeBtn
{
    
    for (int i = 0; i< self.btnArray.count; i++) {
        UIButton *btn =(UIButton *) [self viewWithTag:100+i];
        btn.enabled = YES;
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor whiteColor]];
        // set borderColor
        btn.layer.borderColor = [UIColor colorWithRed:227/255.0 green:71/255.0 blue:91/255.0 alpha:1].CGColor;
        // set TitleColor:
        [btn setTitleColor:[UIColor colorWithRed:227/255.0 green:71/255.0 blue:91/255.0 alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        if (self.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitleColor:[UIColor colorWithRed:227/255.0 green:71/255.0 blue:91/255.0 alpha:1] forState:UIControlStateSelected];
        }
    }
}

#pragma mark - 
#pragma mark - 那些按钮组合不可用
-(void)reloadTypeBtn:(NSMutableArray *)btnArray
{
    for (NSInteger i = 0; i<btnArray.count; i++) {

        UIButton *btn =(UIButton *)[self viewWithTag:100+i];
        if (btn.tag == 100 || btn.tag == 102) {
            btn.selected = NO;
            btn.enabled = NO;
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.layer.borderColor = [UIColor grayColor].CGColor;
        }
    }

}


@end
