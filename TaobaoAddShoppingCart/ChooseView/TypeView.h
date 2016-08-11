//
//  TypeView.h
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/10.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypeSeleteDelegete <NSObject>

-(void)btnindex:(NSInteger)btnTag viewTag:(NSInteger)viewTag select:(BOOL)select;

@end

@interface TypeView : UIView

@property (nonatomic,retain) id<TypeSeleteDelegete> delegate;

- (void)setTypeSource:(NSArray *)arr typeName:(NSString *)typeName btnName:(NSString *)btnName;

-(void)resumeBtn;

-(void)reloadTypeBtn:(NSMutableArray *)btnArray;

@end
