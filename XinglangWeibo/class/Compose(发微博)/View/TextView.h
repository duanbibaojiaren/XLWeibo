//
//  TextView.h
//  XinglangWeibo
//
//  Created by admin on 14-11-6.
//  Copyright (c) 2014年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextView : UITextView
@property (nonatomic, copy) NSString *labelString;
@property (nonatomic, strong) UIColor *color;

@property (nonatomic, weak) UIImage *image;
@end
