//
//  tabbarView.m
//  新浪微博
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "tabbarView.h"
#import "TabbarViewButton.h"
@interface tabbarView()
@property (nonatomic, weak) UIButton *selectButton;
@property (nonatomic, weak) UIButton *addButton;
// 用来记录除add的按钮
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end
@implementation tabbarView
- (NSMutableArray *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = [[NSMutableArray alloc]init];
    }
    return _buttonArray;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (!iOS7) {
           [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]]];
        }
         UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addButton setBackgroundImage:[UIImage imageWithImageName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [addButton setBackgroundImage:[UIImage imageWithImageName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [addButton setImage:[UIImage imageWithImageName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateNormal];
        [addButton setImage:[UIImage imageWithImageName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [addButton addTarget:self action:@selector(clickAddBut:) forControlEvents:UIControlEventTouchUpInside];
        self.addButton = addButton;
    }
       return self;
}
// 点击Addbut
- (void)clickAddBut:(UIButton *)but
{
    if ([self.tabbarViewDelegate respondsToSelector:@selector(tabbarViewClickAddBut:)]) {
        [self.tabbarViewDelegate tabbarViewClickAddBut:self];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    [self.addButton setBounds:CGRectMake(0, 0, self.addButton.currentBackgroundImage.size.width, self.addButton.currentBackgroundImage.size.height)];
    [self addSubview:self.addButton];
    self.addButton = self.addButton;
    
    
    [self.addButton setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)];
    NSInteger y = 0;
    NSInteger width = self.bounds.size.width / self.subviews.count;
    NSInteger height = self.bounds.size.height;
    for (int i = 0; i < self.buttonArray.count; i++) {
        TabbarViewButton *button = self.buttonArray[i];
        if (i > 1) {
            [button setFrame:CGRectMake(width * (i + 1), y, width, height)];
            button.tag = i;
        }else{
            [button setFrame:CGRectMake(width * i, y, width, height)];
            button.tag = i;
        }
    }
}
- (void)addButtuonWithTabBarItem:(UITabBarItem *)tabbarItem
{
    TabbarViewButton *button = [[TabbarViewButton alloc]init];
    [self addSubview:button];
    button.item = tabbarItem;
    [self.buttonArray addObject:button];
//    [button setTitle:tabbarItem.title forState:UIControlStateNormal];
//    [button setImage:tabbarItem.image forState:UIControlStateNormal];
//    [button setImage:tabbarItem.selectedImage forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }
}
- (void)buttonClick:(UIButton *)button
{
//    if ([self.tabbarViewDelegate respondsToSelector:@selector(tabbarView:form:to:)]) {

        [self.tabbarViewDelegate tabbarView:self form:self.selectButton.tag to:button.tag];
//    }
    // 可以将选中的图片显示出颜色
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
}
@end
