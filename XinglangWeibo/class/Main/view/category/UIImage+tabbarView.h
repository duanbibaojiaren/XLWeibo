//
//  UIImage+tabbarView.h
//  新浪微博
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (tabbarView)

+ (UIImage *)imageWithImageName:(NSString *)imageName;


+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;


+ (UIImage *)resizedImageWithName:(NSString *)name;


@end
