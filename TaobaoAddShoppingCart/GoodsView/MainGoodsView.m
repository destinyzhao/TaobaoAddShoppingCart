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
    self.adViewHeightConstraint.constant = SCREEN_WIDTH;
    self.contentViewHeightConstraint.constant = 580;
    
    NSArray *tagArr = @[@"保证正品",@"7天无理由退货",@"质保1年",@"包邮（除港澳台新疆西藏与国外）"];
    [self.serviceTagView setTagSource:tagArr font:[UIFont systemFontOfSize:14] normalColor:[UIColor blackColor] selectedColor:[UIColor blackColor] backgroundColor:[UIColor yellowColor] borderColor:nil enabled:NO];
    self.serviceTagViewHeightConstraint.constant = self.serviceTagView.height;
    
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
