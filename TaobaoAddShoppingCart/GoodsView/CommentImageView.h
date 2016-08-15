//
//  GoodsImageView.h
//  sis-supermarket
//
//  Created by Alex on 16/6/3.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapImgBlock)(NSInteger index);

@interface CommentImageView : UIView

@property (strong, nonatomic) NSArray *imageArray;
@property (copy, nonatomic) TapImgBlock tapImgBlock;

@end
