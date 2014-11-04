//
//  CellToolBar.m
//  xinlangweibo
//
//  Created by admin on 14-11-2.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "StatusToolbar.h"
#import "Status.h"
@interface StatusToolbar ()

@property (nonatomic, weak) UIButton *button;
@property (nonatomic, weak) UIButton *leftButton;
@property (nonatomic, weak) UIButton *middleButton;
@property (nonatomic, weak) UIButton *rightButton;
// 分界线
@property (nonatomic, weak) UIButton *button1;
@property (nonatomic, weak) UIButton *button2;
@end
@implementation StatusToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
        
        // 2.添加按钮
        self.leftButton = [self setupButtonWithTitle:@"转载" image:@"timeline_icon_retweet" hight:@"timeline_card_leftbottom_highlighted"];
        [self addSubview:self.leftButton];
        
        self.middleButton = [self setupButtonWithTitle:@"评论" image:@"timeline_icon_comment" hight:@"timeline_card_middlebottom_highlighted"];
        [self addSubview:self.middleButton];
        
        self.rightButton = [self setupButtonWithTitle:@"赞" image:@"timeline_icon_unlike" hight:@"timeline_card_rightbottom_highlighted"];
        [self addSubview:self.rightButton];
        
        self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button1 setBackgroundImage:[UIImage imageWithImageName:@"timeline_card_bottom_line"] forState:UIControlStateNormal];
        [self addSubview:self.button1];
        
        
        self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button2 setBackgroundImage:[UIImage imageWithImageName:@"timeline_card_bottom_line"] forState:UIControlStateNormal];
        [self addSubview:self.button2];
    }
    return self;
}
- (UIButton *)setupButtonWithTitle:(NSString *)title image:(NSString *)image hight:(NSString *)hightImage
{
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [button setImage:[UIImage imageWithImageName:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizedImageWithName:hightImage] forState:UIControlStateHighlighted];
    return button;
}

- (void)layoutSubviews
{
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / 3;
    CGFloat buttonH = self.frame.size.height;
    [_leftButton setFrame:CGRectMake(0, 0, buttonW, buttonH)];
    [_button1 setFrame:CGRectMake(buttonX + buttonW, buttonY, 2, buttonH)];
    [_middleButton setFrame:CGRectMake(buttonX + buttonW, buttonY, buttonW, buttonH)];
    [_button2 setFrame:CGRectMake(buttonX + 2 * buttonW, buttonY, 2, buttonH)];
    [_rightButton setFrame:CGRectMake(buttonX + 2 * buttonW, buttonY, buttonW, buttonH)];
}

- (void)setStatuses:(Status *)statuses
{
    _statuses = statuses;
    
    [self setupButton:self.leftButton original:@"转载" count:statuses.reposts_count];
    [self setupButton:self.middleButton original:@"评论" count:statuses.comments_count];
    [self setupButton:self.leftButton original:@"赞" count:statuses.attitudes_count];
}

- (void)setupButton:(UIButton *)button original:(NSString *)original count:(int) count
{
    if (count)
    {
        if (count < 10000) {
            [button setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
        }else{
            int message = count / 10000;
            [button setTitle:[NSString stringWithFormat:@"%d万",message] forState:UIControlStateNormal];
        }
    }else{
        [button setTitle:original forState:UIControlStateNormal];
    }
}
@end
