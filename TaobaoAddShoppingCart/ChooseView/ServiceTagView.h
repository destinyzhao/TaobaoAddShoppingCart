//
//  ServiceTagView.h
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/12.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceTagView : UIView

- (void)setTagSource:(NSArray *)arr  font:(UIFont *)font normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor enabled:(BOOL)enabled;

@end
