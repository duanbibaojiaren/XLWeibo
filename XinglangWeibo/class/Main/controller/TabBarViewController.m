//
//  TabBarViewController.m
//  新浪微博
//
//  Created by admin on 14-10-21.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "MeViewController.h"
#import "UIImage+tabbarView.h"
#import "tabbarView.h"
#import "NavigationViewController.h"
@interface TabBarViewController ()
@property (nonatomic, weak) tabbarView *tabView;
@end

@implementation TabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [self setTabbarView];
    [self setupChildController];
    

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSLog(@"self.tabBar.subviews   %@",self.tabBar.subviews);
    
    for (UIView *button in self.tabBar.subviews) {
//        NSLog(@"button====== %@",button.superclass);
        if ([button isKindOfClass:[UIControl class]]) {
            [button removeFromSuperview];
        }
    }
}
// 代理方法，解决界面直接的跳转，
- (void)tabbarView:(tabbarView *)tabbarView form:(int)form to:(int)to
{
    self.selectedIndex = to;
}
- (void)setTabbarView
{
    tabbarView *tabbar = [[tabbarView alloc]init];
    tabbar.frame = self.tabBar.bounds;
    tabbar.tabbarViewDelegate = self;
    [self.tabBar addSubview:tabbar];
    self.tabView =tabbar;

}

- (void)setupChildController
{
    HomeViewController *homeController = [[HomeViewController alloc]init];
     homeController.tabBarItem.badgeValue = @"1";
    [self setupChildViewController:homeController title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
   

    MessageViewController *messageController = [[MessageViewController alloc]init];
     messageController.tabBarItem.badgeValue = @"12";
    [self setupChildViewController:messageController title:@"信息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
   

    DiscoverViewController *discoverController = [[DiscoverViewController alloc]init];
    [self setupChildViewController:discoverController title:@"附近" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    MeViewController *meController = [[MeViewController alloc]init];
    [self setupChildViewController:meController title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}

- (void)setupChildViewController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    controller.title = title;
    controller.tabBarItem.image = [UIImage imageWithImageName:imageName];
//    NSLog(@"controller.tabBarItem  %@",controller.tabBarItem);
    if (iOS7) {
        NSString *name = [selectedImageName stringByAppendingString:@"_os7"];
         [controller.tabBarItem setSelectedImage:[[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }else{
        
        [controller.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImageName]];
    }
    // 用这个方法就无法渲染了，默认颜色是蓝色（点击）
//    [controller.tabBarItem setSelectedImage:[UIImage imageWithImageName:selectedImageName]];
    NavigationViewController *navController = [[NavigationViewController alloc]initWithRootViewController:controller];
//    NSLog(@"navController==%d",navController.viewControllers.count);
    [self addChildViewController:navController];
    
        // 3.添加tabbar内部的按钮
    [self.tabView addButtuonWithTabBarItem:controller.tabBarItem];
}


@end
