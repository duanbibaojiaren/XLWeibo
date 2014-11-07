//
//  TitleButton.m
//  xinlangweibo
//
//  Created by admin on 14-10-27.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "TitleButton.h"


@implementation TitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.adjustsImageWhenHighlighted = NO;
        // 图标
        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        // 文字
//        [self setTitle:@"haha" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        
    }
    return self;
}
- (void)setName:(NSString *)name
{
   
    _name = name;
    [self setTitle:_name forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    CGFloat imageY = 5;
    CGFloat imageW = 20;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageH = contentRect.size.height - 10;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.width - 20;
    CGFloat imageX = 0;
    CGFloat imageH = contentRect.size.height;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
