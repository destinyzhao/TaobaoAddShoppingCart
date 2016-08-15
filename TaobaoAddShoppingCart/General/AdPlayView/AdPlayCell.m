//
//  AdPlayCell.m
//  AdPlayView
//
//  Created by Alex on 16/3/17.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "AdPlayCell.h"

@implementation AdPlayCell

-(instancetype)init
{
    if (self = [super init]) {
        [self setUpSubViews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpSubViews];
    }
    return self;
}

/**
 *  初始化
 */
- (void)setUpSubViews
{
    _adImageView = [[UIImageView alloc]init];
    _adImageView.contentMode = UIViewContentModeScaleAspectFill;
    _adImageView.clipsToBounds = YES;
    _adImageView.backgroundColor = [UIColor redColor];
    _adImageView.image = ImageNamed(@"home_adv");
    [self addSubview:_adImageView];
    
    _titleLabe = [[UILabel alloc]init];
    [self addSubview:_titleLabe];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _adImageView.frame = self.bounds;
}

/**
 *  设置对象更新UI
 *
 *  @param adPlayModel 广告对象
 */
//- (void)setAdPlayModel:(appsystemmanagePutAdvertiseIceModule *)adPlayModel
- (void)setImageUrl:(NSString *)imageUrl
{
    [self.adImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"home_adv"]];
//    _adPlayModel = adPlayModel;
//    if (![ImageCache isImageCache:_adPlayModel.picUrl]) {
//        [self.adImageView sd_setImageWithURL:[NSURL URLWithString:_adPlayModel.picUrl] placeholderImage:[UIImage imageNamed:@"home_adv"]];
//    }
//    else
//    {
//        self.adImageView.image = [ImageCache getCacheImage:_adPlayModel.picUrl];
//    }
   
}

@end
