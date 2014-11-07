//
//  TextToolView.m
//  XinglangWeibo
//
//  Created by admin on 14-11-7.
//  Copyright (c) 2014年 xl. All rights reserved.
//

#import "TextToolView.h"

@implementation TextToolView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithImageName:@"compose_toolbar_background"]];
        // 添加按钮
        [self addButtonImage:@"compose_camerabutton_background" hightIcon:@"compose_camerabutton_background_highlighted" tag:IWComposeToolbarButtonTypeCamera];
        
        [self addButtonImage:@"compose_toolbar_picture" hightIcon:@"compose_toolbar_picture_highlighted" tag:IWComposeToolbarButtonTypePicture];
        
        [self addButtonImage:@"compose_mentionbutton_background" hightIcon:@"compose_mentionbutton_background_highlighted" tag:IWComposeToolbarButtonTypeMention];
        
        [self addButtonImage:@"compose_trendbutton_background" hightIcon:@"compose_trendbutton_background_highlighted" tag:IWComposeToolbarButtonTypeTrend];
        
        [self addButtonImage:@"compose_emoticonbutton_background" hightIcon:@"compose_emoticonbutton_background_highlighted" tag:IWComposeToolbarButtonTypeEmotion];

    }
    return self;
}

- (void)addButtonImage:(NSString *)icon hightIcon:(NSString *)hightIcon tag:(IWComposeToolbarButtonType)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageWithImageName:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithImageName:hightIcon] forState:UIControlStateHighlighted];
    button.tag = tag;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
}
- (void)clickButton:(UIButton *)but
{
    if ([self.textToolViewDelegate respondsToSelector:@selector(textToolView:didClickButtonTag:)]) {
        [self.textToolViewDelegate textToolView:self didClickButtonTag:but.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    for (int i = 0; i<self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        CGFloat buttonX = buttonW * i;
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
    }
}

@end
