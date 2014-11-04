//
//  NavigationViewController.m
//  xinlangweibo
//
//  Created by admin on 14-10-26.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

// 设置导航栏主题
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!iOS7) {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    }
//  设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    textAttrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:16];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [self.navigationBar setTitleTextAttributes:textAttrs];
    
    // 设置button
       UIBarButtonItem *item = [UIBarButtonItem appearance];
    if (!iOS7) {
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    }
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[UITextAttributeTextColor] = iOS7 ? [UIColor orangeColor] : [UIColor blackColor];
    textAttr[UITextAttributeFont] = [UIFont systemFontOfSize:11];
    textAttr[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [item setTitleTextAttributes:textAttr forState:UIControlStateNormal];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
