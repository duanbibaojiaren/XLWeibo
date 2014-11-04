//
//  PhotosView.m
//  xinlangweibo
//
//  Created by admin on 14-11-3.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "PhotosView.h"
#import "Status.h"
#import "User.h"
#import "Photo.h"
#import "UIImageView+WebCache.h"
#import "StatusFrame.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "XPhotoView.h"

#define IWPhotoW 70
#define IWPhotoH 70
#define IWPhotoMargin 10

@implementation PhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化9个子控件
        for (int i = 0; i < 9; i++) {
            
            self.userInteractionEnabled = YES;
            XPhotoView *imageView =[[XPhotoView alloc]init];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoTap:)];
            // 点按次数，例如双击2
            // 注意：在iOS中最好少用双击，如果一定要用，就一定要有一个图形化的界面告知用户可以双击
            [tap setNumberOfTapsRequired:1];
            // 用几根手指点按
            [tap setNumberOfTouchesRequired:1];
            [imageView addGestureRecognizer:tap];
            [self addSubview:imageView];
        }
    }
    return self;
}

- (void)photoTap:(UITapGestureRecognizer *)recognizer
{
    
    int count = self.status.pic_urls.count;
    // 1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        NSArray *photos = self.status.pic_urls;
        Photo *iwphoto = photos[i];
        NSString *photoUrl = [iwphoto.thumbnail_pic
                              stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
        // 来源于哪个UIImageView
        mjphoto.srcImageView = self.subviews[i];
        [myphotos addObject:mjphoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];
    
}

- (void)setStatus:(Status *)status
{
    _status = status;
    //    Photo *photo = self.status.pic_urls[0];
    //    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithImageName:@"timeline_image_placeholder"]];
    
    NSArray *photos = self.status.pic_urls;
    
    for (int i = 0; i<self.subviews.count; i++) {
        // 取出i位置对应的imageView
        XPhotoView *photoView = self.subviews[i];
        
        // 判断这个imageView是否需要显示数据
        if (i < photos.count) {
            // 显示图片
            photoView.hidden = NO;
            
            // 传递模型数据
            
            Photo *photo1 = photos[i];
            [photoView setPhoto:photo1];
            // 设置子控件的frame
            int maxColumns = (photos.count == 4) ? 2 : 3;
            int col = i % maxColumns;
            int row = i / maxColumns;
            
            CGFloat photoX = col * (IWPhotoW + IWPhotoMargin);
            CGFloat photoY = row * (IWPhotoH + IWPhotoMargin);
            photoView.frame = CGRectMake(photoX, photoY, IWPhotoW, IWPhotoH);
            
            // Aspect : 按照图片的原来宽高比进行缩
            // UIViewContentModeScaleAspectFit : 按照图片的原来宽高比进行缩放(一定要看到整张图片)
            // UIViewContentModeScaleAspectFill :  按照图片的原来宽高比进行缩放(只能图片最中间的内容)
            // UIViewContentModeScaleToFill : 直接拉伸图片至填充整个imageView
            
            if (photos.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            } else {
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        } else { // 隐藏imageView
            photoView.hidden = YES;
        }
    }
    
}
+ (CGSize)photosViewSizeWithPhotosCount:(int)count
{
    // 一行最多有3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    //  总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * IWPhotoH + (rows - 1) * IWPhotoMargin;
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = cols * IWPhotoW + (cols - 1) * IWPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
    
}
@end
