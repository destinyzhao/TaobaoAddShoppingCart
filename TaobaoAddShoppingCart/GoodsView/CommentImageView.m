//
//  GoodsImageView.m
//  sis-supermarket
//
//  Created by Alex on 16/6/3.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "CommentImageView.h"
//#import <AppOrderService.h>

#define ImageViewHeigh 40.0
#define ImageViewWidth 40.0

@interface CommentImageView()

@property (strong, nonatomic) UIScrollView  *scrollView;

@end

@implementation CommentImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithSetting];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initWithSetting];
    }
    return self;
}

- (void)initWithSetting
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.size.width-4, self.size.height)];
    _scrollView.directionalLockEnabled = YES; //只能一个方向滑动
    _scrollView.pagingEnabled = NO; //是否翻页
    _scrollView.showsVerticalScrollIndicator = NO; //垂直方向的滚动指示
    _scrollView.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
    _scrollView.userInteractionEnabled = YES;
    [self addSubview:_scrollView];
}

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    for (UIImageView *imgView in _scrollView.subviews) {
        [imgView removeFromSuperview];
    }
    
    [imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < 4) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.frame = CGRectMake(5+idx*(ImageViewWidth+5), 0, ImageViewWidth, ImageViewHeigh);
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.tag = 100 + idx;
            
//            apporderOrderProductIceModule *iceModel = (apporderOrderProductIceModule*)obj;
//            
//            if (![ImageCache isImageCache:iceModel.pitureUrl]) {
//                [imageView sd_setImageWithURL:[NSURL URLWithString:iceModel.pitureUrl]placeholderImage:ImageNamed(@"shop_goods_default")];
//            }
//            else
//            {
//                imageView.image = [ImageCache getCacheImage:iceModel.pitureUrl];
//            }
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageArray[idx]]placeholderImage:ImageNamed(@"shop_goods_default")];
            imageView.backgroundColor = [UIColor blackColor];
            [_scrollView addSubview:imageView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
            [imageView addGestureRecognizer:tapGesture];
        }
        else
        {
            *stop = YES;
        }
    }];
    
    NSInteger goodsCount = imageArray.count > 4?4:imageArray.count;
    CGSize newSize = CGSizeMake(goodsCount*(ImageViewWidth+5)+5, 0);
    [_scrollView setContentSize:newSize];
}

- (void)tapGesture:(UIGestureRecognizer *)gusture
{
    [DDPhotoBrowser showFromImageView:(UIImageView *)gusture.view withURLStrings:_imageArray placeholderImage:[UIImage imageNamed:@"placeholder"] atIndex:gusture.view.tag-100 dismiss:nil];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
