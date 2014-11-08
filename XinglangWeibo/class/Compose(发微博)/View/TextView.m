//
//  TextView.m
//  XinglangWeibo
//
//  Created by admin on 14-11-6.
//  Copyright (c) 2014年 xl. All rights reserved.
//

#import "TextView.h"

@interface TextView () <UIScrollViewDelegate>
@property (nonatomic, weak) UILabel *label;

@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation TextView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lable = [[UILabel alloc]init];
        [lable setText:self.labelString];
        [self addSubview:lable];
        // 为了获取滚动
        self.label = lable;
        // 监听textview文字的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
        IWComposePhotosView *photosView = [[IWComposePhotosView alloc]init];
        [photosView setBackgroundColor:[UIColor redColor]];
        [photosView setFrame:CGRectMake(0, 80, 320, self.frame.size.height - 180)];
//        [imageView setBackgroundColor:[UIColor redColor]];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

- (void)textDidChange
{
    self.label.hidden = self.text.length;
}

- (void)setLabelString:(NSString *)labelString
{
    _labelString = [labelString copy];
    [self.label setText:_labelString];
    self.label.font = self.font;
    
    CGFloat labelX = 10;
    CGFloat labelY = 10;
    CGFloat maxW = self.frame.size.width - 2 * labelX;
    CGFloat maxH = self.frame.size.height - 2 * labelY;
//    Log(@"maxh %f", maxH);
    CGSize labelWH = [self.labelString sizeWithFont:self.label.font constrainedToSize:CGSizeMake(maxW, maxH)];
    [self.label setFrame:CGRectMake(labelX, labelY, labelWH.width, labelWH.height)];
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    [self.label setTextColor:color];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self.imageView setImage:_image];
    [self.photosView addImage:_image];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
