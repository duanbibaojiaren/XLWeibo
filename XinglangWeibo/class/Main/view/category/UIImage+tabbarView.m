//
//  UIImage+tabbarView.m
//  新浪微博
//
//  Created by admin on 14-10-22.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "UIImage+tabbarView.h"

@implementation UIImage (tabbarView)
+ (UIImage *)imageWithImageName:(NSString *)imageName
{
    NSString *name;
    if (iOS7) {
       name = [imageName stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:name];
        if (image == nil) {
            name = imageName;
        }
    }else{
        name = imageName;
    }
//    NSLog(@"name==%@",name);
//    NSLog(@"[UIImage imageNamed:name]  %@",[UIImage imageNamed:name]);
    return [UIImage imageNamed:name];
}
// 自定义拉伸图片
+ (UIImage *)resizedImageWithName:(NSString *)name
{

    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
{
     UIImage *image = [self imageWithImageName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}
@end
