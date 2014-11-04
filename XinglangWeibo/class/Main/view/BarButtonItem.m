//
//  BarButtonItem.m
//  xinlangweibo
//
//  Created by admin on 14-10-27.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "BarButtonItem.h"

@implementation BarButtonItem
+ (UIBarButtonItem *)initWithicon:(NSString *)icon heighlightedIcon:(NSString *)heighlightedIcon target:(id)target action:(SEL)action
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:[UIImage imageWithImageName:icon] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageWithImageName:heighlightedIcon] forState:UIControlStateHighlighted];
    [leftButton setBounds:CGRectMake(0, 0, leftButton.currentBackgroundImage.size.width, leftButton.currentBackgroundImage.size.height)];
    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    return item;
}


@end
