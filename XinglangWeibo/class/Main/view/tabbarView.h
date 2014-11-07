//
//  tabbarView.h
//  新浪微博
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol tabbarViewDelegate;
@interface tabbarView : UIView 
@property (weak, nonatomic) id<tabbarViewDelegate> tabbarViewDelegate;

- (void)addButtuonWithTabBarItem:(UITabBarItem *)tabbarItem;
@end
@protocol tabbarViewDelegate <NSObject>
- (void)tabbarView:(tabbarView *)tabbarView form:(int) form to:(int) to;
- (void)tabbarViewClickAddBut:(tabbarView *)tabbarView;
@end