//
//  MainGoodsView.m
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/11.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "MainGoodsView.h"
#import "ServiceTagView.h"

@interface MainGoodsView ()<UIScrollViewDelegate>
/**
 *  广告
 */
@property (weak, nonatomic) IBOutlet AdPlayView *AdvertisementView;

/**
 *  scrollView
 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/**
 *  广告高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adViewHeightConstraint;
/**
 *  ContentView 高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
/**
 *  服务标签
 */
@property (weak, nonatomic) IBOutlet ServiceTagView *serviceTagView;
/**
 *  服务标签高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *serviceTagViewHeightConstraint;

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
    self.scrollView.delegate = self;
    
//    self.adViewHeightConstraint.constant = SCREEN_WIDTH;
    
    NSArray *tagArr = @[@"保证正品",@"7天无理由退货",@"质保1年",@"包邮（除港澳台新疆西藏与国外）"];
    [self.serviceTagView setTagSource:tagArr font:[UIFont systemFontOfSize:14] titleNormalColor:[UIColor blackColor] titleSelectedColor:[UIColor blackColor] normalBackgroundColor:[UIColor yellowColor] selectedBackgroundColor:[UIColor yellowColor] borderColor:nil enabled:NO];
    self.serviceTagViewHeightConstraint.constant = self.serviceTagView.height;
    
    [self setupAdvertisement];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.contentViewHeightConstraint.constant = 580;
}

+ (instancetype)sharedView
{
    MainGoodsView *view = [[[NSBundle mainBundle] loadNibNamed:@"MainGoodsView" owner:self options:nil] firstObject];
    return view;
}

/**
 *  初始化广告
 */
- (void)setupAdvertisement
{
    _AdvertisementView.placeholderImage = @"home_adv";
    [_AdvertisementView tapActionBlock:^(NSInteger selectIndex) {
        NSLog(@"选择了---%ld",(long)selectIndex);
    }];
    
    _AdvertisementView.imgsArray = @[@"http://www.bz55.com/uploads/allimg/120629/1-120629104603.jpg",
                                     @"http://g.hiphotos.baidu.com/image/pic/item/b58f8c5494eef01f845ef9d3e3fe9925bc317d5a.jpg"];
}


- (void)request
{
    NSLog(@"网络请求1");
}

#pragma mark -
#pragma mark - UIScrollView Delegate

-(void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentYoffset = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    if (distanceFromBottom < height) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.scollBottomBlock) {
                self.scollBottomBlock();
            }
        });
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


@end
