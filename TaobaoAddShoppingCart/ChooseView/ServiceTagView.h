//
//  ServiceTagView.h
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/12.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedTagBlock)(NSInteger tagIndex);

@interface ServiceTagView : UIView

@property (copy, nonatomic) SelectedTagBlock selectedTagBlock;

- (void)setTagSource:(NSArray *)arr  font:(UIFont *)font titleNormalColor:(UIColor *)titleNormalColor titleSelectedColor:(UIColor *)titleSelectedColor normalBackgroundColor:(UIColor *)normalBackgroundColor selectedBackgroundColor:(UIColor *)selectedBackgroundColor  borderColor:(UIColor *)borderColor enabled:(BOOL)enabled;

@end
