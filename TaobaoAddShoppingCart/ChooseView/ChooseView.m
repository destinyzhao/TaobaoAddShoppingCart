//
//  ChooseView.m
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/10.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ChooseView.h"
#import "TypeView.h"
#import "UIView+Size.h"

@interface ChooseView ()<TypeSeleteDelegete>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerViewHeightConstraint;
@property (strong, nonatomic) NSMutableArray *typeViewArray;
@property (strong, nonatomic) NSMutableArray *typeArray;
@property (strong, nonatomic) NSMutableDictionary *selectDic;
@property (copy, nonatomic) SelectBlock selectBlock;

@end

@implementation ChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/*
+ (instancetype)sharedInstance
{
    static ChooseView *_chooseView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_chooseView == nil) {
            _chooseView = [[[NSBundle mainBundle] loadNibNamed:@"ChooseView" owner:self options:nil] firstObject];
            _chooseView.frame = [[UIScreen mainScreen] bounds];
        }
    });
    return _chooseView;
}
*/

+ (instancetype)sharedInstance
{
    ChooseView *chooseView = [[[NSBundle mainBundle] loadNibNamed:@"ChooseView" owner:self options:nil] firstObject];
    chooseView.frame = [[UIScreen mainScreen] bounds];
    return chooseView;
}

- (void)addWindow
{
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    window.windowLevel = UIWindowLevelNormal;
    [window addSubview:self];
}

- (void)show:(NSMutableArray *)typeArray selectDic:(NSMutableDictionary *)selectDic block:(SelectBlock)block
{
    
    [self addWindow];
    
    self.selectBlock = block;
    
    _typeViewArray = [NSMutableArray array];
    _typeArray = typeArray;
    _selectDic = selectDic;
   
    for (NSInteger i = 0; i < typeArray.count; i++) {
        
        TypeView *typeView = [[TypeView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        typeView.tag = i;
        NSString *btnName = [selectDic objectForKey:[NSString stringWithFormat:@"%zd",i]];
        [typeView setTypeSource:typeArray[i] typeName:@"颜色" btnName:btnName];
        typeView.delegate = self;
        [self.centerView addSubview:typeView];
        
        [_typeViewArray addObject:typeView];
        
        if (i == 0) {
            typeView.frame = CGRectMake(0, 0, self.frame.size.width, typeView.height);
        }
        else
        {
            
            TypeView *tmpView = _typeViewArray[i-1];
            typeView.frame = CGRectMake(0, tmpView.bottom, self.frame.size.width, typeView.height);
        }
    }
    
    // 获取最后一个View
    NSInteger lastViewIndex = _typeViewArray.count - 1;
    TypeView *lastView = _typeViewArray[lastViewIndex];
    self.centerViewHeightConstraint.constant = lastView.bottom + 44 + 20;
}

-(void)btnindex:(NSInteger)btnTag viewTag:(NSInteger)viewTag select:(BOOL)select
{
    if (select) {
          [_selectDic setObject:[_typeArray[viewTag] objectAtIndex:btnTag] forKey:[NSString stringWithFormat:@"%zd",viewTag]];
    }
    else
    {
        [_selectDic removeObjectForKey:[NSString stringWithFormat:@"%zd",viewTag]];
    }
  
    TypeView *lastView = _typeViewArray[1];
    [lastView reloadTypeBtn:_typeArray[1]];
    NSLog(@"%@",_selectDic);
    if (self.selectBlock) {
        self.selectBlock(btnTag,viewTag,select,_selectDic);
    }
}

- (IBAction)closeBtnClicked:(id)sender {
    
    [self removeFromSuperview];
}



@end
