//
//  ViewController.m
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/10.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ViewController.h"
#import "ChooseView.h"
#import "DDSegmentView.h"
#import "MainGoodsView.h"
#import "GoodsDetailView.h"
#import "GoodsCommentView.h"

@interface ViewController ()<UIScrollViewDelegate>
/**
 *  数组
 */
@property (strong, nonatomic) NSMutableArray *typeArr;
@property (strong, nonatomic) NSMutableDictionary *selectDic;
@property (weak, nonatomic) IBOutlet DDSegmentView *segmentView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (strong, nonatomic) NSArray *viewArray;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpScrollView];
    [self initSegmentView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self scrollViewDidEndScrollingAnimation:self.mainScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpScrollView
{
    _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, 0);
    
    MainGoodsView *mainView = [MainGoodsView sharedView];
    mainView.frame = CGRectMake(0, 0, self.mainScrollView.width, self.mainScrollView.height);
    [self.mainScrollView addSubview:mainView];
    
    GoodsDetailView *detailView = [GoodsDetailView sharedView];
    detailView.frame = CGRectMake(SCREEN_WIDTH, 0, self.mainScrollView.width, self.mainScrollView.height);
    [self.mainScrollView addSubview:detailView];
    
    GoodsCommentView *commentView = [GoodsCommentView sharedView];
    commentView.frame = CGRectMake(SCREEN_WIDTH*2, 0, self.mainScrollView.width, self.mainScrollView.height);
    [self.mainScrollView addSubview:commentView];
    
    self.viewArray = @[mainView,detailView,commentView];

}

/**
 *  初始化SegmentView
 */
- (void)initSegmentView
{
    NSArray *titleArr = @[@"商品",@"详情",@"评价"];
    [_segmentView createSegmentWithTitleArray:titleArr segmentWidth:160 font:[UIFont boldSystemFontOfSize:16] normalColor:[UIColor whiteColor] selectedColor:[UIColor whiteColor]];
    [_segmentView setLineColor:[UIColor whiteColor]];
    [_segmentView setBackgroundColor:[UIColor clearColor]];
    [_segmentView segmentBlock:^(NSInteger index) {
        NSLog(@"segmentIndex:%zd",index);
         [self scrollViewScrollWithPage:index];
    }];
    
}

- (void)loadData
{
    NSArray *sizearr = @[@"S",@"MMMMMMMMMMMMMMMMMMMMNNNNNNNNNNNNN",@"LLLLLLLLLLLLLL",@"XML",@"XLL"];
    NSArray *colorarr = @[@"蓝色蓝色蓝色蓝色蓝色蓝",@"红色红色红色红色红色红色红色",@"湖蓝色",@"咖啡色咖啡色咖啡色咖啡色咖啡色咖啡"];
    NSArray *colorarr1 = @[@"哈哈",@"红色红",@"湖蓝色",@"咖啡色"];
    NSArray *colorarr2 = @[@"哈",@"红色",@"蓝色"];
    _typeArr = [NSMutableArray arrayWithObjects:sizearr,colorarr,colorarr1,colorarr2,nil];
    _selectDic = [NSMutableDictionary dictionary];
}


- (IBAction)addShoppingCartBtnClicked:(id)sender {
    
    __block NSString *selectStr = nil;
    
    [[ChooseView sharedInstance] show:_typeArr selectDic:_selectDic block:^(NSInteger btnTag, NSInteger viewTag, BOOL select , NSMutableDictionary *selectDic) {
        NSLog(@"%zd,%zd",btnTag,viewTag);
        _selectDic = selectDic;
        
        NSArray *keysArray = [[selectDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
        for (NSInteger i = 0; i < keysArray.count; i++) {
            NSString *keys = keysArray[i];
            if (i == 0) {
                selectStr = [selectDic objectForKey:keys];
            }
            else{
                selectStr = [selectStr stringByAppendingString:[NSString stringWithFormat:@",%@",[selectDic objectForKey:keys]]];
            }
            
            NSLog(@"%@",selectStr);
        }
    }];
}

#pragma mark -
#pragma mark -  UIScrollView Deleagte

- (void)scrollViewScrollWithPage:(NSInteger)page
{
    CGFloat x = self.mainScrollView.frame.size.width * page;
    [self.mainScrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //滚动视图的宽
    CGFloat width = scrollView.frame.size.width;
    //当前显示第几个视图
    NSInteger number = scrollView.contentOffset.x / width;
    
    [_segmentView setCurrentSelectedIndex:number];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.mainScrollView) {
        NSInteger index = scrollView.contentOffset.x/self.mainScrollView.frame.size.width;
        if (index == 0) {
            if (self.viewArray.count && index < self.viewArray.count) {
                MainGoodsView *view = self.viewArray[index];
                [view request];
            }
           
        }
        else if (index == 1)
        {
            if (self.viewArray.count && index < self.viewArray.count) {
                GoodsDetailView *view = self.viewArray[index];
                 [view request];
            }
        }
        else if (index == 2)
        {
            if (self.viewArray.count && index < self.viewArray.count) {
                GoodsCommentView *view = self.viewArray[index];
                 [view request];
            }
        }
    }
}

@end
