//
//  CommentCell.m
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/15.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell ()
/**
 *  用户头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
/**
 *  用户等级
 */
@property (weak, nonatomic) IBOutlet LevelView *userLevel;
/**
 *  评论日期
 */
@property (weak, nonatomic) IBOutlet UILabel *commentDateLbl;
/**
 *  评论内容
 */
@property (weak, nonatomic) IBOutlet UILabel *commentLbl;
/**
 *  分类
 */
@property (weak, nonatomic) IBOutlet UILabel *typeLbl;
/**
 *  评论图片
 */
@property (weak, nonatomic) IBOutlet CommentImageView *commentImgView;

/**
 *  评论图片高度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentImgViewHeightConstraint;


@end

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _commentImgView.userInteractionEnabled = YES;
    
//    _commentImgViewHeightConstraint.constant = 0;
//    _commentImgView.hidden = YES;
    
    _commentLbl.text = @"我哦奥瓦就发金卡爱上就卡机大剧盛典阿萨德就卡机读卡技术的撒娇打卡机的斯科拉就阿克江的撒娇大空间啊就打卡机SD卡设计的卡解答肯定就是";
    
    [_commentImgView setImageArray:@[@"http://g.hiphotos.baidu.com/image/pic/item/b58f8c5494eef01f845ef9d3e3fe9925bc317d5a.jpg",@"http://img.article.pchome.net/00/43/41/54/pic_lib/wm/3.jpg"]];
    
    _userLevel.score = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
