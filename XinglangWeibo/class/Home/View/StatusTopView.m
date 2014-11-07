//
//  StatusTopView.m
//  xinlangweibo
//
//  Created by admin on 14-11-3.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "StatusTopView.h"
#import "StatusFrame.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "RetweetView.h"
#import "Photo.h"
#import "PhotosView.h"
@interface StatusTopView ()
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) PhotosView *photosView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;
// 转发的微博
@property (nonatomic, strong) RetweetView *retweetView;
@end
@implementation StatusTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
        self.userInteractionEnabled = YES;
        /** 头像 */
        UIImageView *iconView = [[UIImageView alloc]init];
        [self addSubview:iconView];
        self.iconView = iconView;
        /** 会员图标 */
        UIImageView *vipView = [[UIImageView alloc]init];
        [self addSubview:vipView];
        self.vipView = vipView;
        
        /** 配图 */
        PhotosView *photosView = [[PhotosView alloc]init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        /** 昵称 */
        UILabel *nameLabel = [[UILabel alloc]init];
        [nameLabel setFont:IWStatusNameFont];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        /** 时间 */
        UILabel *timeLabel = [[UILabel alloc]init];
        [timeLabel setFont:IWStatusTimeFont];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        /** 来源 */
        UILabel *sourceLabel = [[UILabel alloc]init];
        [sourceLabel setFont:IWStatusSourceFont];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        /** 正文\内容 */
        UILabel *contentLabel = [[UILabel alloc]init];
        [contentLabel setFont:IWStatusContentFont];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        
        /** 被转发微博的view(父控件) */
        RetweetView *retweetView = [[RetweetView alloc]init];
        retweetView.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
        
        [self addSubview:retweetView];
        self.retweetView = retweetView;
    }
    return self;
}

- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    

    _statusFrame = statusFrame;
    Status *status = self.statusFrame.status;
    User *user = status.user;
    /** 头像 */
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithImageName:@"new_feature_background"]];
    [self.iconView setFrame:self.statusFrame.iconViewF];
    /** 会员图标 */
    if (user.vip) {
        self.vipView.hidden = NO;
        [self.vipView setImage:[UIImage imageWithImageName:@"common_icon_membership"]];
        [self.vipView setFrame:self.statusFrame.vipViewF];
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        
        self.vipView.hidden = YES;
    }
    
    /** 配图 */
    if (status.pic_urls.count) {
        self.photosView.hidden = NO;
        //        Photo *photo = status.pic_urls[0];
        //        [self.photosView setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithImageName:@"timeline_image_placeholder"]];
        [self.photosView setFrame:self.statusFrame.photoViewF];
        [self.photosView setStatus:status];
        
    }else {
        self.photosView.hidden = YES;
    }
    
    /** 昵称 */
    [self.nameLabel setText:user.name];
    [self.nameLabel setFrame:self.statusFrame.nameLabelF];
    /** 时间 */
    
    StatusFrame *statusFrame2 = self.statusFrame;
    [self.timeLabel setText:status.created_at];
    [self.timeLabel setFrame:[statusFrame2 timeLabelFrame]];
    /** 来源 */
    [self.sourceLabel setText:status.source];
    [self.sourceLabel setFrame:self.statusFrame.sourceLabelF];
    /** 正文\内容 */
    [self.contentLabel setText:status.text];
    [self.contentLabel setNumberOfLines:0];
    [self.contentLabel setFrame:self.statusFrame.contentLabelF];
    
    [self.retweetView setFrame:self.statusFrame.retweetViewF];
    [self.retweetView setStatusFrame:self.statusFrame];
}

@end
