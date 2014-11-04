//
//  RetweetView.m
//  xinlangweibo
//
//  Created by admin on 14-11-3.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "RetweetView.h"
#import "StatusFrame.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "Photo.h"
#import "MJExtension.h"
#import "PhotosView.h"
@interface RetweetView ()
/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) PhotosView *retweetPhotoView;
@end
@implementation RetweetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //  UIImageView *retweetView = [[UIImageView alloc]init];
        //  retweetView.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
        // [self.topView addSubview:retweetView];
        // self.retweetView = retweetView;
        
        self.userInteractionEnabled = YES;
        /** 被转发微博作者的昵称 */
        UILabel *retweetNameLabel = [[UILabel alloc]init];
        [retweetNameLabel setFont:IWRetweetStatusNameFont];
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        /** 被转发微博的正文\内容 */
        UILabel *retweetContentLabel = [[UILabel alloc]init];
        [retweetContentLabel setFont:IWRetweetStatusContentFont];
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        /** 被转发微博的配图 */
        PhotosView *retweetPhotoView = [[PhotosView alloc]init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;
        
    }
    return self;
}

- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    Status *status = self.statusFrame.status.retweeted_status;
    User *user = status.user;
    if (status) {
        [self setHidden:NO];
        /** 被转发微博作者的昵称 */
        [self.retweetNameLabel setText:user.name];
        [self.retweetNameLabel setFrame:self.statusFrame.retweetNameLabelF];
        /** 被转发微博的正文\内容 */
        [self.retweetContentLabel setText:status.text];
        [self.retweetContentLabel setNumberOfLines:0];
        [self.retweetContentLabel setFrame:self.statusFrame.retweetContentLabelF];
        
        /** 被转发微博的配图 */
        if (status.pic_urls.count) {
            [self.retweetPhotoView setHidden:NO];
            self.retweetPhotoView.status = status;
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
            
            //            Photo *photo = status.pic_urls[0];
            //            [self.retweetPhotoView setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithImageName:@"timeline_image_placeholder"]];
            
            
        }else{
            [self.retweetPhotoView setHidden:YES];
        }
    }else{
        [self setHidden:YES];
    }
}
@end
