//
//  AdPlayCell.h
//  AdPlayView
//
//  Created by Alex on 16/3/17.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdPlayModel.h"
//#import <AppSystemManageService.h>

@interface AdPlayCell : UICollectionViewCell
/**
 *  图片
 */
@property (strong, nonatomic) UIImageView *adImageView;
/**
 *  标题
 */
@property (strong, nonatomic) UILabel *titleLabe;
/**
 *  广告对象
 */
//@property (strong, nonatomic) appsystemmanagePutAdvertiseIceModule *adPlayModel;
@property (copy,nonatomic) NSString *imageUrl;

@end
