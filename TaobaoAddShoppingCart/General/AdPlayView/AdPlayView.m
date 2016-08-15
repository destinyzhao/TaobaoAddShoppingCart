//
//  AdPlayView.m
//  AdPlayView
//
//  Created by Alex on 16/3/17.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "AdPlayView.h"
#import "AdPlayModel.h"
#import "AdPlayCell.h"

static int const ADSection = 100;

@interface AdPlayView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)NSArray * dataArray;
/**
 *  UICollectionView
 */
@property (nonatomic,strong)UICollectionView * adCollectionView;
/**
 *  UICollectionView的布局
 */
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
/**
 *  UIPageControl
 */
@property (nonatomic,strong) UIPageControl * pageControl;
/**
 *  NSTimer对象
 */
@property (nonatomic,strong)NSTimer * timer;

@end

@implementation AdPlayView

static NSString *const identifier = @"AdPlayCell";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

/**
 *  setter Imgs Array
 *
 *  @param imgsArray
 */
-(void)setImgsArray:(NSArray *)imgsArray
{
    if (imgsArray.count == 0) return;
    _imgsArray = imgsArray;
    [self initialization];

    self.dataArray = imgsArray;
    
    if (_imgsArray.count > 1) {
        [self addTimer];
    }
    
    [_adCollectionView reloadData];
}

/**
 *  初始化
 */
- (void)initialization
{
    // 布局
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    // CollectionView
    _adCollectionView = [[UICollectionView  alloc]initWithFrame:self.frame collectionViewLayout:_flowLayout];
    _adCollectionView.backgroundColor = [UIColor whiteColor];
    _adCollectionView.delegate = self;
    _adCollectionView.dataSource = self;
    _adCollectionView.pagingEnabled = YES;
    _adCollectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_adCollectionView];
    
    // 注册Cell
    [_adCollectionView registerClass:[AdPlayCell class] forCellWithReuseIdentifier:identifier];
    
    // PageControl
    _pageControl = [[UIPageControl alloc]init];
    [self addSubview:_pageControl];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
   
    if (_imgsArray.count == 0) {
        return;
    }
    
    _adCollectionView.frame = self.bounds;
    
    //设置布局
    self.flowLayout.itemSize = self.bounds.size;
    
    [_adCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:ADSection / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    //
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor getColorWithHexString:@"00984C"];
    self.pageControl.numberOfPages = self.dataArray.count;
    
    CGSize page1Size = [self.pageControl sizeForNumberOfPages:1];
    CGFloat pageW = self.dataArray.count * page1Size.width;
    CGFloat pageH = 20;
    CGFloat viewH = self.frame.size.height;
    CGFloat viewW = self.frame.size.width;
    self.pageControl.frame = CGRectMake((viewW-pageW)/2.0, viewH - pageH - 6, pageW, pageH);
}

#pragma mark -
#pragma mark - UICollectionView Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return ADSection;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AdPlayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.adImageView.backgroundColor = [UIColor whiteColor];
    cell.imageUrl = self.dataArray[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _adSelectIndexBlock(indexPath.row);
}

#pragma mark -
#pragma mark - UIScrollview Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.dataArray.count) return; // 解决清除timer时偶尔会出现的问题
    NSInteger pageNum = (NSInteger)((scrollView.contentOffset.x / self.frame.size.width) + 0.5) % self.dataArray.count;
    self.pageControl.currentPage = pageNum;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止计时
    [self destroyTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 启动计时器
    [self addTimer];
}

#pragma mark - 增加定时器
-(void)addTimer
{
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(goToNext) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}
#pragma mark - 销毁定时器
-(void)destroyTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.adCollectionView indexPathsForVisibleItems] lastObject];
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:ADSection/2];
    [self.adCollectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}

-(void)goToNext
{
    if (!self.timer)  return; //计时器清空了，这个方法还是会调用？？
    NSIndexPath *currentIndexPath = [self resetIndexPath];
    
    NSInteger nextItem = currentIndexPath.item + 1;
    NSInteger nextSection = currentIndexPath.section;
    if (nextItem == self.dataArray.count) {
        nextItem = 0;
        nextSection++;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.adCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)tapActionBlock:(AdSelectIndexBlock)block
{
    _adSelectIndexBlock = block;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
