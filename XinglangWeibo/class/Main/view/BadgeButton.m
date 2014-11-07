//
//  BadgeButton.m
//  xinlangweibo
//
//  Created by admin on 14-10-25.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "BadgeButton.h"

@implementation BadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageWithImageName:@"main_badge"] forState:UIControlStateNormal];
        [self setHidden:YES];
        self.userInteractionEnabled = NO;
    }
    return self;
}
- (void)setBadge:(NSString *)badgeValue
{
    
    // 设置提醒数字
    if (badgeValue) {
        [self setHidden:NO];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:11]];
        CGSize titleSize = [badgeValue sizeWithFont:self.titleLabel.font];
        
        CGFloat badgeY = 0;
        CGFloat badgeW = titleSize.width + 10;
        // self.frame.size.width 的值为0
        CGFloat badgeX = self.frame.size.width - badgeW;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        [self setFrame:CGRectMake(badgeX, badgeY, badgeW, badgeH)];
        if (titleSize.width > 1) {
            [self setBackgroundImage:[UIImage  resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
