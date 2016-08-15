//
//  LevelView.m
//  sis-supermarket
//
//  Created by Alex on 16/6/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "LevelView.h"

@implementation LevelView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSettings];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSettings];
    }
    return self;
}

- (void)initSettings
{
    self.backgroundColor = [UIColor clearColor];
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setScore:(CGFloat)score
{
    _score = score;
   
    if (score == 1) {
        self.image = ImageNamed(@"one star");
    }
    else if (score == 2)
    {
        self.image = ImageNamed(@"dobble star");
    }
    else if (score == 3)
    {
        self.image = ImageNamed(@"three star");
    }
    else if (score == 4)
    {
        self.image = ImageNamed(@"four star");
    }
    else if (score == 5)
    {
        self.image = ImageNamed(@"five star");
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
