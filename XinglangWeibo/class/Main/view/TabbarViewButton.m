//
//  TabbarViewButton.m
//  新浪微博
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "TabbarViewButton.h"
#import "UIImage+tabbarView.h"
#import "BadgeButton.h"
@interface TabbarViewButton()
//@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic, weak) BadgeButton *badgeButton;
@end
@implementation TabbarViewButton

- (id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self.imageView setContentMode:UIViewContentModeCenter];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        if (!iOS7) {
            [self.titleLabel setTextColor:[UIColor whiteColor]];
        }else{
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected ];
        }
        // 提醒
        BadgeButton *badgeButton = [[BadgeButton alloc]init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
        
    }
    return self;
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    // kov
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:Nil];
    
    [self observeValueForKeyPath:nil ofObject:nil  change:nil context:nil];
}
// 
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    if (!iOS7) {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
    }else{
        [self.badgeButton setHidden:YES];
    }


        [self.badgeButton setBadge:self.item.badgeValue];
        
//        [self.badgeButton setTitle:self.item.badgeValue forState:UIControlStateNormal];
//        [self.badgeButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
//        CGSize titleSize = [self.item.badgeValue sizeWithFont:self.badgeButton.titleLabel.font];
//        
//        CGFloat badgeY = 0;
//        CGFloat badgeW = titleSize.width + 10;
//        // self.frame.size.width 的值为0
//        CGFloat badgeX = self.frame.size.width - badgeW;
//        CGFloat badgeH = self.badgeButton.currentBackgroundImage.size.height;
//        [self.badgeButton setFrame:CGRectMake(badgeX, badgeY, badgeW, badgeH)];
//        if (titleSize.width > 1) {
//            [self.badgeButton setBackgroundImage:[UIImage  resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
//        }
    
    // 设置提醒数字的位置
    CGFloat badgeY = 5;
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 10;

    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;

    
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 0.6;
    return CGRectMake(0, 0, imageW, imageH);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * 0.6;
    CGFloat titleW = contentRect.size.width;
    return CGRectMake(0, titleY, titleW, contentRect.size.height - titleY);
}
@end
