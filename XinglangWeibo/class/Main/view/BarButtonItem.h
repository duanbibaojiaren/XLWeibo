//
//  BarButtonItem.h
//  xinlangweibo
//
//  Created by admin on 14-10-27.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarButtonItem : UIBarButtonItem
+ (UIBarButtonItem *)initWithicon:(NSString *)icon heighlightedIcon:(NSString *)heighlightedIcon target:(id)target action:(SEL)action;
@end
