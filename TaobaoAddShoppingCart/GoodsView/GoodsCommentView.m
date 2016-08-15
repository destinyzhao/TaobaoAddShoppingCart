//
//  GoodsCommentView.m
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/11.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "GoodsCommentView.h"
#import "CommentCell.h"

@interface GoodsCommentView ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet ServiceTagView *commentTagView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GoodsCommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)sharedView
{
    GoodsCommentView *view = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCommentView" owner:self options:nil] firstObject];
    return view;
}

- (void)awakeFromNib
{
    [self initTableView];
    
    [self initTagView];
}

- (void)initTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 123;
}

- (void)initTagView
{
    NSArray *tagArr = @[@"全部99999",@"好评88888",@"中评11011",@"差评100",@"有图88",@"口感不错110",@"还可以100",@"包装差10"];
    [self.commentTagView setTagSource:tagArr font:[UIFont systemFontOfSize:14] titleNormalColor:[UIColor blackColor] titleSelectedColor:[UIColor whiteColor] normalBackgroundColor:[UIColor yellowColor] selectedBackgroundColor:[UIColor redColor] borderColor:nil enabled:YES ];
    self.tagViewHeightConstraint.constant = self.commentTagView.height;
    
    self.commentTagView.selectedTagBlock = ^(NSInteger tagIndex){
        NSLog(@"选择了%zd",tagIndex);
    };

}


- (void)request
{
    NSLog(@"网络请求3");
}

#pragma mark -
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indetifier = @"CommentCell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:indetifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
